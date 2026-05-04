---
name: personal-dev-env
description: Bootstrap and maintain the user's personal development environment across Linux and Windows. Use when Codex is asked to install, verify, repair, or document the user's preferred dev tools, currently Miniconda, CC Switch, tmux, and git. Always start by asking whether the target platform is Linux or Windows when it is not already explicit; Linux is implemented first, while Windows is limited to planning and UI-oriented guidance.
---

# Personal Dev Env

## Core Workflow

Start by identifying the target platform.

- If the user did not specify a platform, ask one concise question: `Which platform should I set up: Linux or Windows?`
- Only support `linux` and `windows` for now. If the user names another platform, say it is not supported yet and ask them to choose Linux or Windows.
- For Linux implementation details, read [references/linux.md](references/linux.md).
- For Windows planning details, read [references/windows.md](references/windows.md).

Before installing anything, inspect the environment and existing tools:

```bash
uname -a
cat /etc/os-release 2>/dev/null
command -v conda || true
command -v git || true
command -v tmux || true
command -v cc-switch-web || true
```

Prefer idempotent actions: verify first, install only missing components, and avoid overwriting user config files without explicit permission.

## Current Tool Set

Install and verify only these tools unless the user expands the skill:

- Miniconda
- CC Switch
- tmux
- git

For Linux, use [scripts/bootstrap-linux.sh](scripts/bootstrap-linux.sh) when the user wants an automated setup and shell execution is appropriate. Read or patch the script before using it if the user asks for behavior changes.

For Windows, do not pretend the installer is implemented. Provide the supported plan from [references/windows.md](references/windows.md), then ask before creating PowerShell or UI automation resources.

## Safety

- Ask before running commands that install packages, download binaries, modify shell startup files, or require elevated privileges.
- Use dry-run or verification mode first when available.
- Preserve existing Conda installations unless the user explicitly asks to replace them.
- Report exact installed versions at the end.
