---
name: personal-dev-env
description: Use when configuring, restoring, verifying, repairing, or updating the user's personal Linux development environment, including agent tooling, Python research environments, Docker-based services, and persistent setup preferences.
---

# Personal Dev Env

## Purpose

Maintain the user's personal development environment as a lightweight, dynamic set of environment workflows and preferences. This skill records what the user wants restored on a Linux server; it does not hard-code every installation command.

## Core Workflow

1. Read [references/environment-workflows.md](references/environment-workflows.md) and [references/preferences.md](references/preferences.md).
2. Inspect the target Linux environment enough to classify each workflow as present, missing, broken, or needing user input.
3. Show the user a concise plan before changing anything:
   - workflows/components checked
   - what will be skipped
   - what will be installed or repaired
   - any data, service, or secret risk
4. Wait for confirmation before installing, repairing, removing, recreating, or changing services.
5. After changes, verify affected workflows and summarize the final state.

## Updating This Skill

When the user mentions a new tool, service, exception, or preference that should persist, update this repository using [references/update-protocol.md](references/update-protocol.md). Prefer editing the reference files instead of expanding this `SKILL.md`.

## Scope

- Default target platform: Linux.
- No Windows workflow is maintained for now.
- Assume Codex is already available. If it is not, the minimal bootstrap path is manual Node.js installation followed by installing Codex.
- Do not treat every command found on the current machine as part of the personal environment. Record capabilities and workflows the user intentionally wants restored.

## Safety

- Do not commit secrets, API tokens, auth files, SSH private keys, shell history, logs, generated state, or local Codex databases.
- Preserve existing environments, containers, volumes, and config files by default.
- Prefer verification and repair over reinstall.
- Reinstall, remove, or recreate only after explicit confirmation.
