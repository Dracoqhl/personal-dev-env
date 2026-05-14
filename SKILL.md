---
name: personal-dev-env
description: Use when configuring, restoring, verifying, repairing, or updating the user's personal development environment on the current device, including agent tooling, Python research environments, Docker-based services, and persistent setup preferences.
---

# Personal Dev Env

## Purpose

Maintain the user's personal development environment as a lightweight, dynamic set of environment workflows and preferences. This skill records what the user wants restored on the current device; it does not hard-code every installation command.

## Core Workflow

1. Read [references/environment-workflows.md](references/environment-workflows.md) and [references/preferences.md](references/preferences.md).
2. Inspect the current device enough to identify OS, distribution, architecture, package manager, permissions, existing tools, and service state.
3. Generate one consolidated checklist plan before changing anything:
   - detected device facts
   - workflows/components checked
   - default selected items
   - items that are skipped because they already pass verification
   - items that need installation, repair, or more deployment details
   - any data, service, or secret risk
4. Ask the user to confirm or edit the checklist once for the whole run.
5. Execute only the selected checklist items.
6. Ask again only for destructive or high-risk actions such as deleting data, recreating services, replacing existing environments, or overwriting configuration.
7. After changes, verify affected workflows and summarize the final state.

## Updating This Skill

When the user mentions a new tool, service, exception, or preference that should persist, update this repository using [references/update-protocol.md](references/update-protocol.md). Prefer editing the reference files instead of expanding this `SKILL.md`.

## Scope

- Set up the current device, not an abstract target platform.
- Detect the current OS before choosing installation commands. Linux server workflows are currently the maintained path; unsupported systems should be reported instead of guessed.
- Assume Codex is already available. If it is not, the minimal bootstrap path is manual Node.js installation followed by installing Codex.
- Do not treat every command found on the current machine as part of the personal environment. Record capabilities and workflows the user intentionally wants restored.

## Safety

- Do not commit secrets, API tokens, auth files, SSH private keys, shell history, logs, generated state, or local Codex databases.
- Preserve existing environments, containers, volumes, and config files by default.
- Prefer verification and repair over reinstall.
- Reinstall, remove, or recreate only after explicit confirmation.
