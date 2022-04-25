#!/bin/sh

set -e

# Test that we can install the latest version at the default location.
rm -f ~/.oden/bin/oden
unset ODEN_INSTALL
sh ./install.sh
~/.oden/bin/oden --version

# Test that we can install a specific version at a custom location.
rm -rf ~/oden-0.0.1
export ODEN_INSTALL="$HOME/oden-0.0.1"
./install.sh v0.0.1
~/oden-0.0.1/bin/oden --version | grep 0.0.1

# Test that we can install at a relative custom location.
export ODEN_INSTALL="."
./install.sh v0.0.2
bin/oden --version | grep 0.0.2
