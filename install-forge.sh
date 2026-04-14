#!/bin/sh
set -e

# Ajentis Forge installer
# Usage:
#   curl -sSL https://raw.githubusercontent.com/ajentis/homebrew-tap/main/install-forge.sh | sh
#   curl -sSL https://raw.githubusercontent.com/ajentis/homebrew-tap/main/install-forge.sh | sh -s v0.1.0

REPO="ajentis/homebrew-tap"
BINARY="ajnt"
INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"

info() { printf '\033[1;34m%s\033[0m\n' "$1"; }
error() { printf '\033[1;31merror: %s\033[0m\n' "$1" >&2; exit 1; }

detect_os() {
    case "$(uname -s)" in
        Linux*)  echo "linux" ;;
        Darwin*) echo "darwin" ;;
        MINGW*|MSYS*|CYGWIN*) echo "windows" ;;
        *) error "Unsupported OS: $(uname -s)" ;;
    esac
}

detect_arch() {
    case "$(uname -m)" in
        x86_64|amd64)  echo "amd64" ;;
        arm64|aarch64) echo "arm64" ;;
        *) error "Unsupported architecture: $(uname -m)" ;;
    esac
}

get_latest_version() {
    # Find the latest forge-v* tag from the tap repo releases
    local tag
    if command -v curl >/dev/null 2>&1; then
        tag=$(curl -sSL "https://api.github.com/repos/${REPO}/releases" \
            | grep '"tag_name"' | grep 'forge-v' | head -1 \
            | sed -E 's/.*"forge-(v[^"]+)".*/\1/')
    elif command -v wget >/dev/null 2>&1; then
        tag=$(wget -qO- "https://api.github.com/repos/${REPO}/releases" \
            | grep '"tag_name"' | grep 'forge-v' | head -1 \
            | sed -E 's/.*"forge-(v[^"]+)".*/\1/')
    else
        error "curl or wget required"
    fi
    echo "$tag"
}

download() {
    url="$1"
    output="$2"
    if command -v curl >/dev/null 2>&1; then
        curl -sSL "$url" -o "$output"
    elif command -v wget >/dev/null 2>&1; then
        wget -q "$url" -O "$output"
    fi
}

main() {
    OS=$(detect_os)
    ARCH=$(detect_arch)

    VERSION="${1:-}"
    if [ -z "$VERSION" ]; then
        info "Fetching latest version..."
        VERSION=$(get_latest_version)
    fi

    if [ -z "$VERSION" ]; then
        error "Could not determine latest version. Pass a version as argument: install-forge.sh v0.1.0"
    fi

    info "Installing Ajentis Forge ${VERSION} (${OS}/${ARCH})"

    # Release tag on the tap repo is "forge-v0.1.0", archive name uses "v0.1.0"
    TAG="forge-${VERSION}"

    if [ "$OS" = "windows" ]; then
        ARCHIVE="ajentis-forge_${VERSION}_${OS}_${ARCH}.zip"
    else
        ARCHIVE="ajentis-forge_${VERSION}_${OS}_${ARCH}.tar.gz"
    fi

    URL="https://github.com/${REPO}/releases/download/${TAG}/${ARCHIVE}"
    TMPDIR=$(mktemp -d)
    trap 'rm -rf "$TMPDIR"' EXIT

    info "Downloading ${URL}..."
    download "$URL" "$TMPDIR/$ARCHIVE"

    info "Extracting..."
    if [ "$OS" = "windows" ]; then
        unzip -q "$TMPDIR/$ARCHIVE" -d "$TMPDIR"
    else
        tar xzf "$TMPDIR/$ARCHIVE" -C "$TMPDIR"
    fi

    if [ -w "$INSTALL_DIR" ]; then
        mv "$TMPDIR/$BINARY" "$INSTALL_DIR/$BINARY"
    else
        info "Installing to ${INSTALL_DIR} (requires sudo)..."
        sudo mv "$TMPDIR/$BINARY" "$INSTALL_DIR/$BINARY"
    fi

    chmod +x "$INSTALL_DIR/$BINARY"

    info "Installed ${BINARY} to ${INSTALL_DIR}/${BINARY}"
    "$INSTALL_DIR/$BINARY" --version
    info ""
    info "Run 'ajnt --help' to get started."
}

main "$@"
