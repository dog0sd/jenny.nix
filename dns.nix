{ config, pkgs, ... }:

{
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      listen_addresses = [ "127.0.0.1:53" "[::1]:53" ];
      server_names = [ "cloudflare" "google" "adguard-dns" ];
      doh_servers = true;
      require_dnssec = false;
      require_nolog = true;
      require_nofilter = true;
      force_tcp = true;
    };
  };

  services.resolved.enable = false;

  networking.nameservers = [ "127.0.0.1" "::1" ];
  
  networking.networkmanager.dns = "none";
}
