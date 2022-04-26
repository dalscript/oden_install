#!/bin/sh
# Copyright 2019 the Deno authors. All rights reserved. MIT license.
# TODO(everyone): Keep this script simple and easily auditable.

set -e

if ! command -v unzip >/dev/null; then
	echo "Error: unzip is required to install Oden (see: https://github.com/odenlang/oden_install#unzip-is-required)." 1>&2
	exit 1
fi

if [ "$OS" = "Windows_NT" ]; then
	target="x86_64-pc-windows-msvc"
else
	case $(uname -sm) in
	"Darwin x86_64") target="x86_64-apple-darwin" ;;
	"Darwin arm64") target="aarch64-apple-darwin" ;;
	*) target="x86_64-unknown-linux-gnu" ;;
	esac
fi

if [ $# -eq 0 ]; then
	oden_uri="https://github.com/odenlang/oden-alphas/releases/latest/download/oden-${target}.zip"
else
	oden_uri="https://github.com/odenlang/oden-alphas/releases/download/${1}/oden-${target}.zip"
fi

oden_install="${ODEN_INSTALL:-$HOME/.oden}"
bin_dir="$oden_install/bin"
exe="$bin_dir/oden"

if [ ! -d "$bin_dir" ]; then
	mkdir -p "$bin_dir"
fi

curl --fail --location --progress-bar --output "$exe.zip" "$oden_uri"
unzip -d "$bin_dir" -o "$exe.zip"
chmod +x "$exe"
rm "$exe.zip"

echo "Oden was installed successfully to $exe"
if command -v oden >/dev/null; then
	echo "Run 'oden --help' to get started"
else
	case $SHELL in
	/bin/zsh) shell_profile=".zshrc" ;;
	*) shell_profile=".bash_profile" ;;
	esac
	echo "Manually add the directory to your \$HOME/$shell_profile (or similar)"
	echo "  export ODEN_INSTALL=\"$oden_install\""
	echo "  export PATH=\"\$ODEN_INSTALL/bin:\$PATH\""
	echo "Run '$exe --help' to get started"
fi
