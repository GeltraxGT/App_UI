# AGENTS.md — App_UIs

## Scope rule (user-set, 2026-11-22)

**Skills for this workspace are workspace-local only.**

- Install any skill the user asks for in this workspace into
  `App_UIs/.agents/skills/<skill-name>/` as a real directory.
- Do NOT install it into `~/workspace/custom-skills/` (global).
- Do NOT symlink the global harness bundles into this workspace
  (no `bootstrap-new-project.sh`, no global-harness / pstack /
  local-* symlinks here). This workspace deliberately does not
  use the global harness.
- Do NOT copy a skill out of this workspace into another project
  or into the global set without the user explicitly asking.
- Record every install in `SKILLS.md` (name, source, date, what it is for).

## GitHub

- Repo: https://github.com/GeltraxGT/App_UI.git (account: `GeltraxGT`)
- Remote `origin` is set to that URL.
- Commits use the noreply address `144154602+Geltrax69@users.noreply.github.com`.
- SSH (when used): `git config core.sshCommand "ssh -F /home/hatch/.ssh/config"`.
  Port 22 is blocked; SSH goes via `ssh.github.com:443` (see `~/.ssh/config`).
- Push only when the user says push in that run.

## Layout

- `apps/` — one folder per app UI.
- `assets/` — shared reference images / design assets.
- `scripts/` — workspace helper scripts.
- `.agents/skills/` — workspace-local skills only (see above).
