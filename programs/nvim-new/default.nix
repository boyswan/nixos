{ config, pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # LSP servers
      nil
      lua-language-server

      # Tools
      ripgrep
      fd
      git
    ];

    extraLuaConfig = ''
      -- Set up config path for lazy.nvim
      vim.opt.runtimepath:prepend("${./.}")

      -- Load init.lua
      dofile("${./init.lua}")
    '';
  };
}
