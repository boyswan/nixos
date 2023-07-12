{ config, pkgs, lib, ... }:  {
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
}
