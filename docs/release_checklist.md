# Pillora Release Checklist

## Product
- Verify onboarding flow on first launch in English and Russian.
- Verify Comfort mode changes typography and controls across Home, Analytics, and Settings.
- Verify Home correctly shows medications and supplements in one chronological timeline.
- Verify routine bundles feel clear and readable for morning, afternoon, evening, and night use.
- Verify doctor report export includes patient name, course details, and human-readable schedule data.
- Verify low-stock warnings, overdue doses, and hero card behavior on real device time.

## Notifications
- Verify permission prompt on first launch.
- Verify dose action buttons from notifications update the correct log.
- Verify pause/resume medication clears and restores reminders correctly.
- Verify snooze creates a follow-up reminder with the correct dose payload.
- Verify smart reminder copy sounds correct for both medications and supplements.

## Data
- Test add, edit, pause, resume, and delete medication.
- Test add, edit, pause, resume, and delete supplement courses.
- Test daily, interval, specific-day, cycle, SOS, and tapering schedules.
- Test complex schedules with different doses at different times of day.
- Test app relaunch persistence for language, theme, comfort mode, onboarding, and course filters.

## QA
- Run `flutter analyze`.
- Run `flutter test`.
- Smoke-test Android notification behavior on a physical device.
- Smoke-test PDF share flow on Android and iOS.

## Store
- Capture screenshots for Home timeline, routine bundles, Analytics, onboarding, and course detail.
- Publish privacy policy URL and confirm support contact.
- Confirm app name, subtitle, keywords, and short description.
- Review icon, splash, and final build number before upload.
