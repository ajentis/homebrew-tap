# Ajentis Homebrew Tap

Official [Homebrew](https://brew.sh) tap for Ajentis tools.

## Available Formulas

| Formula | Description |
|---------|-------------|
| `ajentis-forge` | CLI for MCP servers & AI agents — from prototype to production |

## Installation

```sh
brew install ajentis/tap/ajentis-forge
```

Or tap first, then install:

```sh
brew tap ajentis/tap
brew install ajentis-forge
```

## Shell Installer (no Homebrew required)

```sh
curl -sSL https://raw.githubusercontent.com/ajentis/homebrew-tap/main/install-forge.sh | sh
```

Install a specific version:

```sh
curl -sSL https://raw.githubusercontent.com/ajentis/homebrew-tap/main/install-forge.sh | sh -s v0.1.0
```

## Updating

```sh
brew upgrade ajentis-forge
```

## Uninstall

```sh
brew uninstall ajentis-forge
brew untap ajentis/tap
```
