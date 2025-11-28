{ config, pkgs, lib, ... }:  {
  programs.zsh = {
    enable = true;

    shellAliases = {
      cat = "bat --theme OneHalfDark";
      ll = "ls -l";
      gs = "git status";
      gi = "gitui";
      j = "just";
      nb = "sudo nixos-rebuild switch --flake ~/nix-config/#jack_vm";
      nd = "nix develop .";
      jo = "joplin";
      dc = "docker compose";
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

    # initExtra= ''
    #   export DIRENV_LOG_FORMAT=""
    # '';

  };


}
