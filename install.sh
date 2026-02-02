#!/usr/bin/env bash
set -e

# Local rebuild — Jenny runs this on her own machine
sudo nixos-rebuild switch --flake .#jenny

