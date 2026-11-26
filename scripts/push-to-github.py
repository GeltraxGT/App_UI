#!/usr/bin/env python3
"""Push the App_UIs working tree to GeltraxGT/App_UI via the GitHub API.

Why not plain `git push`: the GeltraxGT token is a surrogate that the
egress layer only swaps for api.github.com, not github.com, so git-over-
HTTPS auth fails with "invalid credentials" and the SSH key belongs to
Geltrax69, which has no access to this private GT repo. The REST API
(api.github.com) works fine with the same token.

What it does: builds the current working-tree state as blobs + tree +
commit on top of the remote main HEAD (read via the API), then moves
main to it. Local git SHAs will differ from remote SHAs (GitHub
normalises commit dates to UTC), but trees/content are identical.
Run from anywhere: python3 scripts/push-to-github.py "commit message"

Usage: push-to-github.py "commit message"
"""
import base64
import subprocess
import sys

sys.path.insert(0, "/home/hatch/workspace/custom-connectors/custom.github-geltraxgt/bin")
from backfill import api

OWNER = "GeltraxGT"
REPO = "App_UI"
SRC = "/home/hatch/workspace/App_UIs"
AUTHOR = {"name": "Geltrax69", "email": "144154602+Geltrax69@users.noreply.github.com"}


def git(*args, text=True):
    return subprocess.check_output(["git", "-C", SRC, *args], text=text)


def main():
    if len(sys.argv) < 2:
        print("usage: push-to-github.py \"commit message\"", file=sys.stderr)
        sys.exit(2)
    message = sys.argv[1]
    remote_head = api("GET", f"/repos/{OWNER}/{REPO}/git/ref/heads/main")["object"]["sha"]
    print(f"remote main: {remote_head[:7]}")
    entries = []
    tracked = git("ls-files").strip().splitlines()
    for path in tracked:
        if path.startswith(".git"):
            continue
        content = subprocess.check_output(["git", "-C", SRC, "show", f":{path}"])
        try:
            text = content.decode("utf-8")
            blob = api("POST", f"/repos/{OWNER}/{REPO}/git/blobs",
                       {"content": text, "encoding": "utf-8"})
        except UnicodeDecodeError:
            blob = api("POST", f"/repos/{OWNER}/{REPO}/git/blobs",
                       {"content": base64.b64encode(content).decode(), "encoding": "base64"})
        mode = git("ls-files", "-s", path).split()[0]
        entries.append({"path": path, "mode": mode, "type": "blob", "sha": blob["sha"]})
    tree = api("POST", f"/repos/{OWNER}/{REPO}/git/trees", {"tree": entries})
    commit = api("POST", f"/repos/{OWNER}/{REPO}/git/commits", {
        "message": message, "tree": tree["sha"], "parents": [remote_head],
        "author": AUTHOR, "committer": AUTHOR})
    api("PATCH", f"/repos/{OWNER}/{REPO}/git/refs/heads/main",
        {"sha": commit["sha"], "force": False})
    print(f"pushed: {commit['sha']}")
    print(f"https://github.com/{OWNER}/{REPO}/commit/{commit['sha']}")


if __name__ == "__main__":
    main()
