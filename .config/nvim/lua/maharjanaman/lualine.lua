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
    globalstatus = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'FugitiveHead',
      'diff',
      {
        'diagnostics',
        sources={'nvim_diagnostic'},
        diagnostics_color = {
          error = {
            fg = '#ea6962',
          },
          warn = {
            fg = '#d8a657',
          },
          info = {
            fg = '#7daea3',
          },
          hint = {
            fg = '#89b482',
          },
        },
        symbols = { error = '✘ ', warn = ' ', info = ' ', hint = ' '},
        colored = true,
      },
    },
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
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
  tabline = {
    lualine_a = {
      {
        'tabs',
        max_length = vim.o.columns,
        mode = 2,
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {'fugitive'},
}
