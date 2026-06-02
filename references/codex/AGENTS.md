# User-Level Codex Guidance

These instructions apply across repositories unless a newer explicit user instruction overrides them.

## Service And Port Hygiene

- Do not start preview servers, dev servers, port forwards, live companion servers, Docker services, or project startup scripts by default.
- Treat project service scripts as user-owned unless the user explicitly asks Codex to run them. This includes scripts such as `scripts/start-dev.sh`, `scripts/start.sh`, `pnpm dev`, `pnpm start`, `npm run dev`, `npm start`, and Docker Compose startup commands.
- If a temporary local service is genuinely required for verification, state why, record the command, PID, bind address, and port, and stop it before the final response.
- Before finishing any turn where Codex started a long-running process, verify with `ss -ltnp` or an equivalent command that the Codex-started port is no longer listening.
- Do not leave background processes, test servers, browser/Playwright servers, visual companion servers, or terminal sessions running after testing.
- Do not kill user-started or production services without explicit confirmation. First identify the PID, command, port, start time, and likely owner, then ask before stopping it.
