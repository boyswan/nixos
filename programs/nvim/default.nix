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
      extraPackages = with pkgs; [
        nil
      ];
      extraConfig = ''
        luafile ${./lsp.lua}
        luafile ${./settings.lua}
        luafile ${./keymaps.lua}
        luafile ${./fuzzy.lua}
        luafile ${./status.lua}
        luafile ${./tree.lua}
        luafile ${./editor.lua}
      '';
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        luasnip
        nvim-treesitter.withAllGrammars
        nvim-web-devicons
        nvim-cmp
        null-ls-nvim
        cmp-nvim-lsp
        vim-cool
        plenary-nvim
        telescope-nvim
        telescope-file-browser-nvim
        lualine-nvim
        gitsigns-nvim
        vim-sandwich
        fidget-nvim
        comment-nvim
        harpoon
        onedark-nvim
        (pluginGit "NoahTheDuke" "vim-just" "927b418" "BmxYWUVBzTowH68eWNrQKV1fNN9d1hRuCnXqbEagRoY=")
      ];
    };
  }
