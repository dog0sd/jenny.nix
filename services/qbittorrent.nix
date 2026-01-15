{ config, lib, pkgs, ... }:

{

  services.qbittorrent = {
    enable = true;
    user = "qbittorrent";
    group = "services";
    openFirewall = true;
    webuiPort = 8112;
    serverConfig = {
      BitTorrent = {
        Session = {
          DefaultSavePath = "/media/downloads";
          Preallocation = true;
        };
      };
      Preferences = {
        WebUI = {
          AlternativeUIEnabled = true;
          RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
          Username = "jenny";
          
          Password_PBKDF2="@ByteArray(GdhHt7OjsMkq3nV970tCOw==:fftfCkCKEXFVd7CbaDOd4HT+IOOPhBZ1qNU1oj/pBDAv+jvU9eB8GuuzDIW68rKLe8YWAou90vsFmQr8X2l4ow==)";
        };
      };
      LegalNotice = {
        Accepted = true;
      };
    };
  };

}

