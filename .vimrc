scriptencoding UTF-8
set encoding=UTF-8

if exists('g:vscode')
  " VSCode Extensions
else
  call plug#begin('~/.vim/plugged')

  Plug 'gruvbox-community/gruvbox'
  Plug 'arcticicestudio/nord-vim'
  Plug 'itchyny/lightline.vim'
  Plug 'https://github.com/scrooloose/nerdtree.git'
  Plug 'scrooloose/nerdcommenter'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-surround'
  Plug 'sheerun/vim-polyglot'
  Plug 'metakirby5/codi.vim'
  Plug 'tpope/vim-obsession'
  Plug 'dhruvasagar/vim-prosession'
  Plug 'Yggdroot/indentLine'
  Plug 'ryanoasis/vim-devicons'
  Plug 'dsznajder/vscode-es7-javascript-react-snippets', { 'do': 'yarn install --frozen-lockfile && yarn compile' }

  call plug#end()

  " Install new plugin as soon as vim starts
  autocmd VimEnter *
    \ if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
    \|  PlugInstall | q
    \| endif

  " Enable mode shapes, Cursor highlight and blinking
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

  " Enable relative line number
  set nu rnu
  " Make tabs as wide as two spaces
  set tabstop=2 shiftwidth=2 expandtab
  " Enable autoindent
  set autoindent
  " Always show status line
  set laststatus=2
  " Hide the current mode
  set noshowmode
  " Send all vim registers to the mac clipboard
  set clipboard=unnamed
  " Assume the terminal is fast
  set ttyfast
  " Enable mouse in all modes
  set mouse=a
  " Manage cursor line
  set cursorline
  " Necesary for lots of cool vim things
  set nocompatible

  " Set a map leader
  let mapleader=','

  " Map to switch tab right
  map <leader>] :tabn<CR>

  " Map to switch tab left
  map <leader>[ :tabN<CR>

  " Map to switch to last tab
  map <leader>tl :tablast<CR>

  " Custom maps
  nnoremap <silent> <leader>nh :nohlsearch<CR>

  " Calling LeadingSpaceDisable when nerdtree is loaded
  autocmd BufEnter NERD_tree* :LeadingSpaceDisable

  " Nerdtree configs
  let g:NERDTreeWinPos='right'
  let NERDTreeShowHidden=1
  let g:NERDTreeIgnore=['^node_modules$', '.DS_Store']

  " Add spaces after comment delimiters by default
  let g:NERDSpaceDelims=1

  " Nerdtree maps
  map <C-n> :NERDTreeToggle<CR>
  map <leader>r :NERDTreeFind<CR>

  function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
  endfunction

  let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocstatus', 'currentfunction', 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status',
    \   'currentfunction': 'CocCurrentFunction',
    \   'gitbranch': 'fugitive#head'
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
    \ 'tabline_separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'tabline_subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
    \ }
  
  " Use this to show arrow separator
    " \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" }
    " \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
    " \ 'tabline_separator': { 'left': "\ue0b0", 'right': "\ue0b2" }
    " \ 'tabline_subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }


  " Currently not in use
  " Use this show git folder path on lightline
  function! LightlineFilename()
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    if path[:len(root)-1] ==# root
      return path[len(root)+1:]
    endif
    return expand('%')
  endfunction

  if ($TERM_PROGRAM isnot# 'Apple_Terminal')
    set termguicolors
  endif

  " For light/dark in gruvbox
  set background=dark

  " Gruvbox has 'hard', 'medium' (default) and 'soft' contrast options.
  let g:gruvbox_contrast_dark='hard'

  colorscheme gruvbox
  " For Gruvbox to look correct in terminal Vim you'll want to source a palette
  " script that comes with the Gruvbox plugin.
  "
  " Add this to your ~/.profile file:
  "   source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

  " Added here to make syntax highlight work with gruvbox
  syntax on

  " Show horizontal indent line
  let g:indentLine_leadingSpaceEnabled=1

  " Specify a character to show for leading spaces
  let g:indentLine_leadingSpaceChar='-'

  " For COC Prettier
  command! -nargs=0 Prettier :CocCommand prettier.formatFile

  " COC Config
  let g:coc_status_error_sign='✘'
  let g:coc_status_warning_sign=''

  let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-eslint',
    \ 'coc-prettier',
    \ 'coc-json',
    \ 'coc-tsserver'
    \ ]

  " Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
  inoremap <silent><expr> <TAB>
    \ pumvisible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  let g:coc_snippet_next = '<tab>'

  " From COC Readme
  " if hidden is not set, TextEdit might fail.
  set hidden

  " Some servers have issues with backup files, see #649
  set nobackup
  set nowritebackup

  " You will have bad experience for diagnostic messages when it's default 4000.
  set updatetime=300

  " don't give |ins-completion-menu| messages.
  set shortmess+=c

  " always show signcolumns
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  " Or use `complete_info` if your vim support it, like:
  " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)

  " Remap for format selected region
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Create mappings for function text object, requires document symbols feature of languageserver.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
  nmap <silent> <C-d> <Plug>(coc-range-select)
  xmap <silent> <C-d> <Plug>(coc-range-select)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add status line support, for integration with other plugin, checkout `:h coc-status`
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Using CocList
  " Show all diagnostics
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

  " Triger `autoread` when files changes on disk
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
  " Notification after file change
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

  " Maps to show 1 or 2 sign column
  nnoremap <Leader>1 :set signcolumn=yes:1<CR>
  nnoremap <Leader>2 :set signcolumn=yes:2<CR>

  " Mapping for delete not cut
  nnoremap <leader>d "_d
  xnoremap <leader>d "_d
  xnoremap <leader>p "_dP

  " FZF search with preview
  command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

  " Rg search with preview
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   fzf#vim#with_preview(), <bang>0)

  " fzf file fuzzy search that respects .gitignore
  " If in git directory, show only files that are committed, staged, or unstaged
  " else use regular :Files
  nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"

  " Fugitive Git status
  nmap <leader>gs :G<CR>

  " Fugitive accept left code in merge conflict dv
  nmap <leader>gf :diffget //2<CR>

  " Fugitive accept right code in merge conflict dv
  nmap <leader>gj :diffget //3<CR>

  " Close all buffers except the current buffer
  command! BufOnly execute '%bdelete|edit #|normal `"'
endif 
