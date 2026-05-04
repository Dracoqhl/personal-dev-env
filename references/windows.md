# Windows Bootstrap Reference

## Scope

Windows is not implemented yet. Treat this file as the current plan and ask before creating PowerShell scripts or UI automation.

Windows setup should eventually support:

- Miniconda installer or winget package
- CC Switch Windows UI installer (`.msi`) or portable ZIP from GitHub Releases
- Git for Windows
- A tmux alternative or WSL-based tmux, depending on the user's preference

## Required First Question

Ask whether the user wants a native Windows setup or a WSL-based setup.

- Native Windows: install Miniconda, CC Switch UI, Git for Windows, and skip tmux unless the user chooses an alternative.
- WSL-based: use the Linux flow inside WSL for Miniconda, CC Switch headless/web, tmux, and git.

## CC Switch

For native Windows, prefer the UI application:

- `.msi` installer for normal installation
- portable ZIP for no-install usage

Do not silently install UI applications. Ask before downloading or launching installers.
