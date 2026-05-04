# Linux Bootstrap Reference

## Scope

Linux setup currently supports:

- Miniconda for `x86_64` and `aarch64`
- CC Switch headless/web CLI from GitHub Releases
- `tmux`
- `git`

Use `scripts/bootstrap-linux.sh` for the default implementation. It is designed to be re-run safely.

## Package Manager Strategy

Detect the package manager in this order:

1. `apt-get`
2. `dnf`
3. `yum`
4. `pacman`
5. `zypper`

Install `git`, `tmux`, `curl`, `ca-certificates`, and `tar` through the detected package manager. Use `sudo` only when the current user is not root.

## Miniconda

Default install directory:

```bash
$HOME/miniconda3
```

Skip installation if `$HOME/miniconda3/bin/conda` or any `conda` on `PATH` already exists, unless the user asks to reinstall.

Use the latest Miniconda installer from Anaconda:

```bash
https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh
```

After installation, run:

```bash
"$HOME/miniconda3/bin/conda" init bash
"$HOME/miniconda3/bin/conda" config --set auto_activate_base false
```

Tell the user that a new shell session may be required for `conda` shell integration.

## CC Switch

CC Switch desktop packages for Linux are available as `.deb`, `.rpm`, `.AppImage`, and Arch `cc-switch-bin`.

For a CLI/headless Linux setup, prefer the web/headless build from GitHub Releases:

```bash
https://github.com/farion1231/cc-switch/releases/latest/download/cc-switch-web-linux-x64.tar.gz
```

Default install directory:

```bash
$HOME/.local/opt/cc-switch-web
```

Default symlink:

```bash
$HOME/.local/bin/cc-switch-web
```

After installing, verify:

```bash
cc-switch-web --help
```

If the user wants a desktop Linux app instead, install the distro-specific `.deb` or `.rpm`, or use `paru -S cc-switch-bin` on Arch-based systems.

## Verification

End by showing versions or executable paths:

```bash
git --version
tmux -V
conda --version
command -v cc-switch-web
```
