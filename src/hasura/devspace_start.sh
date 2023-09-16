#!/bin/bash

echo 'export PS1="\[${COLOR_BLUE}\]devspace\[${COLOR_RESET}\] ./\W \[${COLOR_BLUE}\]\\$\[${COLOR_RESET}\] "' >~/.bashrc
echo 'if [ -z "$BASH" ]; then export PS1="$ "; fi' >>~/.bashrc

if [ -z $HASURA_GRAPHQL_ADMIN_SECRET]; then
  hasura-cli console --no-browser
else
  hasura-cli console --no-browser --admin-secret $HASURA_GRAPHQL_ADMIN_SECRET
fi
