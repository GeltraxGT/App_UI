# School_UI — Design tokens (single source of truth)

Extracted 2026-11-22 from the Figma screen scripts
(`~/workspace/figma-pb/helpers.js`, `figma-parent-a/`, `figma-teacher/`,
`figma-simpedu-p16-p19.js`) and verified against
`~/workspace/work/Simpedu_AppW/lib/core/theme/app_colors.dart`.
Use these values for the Flutter rebuild — do not re-derive them from screenshots.

## Colour tokens

| Token | Hex | Role |
|---|---|---|
| `page` | `#F6F5F1` | Screen background |
| `surface` | `#FFFFFF` | Cards, nav, sheets |
| `ink` | `#1C1B22` | Primary text |
| `sec` | `#6E6E66` | Secondary text |
| `ter` | `#8F8F86` | Tertiary text |
| `out` / `outs` | `#E8E6E0` / `#D8D8D1` | Borders, dividers |
| `black` | `#111111` | CTA buttons |
| `ind500` | `#5B67E8` | Brand primary |
| `ind600` | `#434ED8` | Brand dark / active nav icon |
| `indsoft` | `#EEF0FE` | Active nav pill background |
| `onind` | `#2F3594` | Text on indigo-soft |
| `sky` | `#E0E4FD` | Indigo tint |
| `g1 → g2` | `#3B82F6 → #8B5CF6` | Brand gradient (heroes, primary buttons, selected tabs) |
| `ok` / `oksoft` / `onok` | `#178A4C` / `#DDF3E4` / `#116B3B` | Success |
| `warn` / `warnsoft` / `onwarn` | `#B45309` / `#FDEFD3` / `#92400E` | Warning / leave |
| `err` / `errsoft` / `onerr` | `#D92D20` / `#FDE4E2` / `#B42318` | Error / absent |
| `mint` | `#DDF3E4` | Pastel stat tint (= oksoft) |
| `amber` | `#FDEFD3` | Pastel stat tint (= warnsoft) |
| `rose` | `#FBE3E8` | Pastel stat tint — **chosen 2026-11-22 in the Flutter rebuild** to resolve the collision with `errsoft` `#FDE4E2` (dark: `#3D1F2B`). |

## Type

- Family: **Inter** (Regular / Medium / Semi Bold / Bold / Extra Bold).
- Scale in use: 28 / 24 / 20 / 16 / 14 / 12, nav labels 11 Semi Bold.
- Screen header: 24 Bold ink + 14 Regular secondary below it.
- Detail header (with back): 20 Bold ink + 14 Regular secondary.

## Shape & layout

- Phone frame: **390 × 844**, page background, clips content.
- Screen margin: **20** on both sides; content width 350.
- Cards: radius **24**, white surface.
- Pills/chips: radius **999** (fully round).
- Floating bottom nav: 350 × 60 at (20, 764), radius 999, white, soft shadow
  (y 8, radius 24, black 12%). Active tab: indigo-soft pill + indigo icon,
  11pt Semi Bold label. Parent tabs: Home / Homework / Fees / More.
  Teacher tabs: Home / Attendance / Homework / More.
- Detail screens have **no** bottom nav (per Parent A pattern).

## Frames (31, all 390×844)

- Parent A: P-01 Splash, P-02 Login, P-03 Home, P-04 Homework, P-05 Homework
  detail, P-06 Fees, P-07 Invoice detail (+ change-password frame).
- Parent B: P-08 Attendance, P-09 Results, P-10 Exam detail, P-11 Timetable,
  P-12 Notifications, P-13 Help desk, P-14 Ticket detail, P-15 Create ticket.
- Parent C: P-16 Messages, P-17 Chat thread, P-18 Profile, P-19 More menu.
- Teacher: T-01 Home, T-02 Attendance marking, T-03 Homework, T-04 Assign
  homework, T-05 Marks entry, T-06 Marks form, T-07 Fee collection,
  T-08 Capture photos, T-09 Messages, T-10 Profile, T-11 More menu.

Screen scripts (ready to run when Figma MCP quota returns):
`~/workspace/figma-parent-a/`, `~/workspace/figma-pb/` (`run.py all`),
`~/workspace/figma-simpedu-p16-p19.js`, `~/workspace/figma-teacher/`
(`driver.py`). All syntax-verified 2026-11-22 (wrapped-async check).
