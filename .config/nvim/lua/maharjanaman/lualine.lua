local lualine = require('lualine')
local fidget = require('fidget')

local sources = {}
sources['null-ls'] = {
  ignore = true
}

fidget.setup{
  text = {
    spinner = 'dots',
  },
  sources = sources
}

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {'NvimTree'},
    always_divide_middle = false,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'FugitiveHead',
      'diff',
      {
        'diagnostics',
        sources={'nvim_diagnostic'},
        symbols = { error = '✘ ', warn = ' ', info = ' ', hint = ' '},
        colored = true,
      },
    },
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
        symbols = {
          modified = ' [+]',      -- Text to show when the file is modified.
          readonly = ' [-]',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
        }
      },
    },
    lualine_x = {
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {'fugitive'},
}
