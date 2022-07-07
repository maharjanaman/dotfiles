local bufferline = require('bufferline')

bufferline.setup {
  options = {
    mode = 'tabs',
    numbers = 'ordinal',
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 0,
    diagnostics = false,
    offsets = {
      {
        filetype = 'NvimTree', 
        text_align = 'center',
        highlight = 'NvimTreeNormal'
      }
    },
    color_icons = false,
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_buffer_default_icon = false, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = false,
    show_tab_indicators = false,
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    separator_style = {'', ''},
  },
  highlights = {
    fill = {
      guibg = "#16161e"
    },
    background = {
      guibg = "#16161e"
    },
    buffer_selected = {
      gui = 'bold'
    },
    numbers = {
      guibg = "#16161e"
    },
    numbers_selected = {
      gui = 'bold'
    }
  }
}
