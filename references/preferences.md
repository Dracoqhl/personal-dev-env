# Personal Preferences

- Set up the current device, not an abstract target platform.
- Detect OS, distribution, architecture, package manager, permissions, existing tools, and service state before planning installs.
- Prefer Linux server workflows when the detected system is Linux.
- Unsupported systems should be reported clearly instead of guessed.
- Required means "restore this capability", not "install every command manually".
- Versions are not pinned by default.
- Confirm the whole install/repair plan once before execution using an editable checklist.
- Do not ask before every individual install step once the checklist is confirmed.
- Ask again only for destructive or high-risk actions such as deleting data, recreating services, replacing existing environments, or overwriting configuration.
- Skip existing components that pass verification.
- Repair only when a component is missing, unusable, incompatible, or blocking a dependent workflow.
- Preserve user data, Conda environments, Docker volumes, service configuration, and local config files by default.
- Do not commit secrets, API tokens, auth files, SSH private keys, shell history, logs, generated Codex state, or local Codex databases.
- Codex config may contain sensitive provider tokens; record templates or notes only.
- Python research setup should use Miniconda and a Conda environment named `phd` with Python 3.9.
- Nginx Proxy Manager depends on Docker and should be treated as a service workflow, not a simple CLI tool.
