local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
  ensure_installed = {
    "tsx",
    "typescript",
    "javascript",
    "json",
    "lua",
    "html",
    "scss"
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
