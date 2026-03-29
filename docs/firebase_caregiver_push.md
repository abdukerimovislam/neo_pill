# Firebase Caregiver Push

This project now includes a minimal Firebase Functions sender for caregiver alerts.

## What it does

- Watches new documents in `care_networks/{shareCode}/alerts/{alertId}`
- Looks up linked `caregiver` members in `care_networks/{shareCode}/members`
- Sends FCM notifications to caregiver devices with saved `fcmToken`
- Writes back dispatch status to the alert document

## Required Firebase features

- Authentication: `Anonymous`
- Cloud Firestore
- Cloud Messaging
- Cloud Functions

## Deploy steps

1. Open a terminal in the project root.
2. Run `cd functions`
3. Run `npm install`
4. Run `cd ..`
5. Run `firebase deploy --only functions`

## Notes

- Cloud Functions typically requires the Blaze plan.
- This is the cheapest safe production path for true cross-device caregiver push.
- The app already writes caregiver link codes, cloud members, alert documents, and FCM tokens.
