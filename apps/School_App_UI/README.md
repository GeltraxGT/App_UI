# School_App_UI

School app UI for Simpedu — 16 parent + 10 teacher screens.

- `BASELINE.md` — Flutter baseline, verified 2026-11-22 (analyze 0 issues, tests 20/20), plus the redesign done in Simpedu_AppW.
- `DESIGN_TOKENS.md` — design tokens, single source of truth (colours, type, shape, 31 frames at 390×844).

## Fresh Flutter UI — built 2026-11-27

Standalone rebuild of the 9-screen watercolor parent UI from the reference
image (package `school_app_ui`, single `lib/main.dart`): Home, Academics,
Attendance, Fees & Payments, Timetable, Announcements, Messages, More
Services, Profile — 5-tab bottom nav, all screens reachable by tapping,
sample data exactly as the reference. Four watercolor illustrations in
`assets/images/` (girl with backpack, girl reading, portrait avatar, book
stack). Verified: `flutter analyze` 0 issues, `flutter test` 11/11 green
(incl. 390×844 home golden), `flutter build web` succeeds. Live look on a
real phone is still unverified.
