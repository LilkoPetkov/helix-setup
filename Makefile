HELIX_CONFIG_DIR := $(HOME)/.config/helix
LOCAL_BIN := $(HOME)/.local/bin
SHELL := /bin/bash
OS := $(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH := $(shell uname -m)

ifeq ($(OS),darwin)
	ifeq ($(ARCH),arm64)
		ARCH := aarch64
	endif
endif

all: install

.PHONY: all install setup-config install-helix install-tools install-py-tools install-go-tools clean check-path

install: check-path setup-config install-helix install-tools
	@echo "✅ Helix setup complete!"
	@echo "Please ensure $(LOCAL_BIN) and $(HOME)/go/bin are in your PATH."
	@echo "You may need to restart your shell for changes to take effect."

check-path:
	@if [[ ":$$PATH:" != ":$(LOCAL_BIN):"* ]]; then \
		echo "⚠️ Warning: $(LOCAL_BIN) is not in your PATH."; \
		echo "Please add it to your shell profile (e.g., ~/.bashrc, ~/.zshrc):"; \
		echo "export PATH=\"$(LOCAL_BIN):$$PATH\""; \
	fi
	@if [[ ":$$PATH:" != ":$(HOME)/go/bin:"* ]]; then \
		echo "⚠️ Warning: $(HOME)/go/bin is not in your PATH."; \
		echo "Please add it to your shell profile (e.g., ~/.bashrc, ~/.zshrc):"; \
		echo "export PATH=\"$$PATH:$(shell go env GOPATH)/bin\""; \
	fi

setup-config:
	@echo " Setting up configuration files..."
	@mkdir -p $(HELIX_CONFIG_DIR)/themes
	@cp config.toml $(HELIX_CONFIG_DIR)/
	@cp languages.toml $(HELIX_CONFIG_DIR)/
	@echo " Downloading Catppuccin theme..."
	@curl -fL "https://raw.githubusercontent.com/catppuccin/helix/main/themes/default/catppuccin_mocha.toml" -o "$(HELIX_CONFIG_DIR)/themes/catppuccin_mocha.toml"

install-helix:
	@echo " Installing Helix editor..."
	@mkdir -p $(LOCAL_BIN)
	@LATEST_HELIX_URL=$$(curl -s "https://api.github.com/repos/helix-editor/helix/releases/latest" | grep "browser_download_url.*helix-.*-$(ARCH)-$(OS)\.tar\.xz" | cut -d '"' -f 4 | head -n 1); \
	if [ -z "$$LATEST_HELIX_URL" ]; then \
		echo "❌ Error: Could not find a download URL for Helix for your system ($(OS)/$(ARCH))."; \
		exit 1; \
	fi; \
	curl -L $$LATEST_HELIX_URL -o /tmp/helix.tar.xz
	tar -xvf /tmp/helix.tar.xz -C /tmp
	mv /tmp/helix-*-$(ARCH)-$(OS)/hx $(LOCAL_BIN)/
	@rm -rf /tmp/helix*
	@echo "✅ Helix installed to $(LOCAL_BIN)/hx"

install-tools: install-py-tools install-go-tools

install-py-tools:
	@echo " Installing Python tools (pyright, ruff)..."
	@if ! command -v npm &> /dev/null; then \
		echo "❌ Error: npm is not installed. Please install Node.js and npm."; \
		exit 1; \
	fi
	@npm install -g --prefix=$(HOME)/.local pyright
	@if ! command -v pip3 &> /dev/null; then \
		echo "❌ Error: pip3 is not installed. Please install Python and pip."; \
		exit 1; \
	fi
	@pip3 install -U ruff $(PIP_FLAGS)

install-go-tools:
	@echo " Installing Go tools (gopls, gofumpt)..."
	@if ! command -v go &> /dev/null; then \
		echo "❌ Error: go is not installed. Please install Go."; \
		exit 1; \
	fi
	@go install golang.org/x/tools/gopls@latest
	@go install mvdan.cc/gofumpt@latest

clean:
	@echo " Cleaning up..."
	@rm -f /tmp/helix.tar.xz
	@rm -rf /tmp/helix-*-$(ARCH)-$(OS)
echo " Cleaning up..."
	@rm -f /tmp/helix.tar.xz
	@rm -rf /tmp/helix-*-$(ARCH)-$(OS)
