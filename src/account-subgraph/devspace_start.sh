#!/bin/sh
set +e # Continue on errors

COLOR_BLUE="\033[0;94m"
COLOR_GREEN="\033[0;92m"
COLOR_RESET="\033[0m"

# 1. Set terminal prompt
# 2. Include project's bin/ folder in PATH
echo "export PS1=\"\[${COLOR_BLUE}\]devspace\[${COLOR_RESET}\] ./\W \[${COLOR_BLUE}\]\\$\[${COLOR_RESET}\] \"" >~/.bashrc
echo 'if [ -z "$BASH" ]; then export PS1="$ "; fi' >>~/.bashrc
echo 'export PATH="./bin:$PATH"' >>~/.bashrc

if [ ! -f "/usr/include/google/protoc" ]; then
  echo 'Install protobuf v3.20.3'
  wget https://github.com/protocolbuffers/protobuf/releases/download/v3.20.3/protoc-3.20.3-linux-x86_64.zip &&
    unzip -o protoc-3.20.3-linux-x86_64.zip -d /usr &&
    rm -rf protoc-3.20.3-linux-x86_64.zip &&
    cp /usr/bin/protoc /usr/include/google
else
  cp /usr/include/google/protoc /usr/bin/protoc
fi

echo 'Fetching dependencies...'
cargo fetch

echo 'Tonic build...'
cargo build

echo 'Starting application...'
cargo watch -x run
