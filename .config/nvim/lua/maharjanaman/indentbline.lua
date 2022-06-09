local indent_blankline = require('indent_blankline')

vim.opt.list = true
vim.opt.listchars:append("lead:⋅")

indent_blankline.setup {
  space_char_blankline = " ",
}
