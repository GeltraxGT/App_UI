# School_UI — Flutter baseline (verified 2026-11-22)

Source app: `~/workspace/work/Simpedu_AppW` (Geltrax69/Simpedu_AppW, `main`).
It already implements the full spec in the user's brief — 16 parent + 10 teacher
screens, demo backend, login/change-password/splash, shared states
(loading shimmer / empty / error / offline).

Baseline check, 2026-11-22 ~02:00 IST, Flutter 3.47.6 (`~/flutter-sdk`):
- `flutter analyze`: **0 issues**
- `flutter test`: **20/20 passed**

Existing brand tokens (`lib/core/theme/app_colors.dart`): indigo ramp
(`#5B67E8` primary) + warm neutrals + green/amber/red status ramps; brand
gradient (blue → violet) reserved for hero moments, login block, primary buttons.

Flutter phase = redesign to the new Figma direction (bold headings, floating
pill glass bottom nav, pastel stat cards, large numerals, rounded cards),
for iOS, Android, iPad, Android tablet — not a from-zero build.
Blocked on: Figma design (Figma write access still read-only; see todo list)
or the user's pick from the options offered 2026-11-22.

## Redesign DONE 2026-11-22 (Flutter phase, in place in Simpedu_AppW, unpushed)

- Theme: Inter variable font bundled (`assets/fonts/Inter-Variable.ttf`),
  type scale 28/24/20/16/14/12 Bold headers, gutter 20, pill radius 999,
  `pastelRose` `#FBE3E8` (fixes the rose/error-soft collision),
  `ctaBlack` `#111111`, `navShadow` (black 12%, y8, blur 24).
- New shared widgets: `FloatingNav` (350x60 pill), `StatCard`, `StatusPill`/
  `PillTone` (canonical home; `StatusTone` kept as typedef), `FilterChipRow`,
  `AdaptiveContent` (max-width 700) + `isTablet`.
- All 16 parent + 11 teacher screens restyled + both shells on the floating
  nav; tablet layouts via `AdaptiveContent` (stat grids widen, lists centred).
- One behaviour addition (matches spec §11): parent chat thread now has
  input + send, mirroring the teacher side. No other behaviour/copy changes;
  the flagged "2 working days" copy was NOT added.
- Verification: `flutter analyze` 0 issues, `flutter test` 20/20 green
  (4 goldens regenerated: design_components, login, fees, profile).
  Screenshot check of parent Home, parent Homework, teacher Home renders
  correctly (golden-test text blocks aside). No images generated — the
  design uses gradient + icons only, no photographic art needed.
- Left / open: trend card hides below 3 exams in code vs spec "hidden with
  one exam" (product call); homework detail has no attachments field in the
  data layer; Figma quick-action subtitles / teacher profile Classes row /
  marks student counts not added (data doesn't exist, no invented copy);
  real-device feel untested.
