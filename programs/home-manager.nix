{ config, pkgs, ... }: {

  home = {
    username = "jack";
    homeDirectory = "/home/jack";
    sessionVariables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 128;
      x11.enable = true;
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

  xdg.enable = true;
  xdg.configFile = {
    "i3/config".text = builtins.readFile ./i3/config;
    "i3status/config".text = builtins.readFile ./i3/status;
    "i3/i3dir".text = builtins.readFile ./i3/dir;
    "rofi/config.rasi".text = builtins.readFile ./rofi;
  };

  xresources.extraConfig = builtins.readFile ./Xresources;

  programs.git = {
    enable = true;
    userName = "boyswan";
    userEmail = "boyswan@vm";
    extraConfig = {
      credential = {
        helper = "${pkgs.gh}/bin/gh auth git-credential";
      };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    nerd-fonts.meslo-lg
    dconf
    htop
    alacritty
    ghostty
    neovim
    starship
    firefox
    ripgrep
    rofi
    fzf
    chezmoi
    xsel
    autocutsel
    xcwd
    neofetch
    gammastep
    zig
    slurp
    grim
    i3status
    gh
    tree
    gitui
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
    k3d
  ];
}
