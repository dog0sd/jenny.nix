{ config, lib, pkgs, domain, email, ... }:

let
  certDir = config.security.acme.certs.${domain}.directory;
in
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "${email}";
    certs.${domain} = {
      reloadServices = [ "caddy.service" ];
      domain = "${domain}";
      extraDomainNames = [ "*.${domain}" ];
      dnsProvider = "cloudflare";
      dnsPropagationCheck = true;
      dnsResolver = "1.1.1.1:53";
      environmentFile = config.age.secrets.cf-dns-api-token.path;
    };
  };

  users.users.caddy.extraGroups = [ "acme" ];

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.caddy = {
    enable = true;
    enableReload = true;
    globalConfig = ''
      auto_https off
    '';
    virtualHosts = {
      "http://${domain}" = {
        extraConfig = ''
          redir https://{host}{uri} permanent
        '';
      };
      "http://*.${domain}" = {
        extraConfig = ''
          redir https://{host}{uri} permanent
        '';
      };

      "https://${domain}" = {
        extraConfig = ''
          tls ${certDir}/cert.pem ${certDir}/key.pem
          respond "Hello from ${domain}!"
        '';
      };
    };
  };
}
