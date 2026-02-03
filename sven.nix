{ config, lib, pkgs, username, ... }:

# Sven TTS - ElevenLabs-based text-to-speech server
# Binary from https://github.com/dog0sd/sven
# Config locations (priority order): ./sven.yml, ~/.config/sven.yml, /etc/sven.yml
{
  # Copy sven binary to /usr/local/bin
  system.activationScripts.sven = ''
    mkdir -p /usr/local/bin
    cp ${./sven} /usr/local/bin/sven
    chmod +x /usr/local/bin/sven
  '';

  # Copy sven config to user's ~/.config
  home-manager.users.${username}.xdg.configFile."sven.yml".source = ./sven.yml;
}
