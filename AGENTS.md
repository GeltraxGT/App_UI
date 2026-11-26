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

- Repo: https://github.com/GeltraxGT/App_UI.git (account: `GeltraxGT`, **private**)
- Remote `origin` is set to that URL.
- Commits use the noreply address `144154602+Geltrax69@users.noreply.github.com`.
- SSH (when used): `git config core.sshCommand "ssh -F /home/hatch/.ssh/config"`.
  Port 22 is blocked; SSH goes via `ssh.github.com:443` (see `~/.ssh/config`).
- Push only when the user says push in that run.

## Pushing (read this — plain `git push` does NOT work here)

- The GeltraxGT token is a surrogate the egress layer only swaps for
  `api.github.com`, not `github.com`, so `git push` over HTTPS fails
  with "invalid credentials". The SSH key belongs to Geltrax69, which
  has no access to this private GT repo.
- Push with the API instead: `python3 scripts/push-to-github.py "message"`.
  It builds blobs + tree + commit on top of remote main and moves main.
- The GT fine-grained PAT must list `App_UI` in its Repository access
  (user added it 2026-11-22; API then reported `push: true`).
- Remote SHAs differ from local SHAs (GitHub normalises commit dates
  to UTC) — trees/content are identical. Remote main after the first
  push: `f85c7914538fae7afb73be2a6f5f71593184b458` (README: School_UI).
  Do not "fix" the SHA difference by force-pushing local history.

## Layout

- `apps/` — one folder per app UI.
- `assets/` — shared reference images / design assets.
- `scripts/` — workspace helper scripts.
- `.agents/skills/` — workspace-local skills only (see above).
