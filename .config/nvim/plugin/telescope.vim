nnoremap <silent> <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <silent> <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <silent> <Leader>pf :lua require('telescope.builtin').find_files()<CR>
nnoremap <silent> <leader>pb :lua require('telescope.builtin').buffers()<CR>
