#!/usr/bin/env bash
set -e

TARGET="thinkcentre"

nixos-rebuild switch --flake .#jenny --target-host "$TARGET" --sudo --ask-sudo-password

