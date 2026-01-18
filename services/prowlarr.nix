{ config, lib, pkgs, ... }:

{

  services.prowlarr = {
    enable = true;
    openFirewall = false;
    settings = {
      server.port = 9696;
      log.analyticsEnabled = false;
    };
  };
}
