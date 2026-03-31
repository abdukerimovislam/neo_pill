const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendCaregiverAlert = onDocumentCreated(
  {
    document: "care_networks/{shareCode}/alerts/{alertId}",
    region: "us-central1",
  },
  async (event) => {
    const snapshot = event.data;
    if (!snapshot) {
      logger.warn("Alert trigger fired without document snapshot");
      return;
    }

    const alert = snapshot.data();
    const shareCode = event.params.shareCode;

    // 1. Находим всех опекунов для этой сети
    const membersSnapshot = await admin
      .firestore()
      .collection("care_networks")
      .doc(shareCode)
      .collection("members")
      .where("role", "==", "caregiver")
      .get();

    const tokens = [];
    const validDocs = []; // Сохраняем ссылки на документы, чтобы потом удалить битые токены

    membersSnapshot.docs.forEach((doc) => {
      const token = doc.data().fcmToken;
      if (typeof token === "string" && token.trim().length > 0) {
        tokens.push(token);
        validDocs.push(doc);
      }
    });

    if (tokens.length === 0) {
      logger.info("No caregiver FCM tokens found", { shareCode });
      await snapshot.ref.set(
        {
          dispatchStatus: "no_tokens",
          dispatchAttemptedAt: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true }
      );
      return;
    }

    // 2. Формируем универсальное сообщение
    const title = "Внимание: Pillora";
    const body = alert.patientName
      ? `${alert.patientName}: пропуск или задержка приема`
      : "Режим лечения требует внимания";

    const message = {
      tokens,
      notification: {
        title,
        body,
      },
      data: {
        shareCode,
        alertId: event.params.alertId,
        patientName: String(alert.patientName || ""),
        itemCount: String(alert.itemCount || 0),
        type: "caregiver_alert",
      },
      android: {
        priority: "high",
        notification: {
          channelId: "caregiver_alerts", // Важно для Android!
          priority: "max",
        },
      },
      apns: {
        payload: {
          aps: {
            sound: "default",
          },
        },
      },
    };

    // 3. Отправляем пуши сразу всем
    const response = await admin.messaging().sendEachForMulticast(message);

    // 4. Очищаем невалидные токены (если кто-то удалил приложение)
    const invalidTokens = [];
    response.responses.forEach((result, index) => {
      if (!result.success) {
        logger.warn("Failed caregiver FCM delivery", {
          shareCode,
          token: tokens[index],
          error: result.error?.message,
        });
        const code = result.error?.code || "";
        if (
          code === "messaging/invalid-registration-token" ||
          code === "messaging/registration-token-not-registered"
        ) {
          invalidTokens.push(tokens[index]);
        }
      }
    });

    if (invalidTokens.length > 0) {
      const cleanupWrites = validDocs
        .filter((doc) => invalidTokens.includes(doc.data().fcmToken))
        .map((doc) =>
          doc.ref.set(
            {
              fcmToken: admin.firestore.FieldValue.delete(),
              updatedAt: admin.firestore.FieldValue.serverTimestamp(),
            },
            { merge: true }
          )
        );
      await Promise.all(cleanupWrites);
    }

    // 5. Отмечаем статус в самом алерте
    await snapshot.ref.set(
      {
        dispatchStatus: response.successCount > 0 ? "sent" : "failed",
        dispatchAttemptedAt: admin.firestore.FieldValue.serverTimestamp(),
        dispatchSuccessCount: response.successCount,
        dispatchFailureCount: response.failureCount,
      },
      { merge: true }
    );
  }
);