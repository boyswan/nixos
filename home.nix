{ config, pkgs, ... }: {

  imports = [
    (import ./programs/nvim)
    (import ./programs/alacritty.nix)
    (import ./programs/lf.nix)
    (import ./programs/sway.nix)
    (import ./programs/zsh.nix)
    (import ./programs/waybar.nix)
  ];
  
  home = {
    username = "jack";
    homeDirectory = "/home/jack";
    sessionVariables = {
      TERMINAL = "alacritty";
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-dark-gtk;
      name = "gruvbox-dark";
    };
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "boyswan";
    userEmail = "jack@nix";
    extraConfig = {
      credential.helper = "libsecret";
    };
  };


  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.stateVersion = "23.05";
  home.packages = with pkgs; [ 
    btop 
    google-chrome
    firefox
    clang 
    dconf
    zig
    ripgrep
    neofetch
    gammastep
    wl-clipboard
    slurp
    gitui
    bat
  ];

}
