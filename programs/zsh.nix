{ config, pkgs, lib, ... }:  {
  programs.zsh = {
    enable = true;

    shellAliases = {
      ll = "ls -l";
      nb = "sudo nixos-rebuild switch --flake ~/nixos/#jack";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

  };


}
