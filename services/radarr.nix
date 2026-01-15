{ config, lib, pkgs, ... }:

{

  services.radarr = {
    enable = true;
    user = "radarr";
    group = "services";
    openFirewall = true;
    settings = {
      server.port = 7878;
      log.analyticsEnabled = false;
    };
  };
}
