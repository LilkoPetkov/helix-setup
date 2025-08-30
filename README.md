# Helix Editor Setup 🚀

This repository contains a configuration for the Helix editor, along with a `Makefile` to automate the setup process.

## Overview 📝

This setup provides a pre-configured environment for the Helix editor, primarily focused on **Python** and **Go** development. It includes:

*   🎨 A modern and popular color theme (Catppuccin Mocha).
*   🗣️ Language server configurations for Python (`pyright`) and Go (`gopls`).
*   💅 Auto-formatting for a wide range of languages.
*   📦 Installation of the Helix editor itself.
*   🛠️ Installation of necessary language tools like `pyright`, `ruff`, `gopls`, and `gofumpt`.

## Prerequisites 🛠️

Before you begin, you'll need to have the following installed on your system:

*   `git`: For cloning this repository.
*   `curl`: For downloading files.
*   `make`: For running the installation commands.
*   `npm` (Node.js): For installing `pyright`.
*   `pip3` (Python): For installing `ruff`.
*   `go`: For installing `gopls` and `gofumpt`.

## Installation ⚙️

To install and set up your Helix editor configuration, simply run the following command in your terminal:

```bash
make
```

This will:

1.  Create the necessary Helix configuration directory (`~/.config/helix`).
2.  Copy the `config.toml` and `languages.toml` files to the Helix configuration directory.
3.  Download and install the Catppuccin Mocha theme.
4.  Download and install the latest version of the Helix editor to `~/.local/bin`.
5.  Install the Python and Go language tools.

**Important:** After the installation is complete, make sure that `~/.local/bin` and your Go bin directory (`~/go/bin`) are in your system's `PATH`. The installation script will check for this and provide a warning with instructions if they are not.

## Configuration ⚙️

### `config.toml`

This file contains the main configuration for the Helix editor. The provided configuration sets the following options:

*   **Theme:** `catppuccin_mocha`
*   **Editor:**
    *   Relative line numbers
    *   Enables color modes, true color, auto-completion, and cursorline.
    *   Sets cursor shapes for different modes.
    *   Enables indent guides.
*   **Keys:**
    *   `S-w` (Shift-w) is mapped to `:w` (write/save).
    *   `S-q` (Shift-q) is mapped to `:q` (quit).
*   **File Picker:**
    *   Shows hidden files.
    *   Ignores files listed in `.gitignore` and `.ignore`.

### `languages.toml`

This file configures language-specific settings, including language servers and formatters.

*   **Language Servers:**
    *   `pyright` is configured for Python.
    *   `gopls` is configured for Go.
*   **Formatters:**
    *   `ruff` is used for formatting Python code.
    *   `gofumpt` is used for formatting Go code.

### `ignore`

This file specifies patterns for files and directories that should be ignored by the file picker. The provided file is configured to ignore common Python virtual environment directories.

## Makefile Targets 🎯

The `Makefile` provides the following targets:

*   `all`: The default target. Runs `install`.
*   `install`: The main installation target. Runs `check-path`, `setup-config`, `install-helix`, and `install-tools`.
*   `check-path`: Checks if `~/.local/bin` and `~/go/bin` are in your `PATH`.
*   `setup-config`: Sets up the configuration files and theme.
*   `install-helix`: Downloads and installs the Helix editor.
*   `install-tools`: Installs all language tools.
*   `install-py-tools`: Installs Python-specific tools (`pyright`, `ruff`).
*   `install-go-tools`: Installs Go-specific tools (`gopls`, `gofumpt`).
*   `clean`: Removes temporary files created during the installation process.
l-go-tools`: Installs Go-specific tools (`gopls`, `gofumpt`).
*   `clean`: Removes temporary files created during the installation process.
