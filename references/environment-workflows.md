# Environment Workflows

This file records the user's desired development environment as recoverable workflows. Keep it lightweight: record capabilities, dependencies, verification targets, and important preferences. Do not turn it into a complete installation manual.

## Baseline Assumption

Codex is already available on the target machine. If Codex is not available, the user can manually install Node.js first, then install Codex globally.

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
4. Install or repair only missing or broken components after confirmation.

Notes:

- Do not pin versions unless the user adds a compatibility requirement.

## Python Research Environment

Required capability:

- Miniconda
- Conda environment named `phd`
- Python 3.9 inside `phd`

Workflow:

1. Verify `conda`.
2. If missing, install Miniconda after confirmation.
3. Verify Conda environment `phd`.
4. If `phd` is missing, create it with Python 3.9 after confirmation.
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
4. Fix installation or permissions only after confirmation.

## Nginx Proxy Manager

Required service:

- Nginx Proxy Manager

Dependency:

- Docker must be working first.

Workflow:

1. Verify Docker is installed and daemon access works.
2. Check whether an Nginx Proxy Manager container or compose deployment exists.
3. If missing, ask for deployment preference before creating it.
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
