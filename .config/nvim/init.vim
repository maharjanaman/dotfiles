" --- General ---
set encoding=UTF-8
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu rnu
set nowrap
set signcolumn=yes
set hidden
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set nohlsearch
set ignorecase
set smartcase
set termguicolors
set scrolloff=10
set noshowmode
set updatetime=300
set clipboard=unnamed
set mouse=a
set splitbelow
set splitright
set cursorline
" Don't give |ins-completion-menu| messages.
set shortmess+=c

" --- Plugins ---
call plug#begin('~/.config/nvim/plugged')

Plug 'sainnhe/gruvbox-material'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'windwp/nvim-autopairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'rmagatti/auto-session'
Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()

" --- Require Plugin Configs ---
lua require('maharjanaman')

" --- Colors ---
" For light/dark in gruvbox
set background=dark
" Gruvbox has 'hard', 'medium' (default) and 'soft' contrast options.
let g:gruvbox_material_background='hard'
" For better performance
let g:gruvbox_material_better_performance=1
colorscheme gruvbox-material

" --- Additional Mods ---
" Set a map leader
let mapleader=' '

" For easy navigation
" nnoremap <silent> <leader>h :wincmd h<Cr>
" nnoremap <silent> <leader>j :wincmd j<Cr>
" nnoremap <silent> <leader>k :wincmd k<Cr>
" nnoremap <silent> <leader>l :wincmd l<Cr>

" Map to switch tab right
nnoremap <silent> <leader>] :tabn<CR>

" Map to switch tab left
nnoremap <silent> <leader>[ :tabN<CR>

" Map to switch to last tab
nnoremap <silent> <leader>tl :tablast<CR>

" Maps to show 1 or 2 sign column
nnoremap <Leader>1 :set signcolumn=yes:1<CR>
nnoremap <Leader>2 :set signcolumn=yes:2<CR>

" Mapping for delete not cut
nnoremap <silent> <leader>d "_d
xnoremap <silent> <leader>d "_d
xnoremap <silent> <leader>p "_dP

" Fugitive Git status
nmap <leader>gs :G<CR>

" Fugitive accept left code in merge conflict dv
nmap <leader>gf :diffget //2<CR>

" Fugitive accept right code in merge conflict dv
nmap <leader>gj :diffget //3<CR>
