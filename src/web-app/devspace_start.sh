#!/bin/bash
set +e # Continue on errors

COLOR_BLUE="\033[0;94m"
COLOR_GREEN="\033[0;92m"
COLOR_RESET="\033[0m"

# 1. Set terminal prompt
# 2. Include project's bin/ folder in PATH
echo "export PS1=\"\[${COLOR_BLUE}\]devspace\[${COLOR_RESET}\] ./\W \[${COLOR_BLUE}\]\\$\[${COLOR_RESET}\] \"" >~/.bashrc
echo 'if [ -z "$BASH" ]; then export PS1="$ "; fi' >>~/.bashrc
echo 'export PATH="./bin:$PATH"' >>~/.bashrc

echo "Installing Yarn Dependencies"
yarn install

echo "Starting application..."
yarn dev
