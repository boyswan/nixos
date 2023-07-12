require('gitsigns').setup()

local colors = require('onedark.colors')
require('Comment').setup({
  winblend = 0
})

-- vim.cmd[[hi LineNr guifg=#636872]]
--
-- vim.nvim_set_hl.create('DiagnosticVirtualTextWarn', {guibg=colors.bg}, false)
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { bg=colors.bg, fg=colors.dark_yellow})
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { bg=colors.bg, fg=colors.dark_red })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { bg=colors.bg, fg=colors.cyan })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { bg=colors.bg, fg=colors.orange })

vim.cmd[[hi TSParameter gui=NONE]]
vim.cmd[[hi TSNamespace gui=NONE]]
vim.cmd[[hi TSTagAttribute gui=NONE]]
vim.cmd[[hi TSParameter gui=NONE]]
vim.cmd[[hi TSConditional gui=NONE]]

vim.cmd[[sign define DiagnosticSignError texthl=DiagnosticSignError text=]]
vim.cmd[[sign define DiagnosticSignWarn texthl=DiagnosticSignWarn text=]]
vim.cmd[[sign define DiagnosticSignHint texthl=DiagnosticSignHint text=]]
vim.cmd[[sign define DiagnosticSignInfo texthl=DiagnosticSignInfo text=]]


