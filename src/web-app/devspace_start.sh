#!/bin/bash
set +e # Continue on errors

ls -la

export NODE_ENV=development
if [ -f "yarn.lock" ]; then
  echo "Installing Yarn Dependencies"
  yarn
else
  if [ -f "package.json" ]; then
    echo "Installing NPM Dependencies"
    npm install
  fi
fi

COLOR_BLUE="\033[0;94m"
COLOR_GREEN="\033[0;92m"
COLOR_RESET="\033[0m"

# 1. Set terminal prompt
# 2. Include project's bin/ folder in PATH
echo "export PS1=\"\[${COLOR_BLUE}\]devspace\[${COLOR_RESET}\] ./\W \[${COLOR_BLUE}\]\\$\[${COLOR_RESET}\] \"" >~/.bashrc
echo 'if [ -z "$BASH" ]; then export PS1="$ "; fi' >>~/.bashrc
echo 'export PATH="./bin:$PATH"' >>~/.bashrc

yarn dev
