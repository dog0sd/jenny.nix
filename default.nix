{ config, lib, pkgs, hostname, username, sshKey, hashedPassword, timeZone, defaultLocale, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./environment.nix
    ./dns.nix
    ./services
  ];
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  age.secrets = {
    cf-dns-api-token = {
      file = ./secrets/cf-dns-api-token.age;
      owner = "acme";
      group = "acme";
    };
    telegram-bot-token = {
      file = ./secrets/telegram-bot-token.age;
      owner = username;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "@wheel" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = hostname;

  time.timeZone = timeZone;
  i18n.defaultLocale = defaultLocale;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkManager" "input" "audio" "jellyfin" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ sshKey ];
  } // lib.optionalAttrs (hashedPassword != null) {
    initialHashedPassword = hashedPassword;
  };

  services.openssh.enable = true;

  system.stateVersion = "25.05";
}
