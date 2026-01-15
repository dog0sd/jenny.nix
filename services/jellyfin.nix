{ config, lib, pkgs, ... }:

{

  # port 8096
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "jellyfin";
    group = "services";

  };
}
