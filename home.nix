{ config, pkgs, ... }: {

  imports = [
    (import ./programs/nvim-new)
    # (import ./programs/sway)
    # (import ./programs/alacritty.nix)
    # (import ./programs/lf.nix)
    # (import ./programs/waybar.nix)
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

  xdg.enable = true;
  xdg.configFile = {
    "alacritty/alacritty.toml".text = builtins.readFile ./programs/alacritty.toml;
    "i3/config".text = builtins.readFile ./programs/i3;
    "i3status/config".text = builtins.readFile ./programs/i3status;
    # "rofi/config.rasi".text = builtins.readFile ./programs/rofi;
  };

  xresources.extraConfig = builtins.readFile ./programs/Xresources;

  home.file.".zshrc".text = builtins.readFile ./programs/.zshrc;

  programs.zsh = {
    enable = true;
  };

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
    dconf
    htop
    alacritty
    # google-chrome
    # firefox
    # ripgrep

    rofi
    i3status
    fzf
    neofetch
    gammastep
    wl-clipboard
    slurp
    grim
    gitui
    bat
    jq
    # brightnessctl
    # telegram-desktop
    # discord
    # brave
    nil
    fd
    # slack
    # moreutils
    # joplin
    # dbeaver
    # gnome.gedit
    docker
    fira-code
  ];
}
