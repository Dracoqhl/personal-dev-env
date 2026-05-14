# Environment Workflows

This file records the user's desired development environment as recoverable workflows. Keep it lightweight: record capabilities, dependencies, verification targets, and important preferences. Do not turn it into a complete installation manual.

## Bootstrap Assumption

Codex is already available on the current device. If Codex is not available, the minimal bootstrap path is manual Node.js installation followed by installing Codex globally. After Codex is available, this skill should inspect the current device and generate a setup plan from the workflows below.

## Run Interaction

Before installing or repairing anything, present one consolidated checklist for the whole run. The checklist should include detected device facts, workflow status, default selected actions, skipped items, and items needing more details.

Use a format the user can edit in chat:

```markdown
Detected device:
- OS: <detected OS and version>
- Arch: <detected architecture>
- Package manager: <detected package manager or unknown>
- Privilege model: <root/sudo/user>

Setup plan:

[x] Core Agent Tooling
    - Node.js: present
    - npm: present
    - pnpm: missing -> install
    - Codex CLI: missing -> install

[x] Python Research Environment
    - Miniconda: missing -> install
    - conda env `phd`: missing -> create with Python 3.9

[x] Container Runtime
    - Docker: missing -> install
    - Docker Compose: missing -> install

[ ] Nginx Proxy Manager
    - depends on Docker
    - deployment details needed before first install
```

Proceed only after the user confirms or edits the checklist. Do not ask before every individual install step. Ask again only for destructive or high-risk actions such as deleting data, recreating services, replacing existing environments, or overwriting configuration.

## Core Agent Tooling

Required capability:

- Node.js runtime
- npm
- pnpm
- OpenAI Codex CLI (`@openai/codex`)

Workflow:

1. Verify Node.js and npm.
2. Verify pnpm.
3. Verify Codex CLI.
4. Include missing or broken components in the consolidated checklist.

Notes:

- Do not pin versions unless the user adds a compatibility requirement.

## Python Research Environment

Required capability:

- Miniconda
- Conda environment named `phd`
- Python 3.9 inside `phd`

Workflow:

1. Verify `conda`.
2. If missing, include Miniconda installation in the consolidated checklist.
3. Verify Conda environment `phd`.
4. If `phd` is missing, include creating it with Python 3.9 in the consolidated checklist.
5. If `phd` exists but Python is not 3.9, ask before modifying or recreating it.

Current observed state:

- Miniconda path: `/root/miniconda3`
- `phd` environment exists.
- `phd` Python version observed: 3.9.25.

## Container Runtime

Required capability:

- Docker
- Docker Compose plugin

Workflow:

1. Verify Docker CLI.
2. Verify Docker daemon access.
3. Verify `docker compose`.
4. Include missing installation or permission repair in the consolidated checklist.

## Nginx Proxy Manager

Required service:

- Nginx Proxy Manager

Dependency:

- Docker must be working first.

Workflow:

1. Verify Docker is installed and daemon access works.
2. Check whether an Nginx Proxy Manager container or compose deployment exists.
3. If missing, include it as unchecked or needing details unless deployment preference is already known.
4. Preserve existing volumes, configuration, ports, and data when repairing.
5. Do not delete, recreate, or replace containers without explicit confirmation.

Current observed state:

- Container: `1Panel-nginx-proxy-manager-3ymo`
- Image: `jc21/nginx-proxy-manager:2.14.0`
- Status: running
- Ports: `30080->80`, `30081->81`, `3389->443`

## Basic CLI Utilities

Supporting utilities:

- git
- curl
- wget
- jq
- tmux
- vim
- ripgrep

Workflow:

1. Verify presence when needed by another workflow or when the user asks for a full environment check.
2. Install missing utilities only as supporting dependencies for active workflows.
3. Do not treat OS-provided basics such as `ssh` as personal environment tools unless the user explicitly asks.
