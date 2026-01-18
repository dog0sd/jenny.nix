{ config, lib, pkgs, ... }:

{

  services.sonarr = {
    enable = true;
    user = "sonarr";
    group = "services";
    openFirewall = false;
    settings = {
      server.port = 8989;
      log.analyticsEnabled = false;
    };
  };
}
