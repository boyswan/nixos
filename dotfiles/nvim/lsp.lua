

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
  
  -- if client.resolved_capabilities.document_formatting then
  --   vim.cmd("au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  -- end 

  -- require("aerial").on_attach(client, bufnr)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
})

vim.diagnostic.config({
  float = {
    border = "single"
  },
})

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

local servers = {'tsserver'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require'lspconfig'.rust_analyzer.setup{
  -- root_dir = function(fname)    
  --   return os.getenv( "HOME" ) .. "/.local/share/nvim/mason/bin"
  -- end,
  -- root_dir = function(fname)    
  --   return os.getenv( "HOME" ) .. "/.rustup/toolchains/nightly-x86_64-apple-darwin/bin"
  -- end,
  -- cmd = {
  --   'rust_analyzer',
  -- },
  cmd = {
    'rustup',
    'run',
    'nightly',
    'rust-analyzer',
  },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust_analyzer"] = {
      proc_macro =  false,
    }
  }
}

require'lspconfig'.wgsl_analyzer.setup{
  root_dir = function(fname)    
    return os.getenv( "HOME" ) .. "/.local/share/nvim/mason/bin"
  end,
  cmd = {
    'wgsl_analyzer',
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

require'lspconfig'.ocamllsp.setup{
  root_dir = function(fname)    
    return os.getenv( "HOME" ) .. "/.local/share/nvim/mason/bin"
  end,
  cmd = {
    'ocamllsp',
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

require'lspconfig'.rescriptls.setup{
  root_dir = function(fname)    
    return os.getenv( "HOME" ) .. "/.local/share/nvim/mason/bin"
  end,
  cmd = {
    'rescript-lsp',
    '--stdio'
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

require'lspconfig'.cssls.setup{
  root_dir = function(fname)    
    return os.getenv( "HOME" ) .. "/.local/share/nvim/mason/bin"
  end,
  cmd = {
    'vscode-css-language-server',
    '--stdio'
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      -- behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'luasnip' },
  },
}


require"fidget".setup{}
require("mason").setup({
 ui = {
        keymaps = {
            apply_language_filter = "<C-s>",
        },
    },
  })

require("mason-lspconfig").setup()

