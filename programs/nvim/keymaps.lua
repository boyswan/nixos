function keymap(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- require("telescope").load_extension('harpoon')

keymap("n", "<leader>fi", "<cmd>lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>")
keymap("n", "<leader>fe", "<cmd>Telescope find_files initial_mode=insert<cr>")
keymap("n", "<leader>fl", "<cmd>Telescope live_grep initial_mode=insert<cr>")
keymap("n", "<leader>fs", "<cmd>Telescope git_status <cr>")
keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap("n", "<leader>fh", "<cmd>Telescope harpoon marks<cr>")
keymap("n", "<leader>e", "<cmd>Telescope file_browser initial_mode=normal path=%:p:h select_buffer=true<cr>")

-- keymap("n", "<leader>fh", "<cmd>lua require'harpoon.ui'.toggle_quick_menu()<cr>")
keymap("n", "<leader>m", "<cmd>lua require'harpoon.mark'.add_file()<cr>")

keymap("n", "<leader>y", "\"_dP")
keymap("i", "jk", "<esc>")
keymap("n", "<C-f>", "<cmd>TZFocus<cr>")

vim.cmd[[nnoremap <silent> <leader>k <cmd>lua vim.diagnostic.open_float()<CR>]]

keymap("n", "<leader>q", "<cmd>:bd<cr>")
keymap("n", "<leader>w", "<C-w>c")
keymap("n", "<leader>o", "<cmd>vsp<cr><cr>")
keymap("n", "<leader>i", "<cmd>sp<cr><cr>")
keymap("n", "<C-h>", "<C-W><C-h>")
keymap("n", "<C-l>", "<C-W><C-l>")
keymap("n", "<C-j>", "<C-W><C-j>")
keymap("n", "<C-k>", "<C-W><C-k>")


vim.cmd[[autocmd FileType css nnoremap <silent> <buffer> <leader>f :Prettier<CR>]]
vim.cmd[[autocmd FileType scss nnoremap <silent> <buffer> <leader>f :Prettier<CR>]]
vim.cmd[[autocmd FileType javascript nnoremap <silent> <buffer> <leader>f :Prettier<CR>]]

local ft = require('Comment.ft')

ft.set("wgsl", "//%s")
