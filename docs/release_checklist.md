# NeoPill Release Checklist

## Product
- Verify onboarding flow on first launch in English and Russian.
- Verify Comfort mode changes typography and controls across Home, Analytics, and Settings.
- Verify caregiver profile can be added, edited, and removed from Settings.
- Verify doctor report export includes patient name and caregiver details when enabled.
- Verify low-stock warnings, overdue doses, and hero medication behavior on real device time.

## Notifications
- Verify permission prompt on first launch.
- Verify dose action buttons from notifications update the correct log.
- Verify pause/resume medication clears and restores reminders correctly.
- Verify snooze creates a follow-up reminder with the correct dose payload.

## Data
- Test add, edit, pause, resume, and delete medication.
- Test daily, interval, specific-day, cycle, SOS, and tapering schedules.
- Test app relaunch persistence for language, theme, comfort mode, onboarding, and caregiver profile.

## QA
- Run `flutter analyze`.
- Run `flutter test`.
- Smoke-test Android notification behavior on a physical device.
- Smoke-test PDF share flow on Android and iOS.

## Store
- Capture screenshots for Home, Analytics, Settings, onboarding, and medication detail.
- Prepare privacy policy URL and support contact.
- Confirm app name, subtitle, keywords, and short description.
- Review icon, splash, and final build number before upload.
