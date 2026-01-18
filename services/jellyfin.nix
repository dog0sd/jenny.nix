{ config, lib, pkgs, ... }:

{

  # port 8096
  services.jellyfin = {
    enable = true;
    openFirewall = false;
    user = "jellyfin";
    group = "services";
  };
}
