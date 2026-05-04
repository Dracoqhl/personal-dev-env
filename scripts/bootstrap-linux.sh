#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
INSTALL_MINICONDA=1
INSTALL_CC_SWITCH=1

usage() {
  cat <<'USAGE'
Usage: bootstrap-linux.sh [--dry-run] [--skip-miniconda] [--skip-cc-switch]

Installs or verifies the personal Linux dev environment:
  - git
  - tmux
  - Miniconda
  - CC Switch headless/web CLI
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1 ;;
    --skip-miniconda) INSTALL_MINICONDA=0 ;;
    --skip-cc-switch) INSTALL_CC_SWITCH=0 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 2 ;;
  esac
  shift
done

run() {
  if [[ "$DRY_RUN" == "1" ]]; then
    printf '[dry-run]'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

need_sudo() {
  if [[ "$(id -u)" -eq 0 ]]; then
    echo ""
  else
    echo "sudo"
  fi
}

detect_pm() {
  for pm in apt-get dnf yum pacman zypper; do
    if command -v "$pm" >/dev/null 2>&1; then
      echo "$pm"
      return 0
    fi
  done
  return 1
}

install_packages() {
  local pm sudo_cmd
  pm="$(detect_pm)" || {
    echo "No supported package manager found. Install git, tmux, curl, ca-certificates, and tar manually." >&2
    return 1
  }
  sudo_cmd="$(need_sudo)"

  case "$pm" in
    apt-get)
      run $sudo_cmd apt-get update
      run $sudo_cmd apt-get install -y git tmux curl ca-certificates tar
      ;;
    dnf)
      run $sudo_cmd dnf install -y git tmux curl ca-certificates tar
      ;;
    yum)
      run $sudo_cmd yum install -y git tmux curl ca-certificates tar
      ;;
    pacman)
      run $sudo_cmd pacman -Sy --needed --noconfirm git tmux curl ca-certificates tar
      ;;
    zypper)
      run $sudo_cmd zypper --non-interactive install git tmux curl ca-certificates tar
      ;;
  esac
}

install_miniconda() {
  if command -v conda >/dev/null 2>&1; then
    echo "Conda already found: $(command -v conda)"
    return 0
  fi

  local install_dir installer arch url
  install_dir="${HOME}/miniconda3"
  if [[ -x "${install_dir}/bin/conda" ]]; then
    echo "Miniconda already found: ${install_dir}/bin/conda"
    return 0
  fi

  arch="$(uname -m)"
  case "$arch" in
    x86_64|amd64) url="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" ;;
    aarch64|arm64) url="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh" ;;
    *) echo "Unsupported Miniconda architecture: $arch" >&2; return 1 ;;
  esac

  installer="$(mktemp)"
  run curl -fsSL "$url" -o "$installer"
  run bash "$installer" -b -p "$install_dir"
  run rm -f "$installer"
  run "${install_dir}/bin/conda" init bash
  run "${install_dir}/bin/conda" config --set auto_activate_base false
}

install_cc_switch_web() {
  if command -v cc-switch-web >/dev/null 2>&1; then
    echo "cc-switch-web already found: $(command -v cc-switch-web)"
    return 0
  fi

  local arch url tmpdir install_dir bin_dir
  arch="$(uname -m)"
  case "$arch" in
    x86_64|amd64) url="https://github.com/farion1231/cc-switch/releases/latest/download/cc-switch-web-linux-x64.tar.gz" ;;
    *) echo "Unsupported cc-switch-web architecture: $arch" >&2; return 1 ;;
  esac

  tmpdir="$(mktemp -d)"
  install_dir="${HOME}/.local/opt/cc-switch-web"
  bin_dir="${HOME}/.local/bin"

  run mkdir -p "$install_dir" "$bin_dir"
  run curl -fsSL "$url" -o "${tmpdir}/cc-switch-web.tar.gz"
  run tar -xzf "${tmpdir}/cc-switch-web.tar.gz" -C "$tmpdir"

  if [[ "$DRY_RUN" == "0" ]]; then
    local extracted
    extracted="$(find "$tmpdir" -type f -name cc-switch-web -perm -111 | head -n 1)"
    if [[ -z "$extracted" ]]; then
      echo "Downloaded archive did not contain an executable named cc-switch-web" >&2
      return 1
    fi
    cp "$extracted" "${install_dir}/cc-switch-web"
    chmod +x "${install_dir}/cc-switch-web"
    ln -sf "${install_dir}/cc-switch-web" "${bin_dir}/cc-switch-web"
    rm -rf "$tmpdir"
  else
    rmdir "$tmpdir" 2>/dev/null || true
  fi
}

verify() {
  echo
  echo "Verification:"
  command -v git >/dev/null 2>&1 && git --version || true
  command -v tmux >/dev/null 2>&1 && tmux -V || true
  if command -v conda >/dev/null 2>&1; then
    conda --version
  elif [[ -x "${HOME}/miniconda3/bin/conda" ]]; then
    "${HOME}/miniconda3/bin/conda" --version
  fi
  command -v cc-switch-web >/dev/null 2>&1 && command -v cc-switch-web || true
}

install_packages
if [[ "$INSTALL_MINICONDA" == "1" ]]; then
  install_miniconda
fi
if [[ "$INSTALL_CC_SWITCH" == "1" ]]; then
  install_cc_switch_web
fi
verify
