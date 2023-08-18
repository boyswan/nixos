local actions = require("telescope.actions")
local fb_actions = require "telescope._extensions.file_browser.actions"

-- require("aerial").setup({})
-- require('telescope').load_extension('aerial')

require("telescope").setup({
  defaults = {
    sorting_strategy = "ascending",
    file_ignore_patterns = {".git/", ".cache", "%.png", "%.lock"},
    initial_mode = 'normal',
    mappings = {
      n = {
        ["q"] = actions.close,
        ["t"] = actions.select_tab
      },
    },
  },
   extensions = {
    file_browser = {
      hijack_netrw = true,
			grouped = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          ["h"] = fb_actions.goto_parent_dir,
          ["l"] = require('telescope.actions').select_default,
          -- your custom normal mode mappings
        },
      },
    },
  },
})

require("telescope").load_extension "file_browser"

require'nvim-web-devicons'.setup {
  default = true;
}

require("telescope").load_extension('harpoon')
