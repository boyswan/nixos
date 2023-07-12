local set = vim.opt
local g = vim.g

set.rnu = true
set.hidden = true
set.errorbells = false
set.tabstop = 2 
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.wrap = false
set.swapfile = false
set.backup  = false
set.undodir = vim.fn.expand('~/.vim/undodir')
set.undofile = true
set.incsearch = true
set.termguicolors = true
set.scrolloff = 8
set.signcolumn = 'yes'
set.number = true
set.cmdheight = 0
set.showmode = false
set.completeopt = 'menuone,noinsert,noselect'
set.clipboard = 'unnamedplus'
set.shortmess = set.shortmess + 'c'
set.laststatus = 3
set.formatoptions = set.formatoptions - 'cro'
set.ignorecase = true
set.smartcase = true
set.splitright = true
set.cursorline = true

g.mapleader = " "
g.netrw_liststyle = 3
g.netrw_banner = 0
g.tpipeline_cursormoved = 1
g.tpipline_fillcentre = 1
g.lf_netrw = 1

require('onedark').setup {
    style = 'warmer'
}

require('onedark').load()

vim.keymap.set('n', '<PageUp>', '<Nop>')
vim.keymap.set('n', '<PageDown>', '<Nop>')


vim.cmd[[hi cursorline cterm=none term=none]]
vim.cmd[[autocmd WinEnter * setlocal cursorline]]
vim.cmd[[autocmd WinLeave * setlocal nocursorline]]


vim.cmd[[command! Q :q]]
vim.cmd[[command! X :x]]
vim.cmd[[command! W :w]]
