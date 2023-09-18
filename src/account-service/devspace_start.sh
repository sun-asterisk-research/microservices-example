#!/bin/sh
set +e # Continue on errors

if [ ! -f "/go/bin/gow" ]; then
  echo 'Installing gow'
  go install github.com/mitranim/gow@latest
fi

gow run main.go
