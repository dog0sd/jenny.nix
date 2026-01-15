{ config, lib, pkgs, ... }:

{

  users.groups.services = {
    name = "services";
    members = ["radarr" "sonarr" "jellyfin" "qbittorrent"];
  };

  imports = [
    ./jellyfin.nix
    ./qbittorrent.nix
    ./radarr.nix
    ./sonarr.nix
    ./prowlarr.nix
    ./flaresolverr.nix
  ];
}
