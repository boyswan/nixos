{ config, pkgs, lib, ... }:  {
  programs.zsh = {
    enable = true;

    shellAliases = {
      cat = "bat";
      ll = "ls -l";
      gs = "git status";
      gi = "gitui";
      nb = "sudo nixos-rebuild switch --flake ~/NixOS/#jack";
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

    envExtra = ''
      PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
    '';

  };


}
