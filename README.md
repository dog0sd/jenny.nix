# another nixos config


for adding encrypted secret use `echo "my secret token" | age -r "ssh-ed25519 ..." -r "ssh-rsa ..." > secrets/my-secret-token.age` command

```
flake.nix           # parameters: hostname, username, sshKey, hashedPassword
default.nix         # boot, networking, user
environment.nix     # packages, zsh, starship, home-manager
services/
  jellyfin.nix
```

## Install

```bash
nixos-generate-config --root /mnt
git clone <URL> /mnt/etc/nixos && cd /mnt/etc/nixos
cp /mnt/etc/nixos/hardware-configuration.nix .
nixos-install --flake .#jenny
passwd jenny
```

## Update

```bash
sudo nixos-rebuild switch --flake .#jenny
```
