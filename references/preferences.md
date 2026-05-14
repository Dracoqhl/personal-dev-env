# Personal Preferences

- Default target platform is Linux.
- Prefer Ubuntu/Debian-compatible setup when no distribution is specified.
- Do not maintain Windows setup for now.
- Required means "restore this capability", not "install every command manually".
- Versions are not pinned by default.
- Always show the planned workflow and affected components before installing, repairing, removing, or recreating anything.
- Skip existing components that pass verification.
- Repair only when a component is missing, unusable, incompatible, or blocking a dependent workflow.
- Preserve user data, Conda environments, Docker volumes, service configuration, and local config files by default.
- Do not commit secrets, API tokens, auth files, SSH private keys, shell history, logs, generated Codex state, or local Codex databases.
- Codex config may contain sensitive provider tokens; record templates or notes only.
- Python research setup should use Miniconda and a Conda environment named `phd` with Python 3.9.
- Nginx Proxy Manager depends on Docker and should be treated as a service workflow, not a simple CLI tool.
