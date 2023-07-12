{ config, pkgs, ... }: {

  imports = [
    (import ./programs/neovim.nix)
    (import ./programs/alacritty.nix)
    (import ./programs/lf.nix)
    (import ./programs/sway.nix)
    (import ./programs/zsh.nix)
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
    userEmail = "jackwilliamboyce@gmail.com";
    extraConfig = {
      credential.helper = "libsecret";
    };
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
  ];

}
