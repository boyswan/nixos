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
      theme = "daveverwer";
    };

  };


}
