{ config, lib, pkgs, username, ... }:

{
  environment.localBinInPath = true;
  environment.variables.EDITOR = "nvim";

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    jq
    ripgrep
    fzf
    neovim
    gnupg
    python3
    go
    fastfetch
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
