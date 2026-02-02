{ config, lib, pkgs, username, inputs, ... }:

{
  environment.localBinInPath = true;
  environment.variables.EDITOR = "nvim";
  environment.variables.VISUAL = "nvim";
  environment.shellAliases = {
    vim = "nvim";
    ls = "eza";
    ll = "eza -la";
    la = "eza -a";
    lt = "eza --tree";
  };

  environment.systemPackages = with pkgs; [
    git
    gh
    wget
    curl
    jq
    ripgrep
    fzf
    neovim
    gnupg
    python314
    go

    # gnumake
    # gcc
    # bash

    nodejs_25 # for openclaw (jenny)
    pnpm_9
    fastfetch
    htop
    vuetorrent
    mpv
    pipewire
    agenix-cli
    age
    alsa-utils
    alsa-plugins
    file
    tree
    eza
    neovim
    inputs.agenix.packages.${pkgs.system}.default
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "docker" "kubectl" ];
      theme = "agnoster";
    };
  };

  programs.starship.enable = true;
  programs.nix-ld.enable = true;

  home-manager.users.${username} = {
    home.username = username;
    home.homeDirectory = "/home/${username}";
    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
    home.packages = with pkgs; [];
  };
}
