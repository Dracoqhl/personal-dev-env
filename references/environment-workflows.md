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

## LaTeX Rendering

Required capability:

- TeX Live Full distribution
- LaTeX engines such as `pdflatex`, `xelatex`, and `lualatex`
- `latexmk` for automated document builds

Workflow:

1. Verify LaTeX engine commands.
2. Verify `texlive-full` and supporting packages through the system package manager when available.
3. If missing, include TeX Live Full installation in the consolidated checklist.
4. After installation or repair, compile a minimal LaTeX document as verification.

Notes:

- On Ubuntu/Debian systems, use the native apt package `texlive-full`.
- Treat TeX Live Full as a large disk and network operation.

Current observed state:

- Package: `texlive-full` 2023.20240207-1 installed through apt.
- Engines verified: `pdflatex`, `xelatex`, `lualatex`.
- Build tool verified: `latexmk` 4.83.
- Minimal PDF build verified with `latexmk -pdf`.

## Basic CLI Utilities

Supporting utilities:

- git
- curl
- wget
- jq
- tmux
- vim
- ripgrep
- tmux plugin manager (TPM)
- tmux-better-mouse-mode

Workflow:

1. Verify presence when needed by another workflow or when the user asks for a full environment check.
2. Install missing utilities only as supporting dependencies for active workflows.
3. Do not treat OS-provided basics such as `ssh` as personal environment tools unless the user explicitly asks.

Tmux plugin workflow:

1. Verify `tmux`.
2. Verify TPM at `~/.tmux/plugins/tpm`.
3. Verify `NHDaly/tmux-better-mouse-mode` at `~/.tmux/plugins/tmux-better-mouse-mode`.
4. Verify `~/.tmux.conf` keeps existing user settings and includes TPM plugin entries plus `run '~/.tmux/plugins/tpm/tpm'`.
5. Reload tmux configuration when a tmux server is running.

Current observed state:

- tmux 3.4 installed.
- TPM installed at `/root/.tmux/plugins/tpm`.
- `tmux-better-mouse-mode` installed from `https://github.com/NHDaly/tmux-better-mouse-mode` at `/root/.tmux/plugins/tmux-better-mouse-mode`.
- `/root/.tmux.conf` enables mouse mode, configures `@scroll-speed-num-lines-per-scroll 1`, includes TPM, and includes `NHDaly/tmux-better-mouse-mode`.

## Remote Screenshot And Clipboard Handling

Known limitation:

- This device is a headless Linux server. GUI clipboard access through X11 may be unavailable from Codex or browser-integrated paste flows.
- Error pattern: `Failed to paste image: clipboard unavailable: Unknown error while interacting with the clipboard: X11 server connection timed out because it was unreachable`.

Workflow:

1. Treat this as a remote desktop / clipboard transport limitation, not as a PhD Workspace app bug.
2. Do not try to repair it by installing X11 packages unless the user explicitly asks for a GUI clipboard stack.
3. Prefer one of these alternatives for UI feedback screenshots:
   - Upload or attach the screenshot directly in the chat UI when available.
   - Save the screenshot as a local file on the client machine, then upload it as an attachment.
   - If the image already exists on the server, provide its full file path so Codex can inspect it with the image viewer.
   - For browser UI verification initiated by Codex, use Playwright screenshots saved to `/tmp` or the project workspace.
4. If a future setup needs clipboard bridging, first confirm the actual client path: local desktop, SSH X11 forwarding, VS Code Remote, web terminal, or browser-based Codex. Choose a solution for that path rather than guessing.
