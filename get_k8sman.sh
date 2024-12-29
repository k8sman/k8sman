#!/usr/bin/env bash

: ${BINARY_NAME:="k8sman"}
: ${K8SMAN_INSTALL_DIR:="/usr/local/bin"}
: ${GITHUB_REPO:="k8sman/k8sman"}

HAS_CURL="$(type "curl" &> /dev/null && echo true || echo false)"
HAS_WGET="$(type "wget" &> /dev/null && echo true || echo false)"


# initArch discovers the architecture for this system.
initArch() {
  ARCH=$(uname -m)
  case $ARCH in
    armv5*) ARCH="armv5";;
    armv6*) ARCH="armv6";;
    armv7*) ARCH="arm";;
    aarch64) ARCH="arm64";;
    x86) ARCH="386";;
    x86_64) ARCH="amd64";;
    i686) ARCH="386";;
    i386) ARCH="386";;
  esac
}

# initOS discovers the operating system for this system.
initOS() {
  OS=$(echo `uname`|tr '[:upper:]' '[:lower:]')

  case "$OS" in
    # Minimalist GNU for Windows
    mingw*|cygwin*) OS='windows';;
  esac
}

# runs the given command as root (detects if we are root already)
runAsRoot() {
  if [ $EUID -ne 0 ]; then
    sudo "${@}"
  else
    "${@}"
  fi
}

# verifySupported checks that the os/arch combination is supported for
# binary builds, as well whether or not necessary tools are present.
verifySupported() {
  local supported="darwin-amd64\ndarwin-arm64\nlinux-amd64\nlinux-arm64\nwindows-amd64"
  if ! echo "${supported}" | grep -q "${OS}-${ARCH}"; then
    echo "No prebuilt binary for ${OS}-${ARCH}."
    exit 1
  fi

  if [ "${HAS_CURL}" != "true" ] && [ "${HAS_WGET}" != "true" ]; then
    echo "Either curl or wget is required"
    exit 1
  fi
}

# downloadFile downloads the latest binary package.
downloadFile() {
  K8SMAN_DIST="k8sman-${OS}-${ARCH}.tar.gz"
  DOWNLOAD_URL="https://github.com/k8sman/k8sman/releases/latest/download/$K8SMAN_DIST"
  K8SMAN_TMP_ROOT="$(mktemp -dt k8sman-installer)"
  K8SMAN_TMP_FILE="$K8SMAN_TMP_ROOT/$K8SMAN_DIST"
  echo "Downloading $DOWNLOAD_URL"
  if [ "${HAS_CURL}" == "true" ]; then
    curl -SsL "$DOWNLOAD_URL" -o "$K8SMAN_TMP_FILE"
  elif [ "${HAS_WGET}" == "true" ]; then
    wget -q -O "$K8SMAN_TMP_FILE" "$DOWNLOAD_URL"
  fi
}

# installFile installs the k8sman binary.
installFile() {
  K8SMAN_TMP="$K8SMAN_TMP_ROOT/$BINARY_NAME"
  mkdir -p "$K8SMAN_TMP"
  tar xf "$K8SMAN_TMP_FILE" -C "$K8SMAN_TMP"
  echo "Preparing to install $BINARY_NAME into ${K8SMAN_INSTALL_DIR}"
  chmod +x $K8SMAN_TMP/$BINARY_NAME-$OS-$ARCH
  runAsRoot cp "$K8SMAN_TMP/$BINARY_NAME-$OS-$ARCH" "$K8SMAN_INSTALL_DIR/$BINARY_NAME"
  echo "$BINARY_NAME installed into $K8SMAN_INSTALL_DIR/$BINARY_NAME"
}

# cleanup temporary files to avoid clutter
cleanup() {
  if [[ -d "${K8SMAN_TMP_ROOT:-}" ]]; then
    rm -rf "$K8SMAN_TMP_ROOT"
  fi
}

# Execution

#Stop execution on any error
trap "cleanup" EXIT
set -e

# Main execution flow
initArch
initOS
verifySupported
downloadFile
installFile
