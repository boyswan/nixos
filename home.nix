{ config, pkgs, ... }: {

  imports = [
    (import ./neovim.nix)
  ];
  
  home = {
    username = "jack";
    homeDirectory = "/home/jack";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "boyswan";
    userEmail = "jackwilliamboyce@gmail.com";
  };

  programs.alacritty = {
    enable = true;
  };

  programs.lf = {
    enable = true;
    settings = {
      drawbox = true;
    };
    extraConfig = ''
      set cursorpreviewfmt ""

      cmd mkdir %{{
        IFS=" " 
        mkdir -p -- "$*" 
        lf -remote "send $id select \"$*\""
      }}

      cmd touch %{{
        IFS=" " 
        touch "$*"
        lf -remote "send $id select \"$*\""
      }}
    '';
  };

  home.stateVersion = "23.05";
  home.packages = with pkgs; [ 
    btop 
  ];
}
