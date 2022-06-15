local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    color_devicons = true,
    file_ignore_patterns = { "^.git/" },
    mappings = {
      i = {
        ['<esc>'] = actions.close
      }
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')
