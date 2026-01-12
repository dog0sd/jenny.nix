{ config, lib, pkgs, hostname, username, sshKey, hashedPassword, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./environment.nix
    ./services
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "@wheel" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = hostname;

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkManager" "input" "jellyfin" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ sshKey ];
  } // lib.optionalAttrs (hashedPassword != null) {
    initialHashedPassword = hashedPassword;
  };

  services.openssh.enable = true;

  system.stateVersion = "25.05";
}
