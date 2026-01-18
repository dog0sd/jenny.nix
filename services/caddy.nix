{ config, lib, pkgs, domain, email, ... }:

let
  # path to certificates
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
      # CF_API_EMAIL and CF_API_KEY (or CF_DNS_API_TOKEN for API token)
      environmentFile = "/var/lib/acme/cloudflare-credentials";
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
      "https://watch.${domain}" = {
        extraConfig = ''
          tls ${certDir}/cert.pem ${certDir}/key.pem
          reverse_proxy 127.0.0.1:8096 {
            header_up X-Real-IP {remote_host}
            header_up X-Forwarded-For {remote_host}
            header_up X-Forwarded-Proto {scheme}
            header_up X-Forwarded-Host {host}
            transport http {
              read_buffer 8192
            }
          }
        '';
      };
      "https://radarr.${domain}" = {
        extraConfig = ''
          tls ${certDir}/cert.pem ${certDir}/key.pem
          reverse_proxy 127.0.0.1:7878 {
            header_up X-Real-IP {remote_host}
            header_up X-Forwarded-For {remote_host}
            header_up X-Forwarded-Proto {scheme}
            header_up X-Forwarded-Host {host}
          }
        '';
      };
      "https://sonarr.${domain}" = {
        extraConfig = ''
          tls ${certDir}/cert.pem ${certDir}/key.pem
          reverse_proxy 127.0.0.1:8989 {
            header_up X-Real-IP {remote_host}
            header_up X-Forwarded-For {remote_host}
            header_up X-Forwarded-Proto {scheme}
            header_up X-Forwarded-Host {host}
          }
        '';
      };
      "https://prowlarr.${domain}" = {
        extraConfig = ''
          tls ${certDir}/cert.pem ${certDir}/key.pem
          reverse_proxy 127.0.0.1:9696 {
            header_up X-Real-IP {remote_host}
            header_up X-Forwarded-For {remote_host}
            header_up X-Forwarded-Proto {scheme}
            header_up X-Forwarded-Host {host}
          }
        '';
      };
      "https://tr.${domain}" = {
        extraConfig = ''
          tls ${certDir}/cert.pem ${certDir}/key.pem
          reverse_proxy 127.0.0.1:8112 {
            header_up X-Real-IP {remote_host}
            header_up X-Forwarded-For {remote_host}
            header_up X-Forwarded-Proto {scheme}
            header_up X-Forwarded-Host {host}
          }
        '';
      };
    };
  };
}