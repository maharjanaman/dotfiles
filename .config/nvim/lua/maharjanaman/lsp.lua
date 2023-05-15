local nvim_lsp = require('lspconfig')
local cmp = require('cmp')
local null_ls = require('null-ls')
local npairs = require('nvim-autopairs')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

-- Setup friendly-snippets --

require('luasnip.loaders.from_vscode').lazy_load()

-- Setup autopairs --

npairs.setup {}

-- Setup cmp --

-- Set completeopt to have better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, 
  {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- To insert '(' after select function or method item
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({
  map_char = {
    tex = ''
  }
}))

-- Setup lspconfig --

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=NONE]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=Normal guibg=NONE]]

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'rounded'
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<Space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<Space>q', vim.diagnostic.setloclist, opts)

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
  vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)

  -- Disable Autoformat
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver' }

for _, lsp in pairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

-- Setup null-ls --

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Helper to conditionally register eslint handlers only if eslint is
-- configured. If eslint is not configured for a project, it just fails.
local function has_eslint_configured(utils)
  return utils.root_has_file(".eslintrc.js")
end

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.eslint_d.with({ condition = has_eslint_configured }),
    null_ls.builtins.diagnostics.eslint_d.with({ condition = has_eslint_configured }),
    null_ls.builtins.formatting.eslint_d.with({ condition = has_eslint_configured }),
    null_ls.builtins.formatting.prettierd.with({
      -- Only register prettier if eslint_d is not running as a formatter. This
      -- can happen if it's not configured for this project, or if it can't
      -- handle the current filetype.
      condition = function()
        return #null_ls.get_source({ name = "eslint_d", method = null_ls.methods.FORMATTING }) == 0
      end,
    }),
  },
  diagnostics_format = "[#{c}] #{m}",
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.format()
        end,
      })
    end
  end,
})

-- Personal Mods --

-- LSP handlers configuration
local lsp_config = {
  diagnostic = {
    virtual_text = false,
    underline = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      source = 'always',
    },
  },
}


-- Change diagnostic signs.
local diagnostic_signs = {
  { name = 'DiagnosticSignError', text = '✘' },
  { name = 'DiagnosticSignWarn', text = ''},
  { name = 'DiagnosticSignInfo',  text = '' },
  { name = 'DiagnosticSignHint', text = '' },
}

for _, sign in ipairs(diagnostic_signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

-- Diagnostic configuration
vim.diagnostic.config(lsp_config.diagnostic)
