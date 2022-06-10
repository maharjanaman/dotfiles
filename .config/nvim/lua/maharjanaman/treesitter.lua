local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "json",
    "lua",
    "html",
    "scss",
    "css"
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}
