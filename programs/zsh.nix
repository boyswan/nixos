{ config, pkgs, lib, ... }:  {
  programs.zsh = {
    enable = true;

    shellAliases = {
      cat = "bat --theme OneHalfDark";
      ll = "ls -l";
      gs = "git status";
      gi = "gitui";
      nb = "sudo nixos-rebuild switch --flake ~/NixOS/#jack";
      nd = "nix develop .";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

    initExtra= ''

      export DIRENV_LOG_FORMAT=""

      function em() {
        args=$1
        pid=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true).pid')
        swaymsg exec --quiet "emacsclient -c" 
        kill ''${pid}
      }

      function ema() {
        args=$1
        pid=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true).pid')
        swaymsg exec --quiet "emacsclient -c $(pwd)/''${args}" 
        kill ''${pid}
      }
      
      function emm() {
        args=$1
        emacsclient -c -nw $(pwd)/''${args}
      }

    '';

  };


}
