local actions = require("telescope.actions")
-- require("aerial").setup({})
-- require('telescope').load_extension('aerial')

require("telescope").setup({
  defaults = {
    file_ignore_patterns = {".git/", ".cache", "%.png", "%.lock"},
    initial_mode = 'insert',
    mappings = {
      n = {
        ["w"] = actions.close,
        ["t"] = actions.select_tab
      },
    },
  },
})

require'nvim-web-devicons'.setup {
  default = true;
}

require("telescope").load_extension('harpoon')
