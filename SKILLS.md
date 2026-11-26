# Skills — App_UIs (workspace-local only)

Rule (user-set 2026-11-22): every skill installed for this workspace
lives only in `App_UIs/.agents/skills/` as real directories (copies, no
symlinks). Nothing installed here goes to `~/workspace/custom-skills/`
or any other workspace, and no global harness skill is symlinked in.
Installed skills are **not** committed to the App_UI GitHub repo
(see `.gitignore`) — they are workspace tooling, ~40 MB, mostly the
taste skill's reference photos.

## Installed — 2026-11-22 (26 skills)

### vercel-labs/ui — UI SDK (upstream `06a7633`, 2026-11-21)
Source: https://github.com/vercel-labs/ui.git
`ui-sdk` is the skill for building *with* ui-sdk; the other four are
for working *on* ui-sdk itself and read `.agents/experts/<framework>/`
(copied here as `App_UIs/.agents/experts/` — react, vue, svelte,
solid, web).

| Skill | For |
| ----- | --- |
| `ui-sdk` | Build interfaces with @ui-sdk/* in React, Vue, Svelte, Solid, web components |
| `ui-sdk-write-code` | Write/change ui-sdk code the ui-sdk way |
| `ui-sdk-write-docs` | Write/review ui-sdk docs |
| `ui-sdk-unslop` | Clean up a diff / generated-looking file |
| `ui-sdk-expert-review` | Pre-merge expert review per framework |

### emilkowalski/skills — Skills For Designers and Engineers (upstream `64eb3de`, 2026-11-15)
Source: https://github.com/emilkowalski/skills.git — all 20 skills.

| Skill | For |
| ----- | --- |
| `emil-design-eng` | Main skill: animation + design advice |
| `animate` | Build an animation from scratch (curve, duration, properties) |
| `animate-expo` | Same bar for React Native / Expo |
| `review-animations` | Strict animation review |
| `improve-animations` | Audit all animations, prioritised fix plans |
| `find-animation-opportunities` | Where motion would genuinely help (and where not) |
| `remove-animations` | Remove animations the app doesn't need |
| `choreograph` | Coordinate several elements animating together |
| `animation-performance` | Fix dropped frames |
| `animation-vocabulary` | The right words to ask an AI for an animation |
| `apple-design` | Apple's design + fluid-motion principles, for the web |
| `gestures` | Drag / swipe / sheet interactions |
| `pick-ui-library` | Pick the right UI library instead of hand-rolling |
| `prototype` | Build several versions of a UI piece, switch between them |
| `mobile-native` | Make a web app feel native on a phone |
| `break-ui` | Stress-test UI with worst-case data |
| `learn-taste` | Collect session design corrections into `DESIGN.md` rules |
| `ask-emil` | Which skill / sequence to use |
| `ask-sonner` | Sonner toast library guide |
| `write-swift` | Swift UI work |

### Leonxlnx/taste-skill — tasteskill 2.5.1 (upstream `f6b7657`, 2026-11-07)
Source: https://github.com/Leonxlnx/taste-skill.git
Installed as `design-taste-frontend` (its frontmatter `name:`; the
repo folder is `skills/taste-skill`). The anti-slop frontend skill:
professional company sites at figma.com / x.ai level, one section per
screen, real photographs, a checker + finish gate in a real browser.
Needs Node 22+ and Chrome/Edge/Chromium. Installed as a real copy,
not via its `install.sh` (that symlinks into `~/.claude/skills`,
which would be global — explicitly not done here).

| Skill | For |
| ----- | --- |
| `design-taste-frontend` | Build / redesign / polish / review landing, company, product, shop, SaaS, AI, dev-tool, game sites |

## Installed — 2026-11-22, second batch (39 skills, total now 65)

Installed as real copies into `.agents/skills/`, not via `npx skills
add` (that installs globally into `~/.claude/skills` — explicitly
not done here).

### INSANE0777/awwwards-skills — only `awwwwards-inspiration` (upstream `b58588a`, 2026-11-19)
Source: https://github.com/INSANE0777/awwwards-skills.git
The repo has 9 skills; only the one named in the install command was
taken. **Dependency, not installed:** the skill works through the
`awwwards` MCP server (`search_sites`, `capture_live_site`, …) and
says to run the `awwwards-setup` skill first on a new machine —
neither the MCP server nor `awwwards-setup` is set up in this
workspace yet.

| Skill | For |
| ----- | --- |
| `awwwards-inspiration` | Design references from award-winning sites; inspiration research, trending styles |

### mrstev3n/balise-skills — only `balise-visual-references` (upstream `f596a61`, 2026-08-19)
Source: https://github.com/mrstev3n/balise-skills.git
Taken from `skills/` (the full version with `references/` +
`scripts/search_catalog.py`), not the thinner `figma-skills/` copy.

| Skill | For |
| ----- | --- |
| `balise-visual-references` | Find, select, analyse visual references; turn examples into transferable design principles, not copies |

### android/skills — all 37 skills (upstream `c729425`, 2026-11-15)
Source: https://github.com/android/skills.git
The repo nests skills under categories (`camera/`, `jetpack-compose/`,
…); they are flattened here by skill name (no two share a name) so
they sit alongside the others in `.agents/skills/`.

| Skill | For |
| ----- | --- |
| `agp-9-upgrade` | Upgrade to AGP 9 |
| `android-cli` | Android CLI devtools |
| `android-for-cars-parked-apps` | Parked apps for cars |
| `android-profiler` | Profiling |
| `anr-audit-and-fix` | ANR audit + fix |
| `appfunctions` | App Functions |
| `camerax` | CameraX |
| `adaptive` | Adaptive Jetpack Compose layouts |
| `edge-to-edge` | Edge-to-edge |
| `engage-sdk-integration` | Engage SDK |
| `glance-appwidget-updates-and-memory` | Glance app widgets |
| `glance-canonical-layouts` | Glance canonical layouts |
| `ink-app-builder` | Ink app builder |
| `ink-custom-brush-builder` | Ink custom brush builder |
| `ios-to-android` | iOS → Android migration |
| `jetpack-compose-performance` | Compose performance |
| `leanback-to-compose-tv-migration` | Leanback → Compose TV migration |
| `litert-lm` | LiteRT LM |
| `litert-runtime` | LiteRT runtime |
| `media3-cast-integration` | Media3 Cast |
| `migrate-xml-views-to-jetpack-compose` | XML views → Compose migration |
| `ml-kit-genai-prompt-api` | ML Kit GenAI prompt API |
| `mlkit-agent-api` | ML Kit agent API |
| `navigation-3` | Navigation 3 |
| `navigation-event` | Navigation events |
| `play-billing-library-version-upgrade` | Play Billing Library upgrade |
| `play-policy-insights` | Play policy insights |
| `projected-hardware` | Projected hardware (XR) |
| `display-glasses-with-jetpack-compose-glimmer` | Display glasses with Compose Glimmer |
| `r8-analyzer` | R8 analyzer |
| `restore-credentials` | Restore credentials |
| `android-intent-security` | Intent security |
| `android-permissions-security` | Permissions security |
| `testing-setup` | Testing setup |
| `verified-email` | Verified email |
| `wear-compose-m3` | Wear Compose M3 |
| `wear-widgets` | Wear widgets |

## Installed — 2026-11-22, third batch (3 skills, total now 68)

### oil-oil/oil-ui — `oil-ui` 0.34.5 (upstream `a334346`, 2026-11-21)
Source: https://github.com/oil-oil/oil-ui.git
Installed as a real copy (SKILL.md + assets + references + scripts)
after the user explicitly approved it — the repo was flagged by a
safety check because the skill's scripts can run code, so nothing
from it was executed during install. The skill itself runs its
`check_update` script as part of its workflow; that is its own
documented behaviour, not something run here.

| Skill | For |
| ----- | --- |
| `oil-ui` | UI/UX design workflow: visual direction, 3-direction comparisons, DESIGN.md conflict checks, real-browser screenshot review |

### shadcn-ui/ui — both skills (upstream `bfa64ff`, 2026-11-21)
Source: https://github.com/shadcn-ui/ui.git

| Skill | For |
| ----- | --- |
| `shadcn` | Build with shadcn/ui components, CLI, registry, customization, design system |
| `migrate-radix-to-base` | Migrate Radix-based components to shadcn Base UI |

## Updating

Re-clone the upstream repo, copy the changed skill folder(s) over the
ones here, and update the upstream SHA + date above. Never
`install.sh` / `npx skills add` with a global target for this
workspace.
