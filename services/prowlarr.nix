{ config, lib, pkgs, ... }:

{

  services.prowlarr = {
    enable = true;
    openFirewall = true;
    settings = {
      server.port = 9696;
      log.analyticsEnabled = false;
    };
  };
}
