{ config, pkgs, ... }: {

  home = {
    username = "jack";
    homeDirectory = "/home/jack";
    sessionVariables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 64;  
    x11.enable = true; 
    gtk.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_SIZE = "64";
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
  };

  xresources.properties = {
    "Xft.dpi" = 192; 
    "Xft.autohint" = true;
    "Xft.antialias" = true;
    "Xft.hinting" = true;
    "Xft.hintstyle" = "hintslight";
    "Xft.rgba" = "rgb";
    "Xft.lcdfilter" = "lcddefault";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-dark-gtk;
      name = "gruvbox-dark";
    };
  };

  programs.home-manager.enable = true;

  xdg.enable = true;
  xdg.configFile = {
    "i3/config".text = builtins.readFile ./i3/config;
    "i3status/config".text = builtins.readFile ./i3/status;
    "i3/i3dir".text = builtins.readFile ./i3/dir;
    "rofi/config.rasi".text = builtins.readFile ./rofi;
  };

  programs.git = {
    enable = true;
    includes = [
      { path = "~/.gitconfig.local"; }
    ];
    extraConfig = {
      credential.helper = "store";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    nerd-fonts.meslo-lg
    dconf
    htop
    alacritty
    ghostty
    neovim
    ripgrep
    rofi
    fzf
    chezmoi
    xsel
    autocutsel
    xcwd
    grim
    i3status
    gh
    tree
    bat
    xdotool
    jq
    brave
    nil
    fd
    xorg.xsetroot
    docker
    claude-code
    k9s
    just
    jujutsu
    nil
    gitea
  ];
}
