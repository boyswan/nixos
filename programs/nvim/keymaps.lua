function keymap(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- require("telescope").load_extension('harpoon')

require("lf").setup({
  winblend = 0, 
})

keymap("n", "<leader>fi", "<cmd>lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>")
keymap("n", "<leader>fe", "<cmd>lua require'telescope.builtin'.find_files()<cr>")
keymap("n", "<leader>fl", "<cmd>lua require'telescope.builtin'.live_grep()<cr>")
keymap("n", "<leader>fs", "<cmd>lua require'telescope.builtin'.git_status()<cr>")
keymap("n", "<leader>fd", "<cmd>lua require'telescope.builtin'.diagnostics()<cr>")
keymap("n", "<leader>fb", "<cmd>lua require'telescope.builtin'.buffers()<cr>")
keymap("n", "<leader>fh", "<cmd>Telescope harpoon marks<cr>")
-- keymap("n", "<leader>fh", "<cmd>lua require'harpoon.ui'.toggle_quick_menu()<cr>")
keymap("n", "<leader>m", "<cmd>lua require'harpoon.mark'.add_file()<cr>")

keymap("n", "<leader>y", "\"_dP")
-- keymap("i", "jk", "<esc>")

vim.cmd[[nnoremap <silent> <leader>k <cmd>lua vim.diagnostic.open_float()<CR>]]

keymap("n", "<leader>q", "<cmd>:bd<cr>")
keymap("n", "<leader>w", "<C-w>c")
-- keymap("n", "<leader>e", "<cmd>Explore<cr><cr>")
keymap("n", "<leader>e", ":Lf<cr>")
keymap("n", "<leader>o", "<cmd>vsp<cr><cr>")
keymap("n", "<C-h>", "<C-W><C-h>")
keymap("n", "<C-l>", "<C-W><C-l>")


vim.cmd[[autocmd FileType css nnoremap <silent> <buffer> <leader>f :Prettier<CR>]]
vim.cmd[[autocmd FileType scss nnoremap <silent> <buffer> <leader>f :Prettier<CR>]]
vim.cmd[[autocmd FileType javascript nnoremap <silent> <buffer> <leader>f :Prettier<CR>]]

local ft = require('Comment.ft')

ft.set("wgsl", "//%s")
