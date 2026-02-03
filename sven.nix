{ config, lib, pkgs, ... }:

# Sven TTS - ElevenLabs-based text-to-speech server
# Binary from https://github.com/dog0sd/sven
{
  # Copy sven binary to /usr/local/bin
  system.activationScripts.sven = ''
    mkdir -p /usr/local/bin
    cp ${./sven} /usr/local/bin/sven-bin
    chmod +x /usr/local/bin/sven-bin
    
    # Create wrapper that runs from /etc (where config lives)
    cat > /usr/local/bin/sven << 'EOF'
#!/bin/sh
cd /etc && exec /usr/local/bin/sven-bin "$@"
EOF
    chmod +x /usr/local/bin/sven
  '';

  # Copy sven config to /etc
  environment.etc."sven.yml".source = ./sven.yml;
}
