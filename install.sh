#!/bin/sh

set -e # -e: exit on error

if [ ! "$(command -v chezmoi)" ]; then
	BIN_DIR="$HOME/.local/bin"
	CHEZMOI="$BIN_DIR/chezmoi"
	if [ "$(command -v curl)" ]; then
		sh -c "$(curl -fsSL https://get.chezmoi.io)" -- -b "$BIN_DIR"
	elif [ "$(command -v wget)" ]; then
		sh -c "$(wget -qO- https://get.chezmoi.io)" -- -b "$BIN_DIR"
	else
		echo "You need to have either curl or wget installed." >&2
		exit 1
	fi
else
	CHEZMOI="chezmoi"
fi

SCRIPT_DIR="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

# Replace current process with chezmoi init
exec "$CHEZMOI" init --apply "--source=$SCRIPT_DIR"
