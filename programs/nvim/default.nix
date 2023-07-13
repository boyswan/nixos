{ config, pkgs, lib, ... }: 
  let 
    pluginGit =  owner: repo: rev: sha256: pkgs.vimUtils.buildVimPlugin {
      name = "${lib.strings.sanitizeDerivationName repo}";
      src = pkgs.fetchFromGitHub {
        owner = owner;
        repo = repo;
        rev = rev;
        sha256 = sha256;
      };
    };
  in {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
      extraConfig = ''
        luafile ${./settings.lua}
        luafile ${./keymaps.lua}
        luafile ${./fuzzy.lua}
        luafile ${./status.lua}
        luafile ${./tree.lua}
        luafile ${./editor.lua}
      '';
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
        nvim-web-devicons
        nvim-cmp
        cmp-nvim-lsp
        vim-cool
        plenary-nvim
        telescope-nvim
        lualine-nvim
        gitsigns-nvim
        vim-sandwich
        fidget-nvim
        comment-nvim
        harpoon
        lf-vim
        onedark-nvim
        toggleterm-nvim
        (pluginGit "lmburns" "lf.nvim" "87a72c6" "Zl9eIzNNklPAyQbS1jPavRvZ1NVmCTxw0R0so67wapM=")
      ];
    };
  }
