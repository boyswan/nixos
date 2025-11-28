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
    "i3/config".text = builtins.readFile ./i3;
    "i3status/config".text = builtins.readFile ./i3status;
  };

  xresources.extraConfig = builtins.readFile ./Xresources;

  # programs.zsh = {
  #   enable = true;
  # };

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


  # programs.neovim = {
  #   enable = true;
  #   vimAlias = true;
  #   defaultEditor = true;
  # };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.i3status = {
    enable = true;

    # general = {
    #   colors = true;
    #   color_good = "#8C9440";
    #   color_bad = "#A54242";
    #   color_degraded = "#DE935F";
    # };
    #
    # modules = {
    #   ipv6.enable = false;
    #   "wireless _first_".enable = false;
    #   "battery all".enable = false;
    # };
  };

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    nerd-fonts.meslo-lg
    dconf
    htop
    alacritty
    ghostty
    neovim
    # starship
    firefox
    ripgrep
    rofi
    fzf
    chezmoi
    neofetch
    gammastep
    zig
    slurp
    grim
    gh
    gitui
    bat
    jq
    brave
    nil
    fd
    docker
    fira-code
  ];
}
