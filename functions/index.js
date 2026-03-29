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

    const membersSnapshot = await admin
      .firestore()
      .collection("care_networks")
      .doc(shareCode)
      .collection("members")
      .where("role", "==", "caregiver")
      .get();

    const tokens = membersSnapshot.docs
      .map((doc) => doc.data().fcmToken)
      .filter((token) => typeof token === "string" && token.trim().length > 0);

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

    const title = "Caregiver alert";
    const body = alert.patientName
      ? `${alert.patientName}: medication routine needs attention`
      : "Medication routine needs attention";

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
          channelId: "caregiver_alerts",
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

    const response = await admin.messaging().sendEachForMulticast(message);

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
      const cleanupWrites = membersSnapshot.docs
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

    await snapshot.ref.set(
      {
        dispatchStatus:
          response.successCount > 0 ? "sent" : "failed",
        dispatchAttemptedAt: admin.firestore.FieldValue.serverTimestamp(),
        dispatchSuccessCount: response.successCount,
        dispatchFailureCount: response.failureCount,
      },
      { merge: true }
    );
  }
);
