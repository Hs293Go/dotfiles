let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))

    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

endif

let g:ale_disable_lsp = 1
let g:coc_global_extensions = ['coc-json',
            \ 'coc-git',
            \ 'coc-clangd',
            \ 'coc-pyright']

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
call plug#end()

syntax on
set encoding=utf-8
set number
set noswapfile
set hlsearch
set ignorecase
set incsearch
set ts=4 sw=4 softtabstop=4 expandtab
autocmd FileType c,cpp set ts=2 sw=2 softtabstop=2 expandtab
autocmd Filetype python set tw=88 foldmethod=indent
set backspace=indent,eol,start

set signcolumn=yes
so ~/.coc_conf.vim

let mapleader=" "
nnoremap ; :

"reload the .vimrc
nmap <silent> <leader>rv :source ~/.vimrc<CR>
"show spaces"
nmap <silent> <leader>s :set nolist!<CR>
"show line numbers"
nmap <silent> <leader>l :set nonu!<CR>
"wrap lines"
nmap <silent> <leader>w :set nowrap!<CR>
"hide hightlight of searches"
nmap <silent> // :nohlsearch<CR>

"Toggle folding
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" Tmux prefix but vim directions for pane switching
map <C-a>h <C-w>h
map <C-a>j <C-w>j
map <C-a>k <C-w>k
map <C-a>l <C-w>l

map <Tab> :bnext<CR>
map <S-Tab> :bprev<CR>

nmap <C-t> :tabnew<CR>

" Maximize only this window"
nmap <silent> <leader>m :only<CR>
"vertical split tmux style
nmap <silent> <C-a>" :bel :vne<CR>
"horizontal split tmux style
nmap <silent> <C-a>% :bel :new<CR>
"close viewport buffer tmux style
nmap <silent> <C-a>d :hid<CR>
" }}}

" Edit the .bashrc"
nmap <silent> <leader>eb :e ~/.bashrc<CR>
" Edit the .zshrc"
nmap <silent> <leader>ez :e ~/.zshrc<CR>
" Edit the .vimrc"
nmap <silent> <leader>ev :e ~/.vimrc<CR>
" Edit the .gitconfig"
nmap <silent> <leader>eg :e ~/.gitconfig<CR>
" Edit the .tmux.conf"
nmap <silent> <leader>et :e ~/.tmux.conf<CR>

filetype plugin indent on

highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
let &t_TI = ""
let &t_TE = ""

let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'
let g:ale_linters= {'python' : ['pylint', 'flake8'], 'cpp' : ['clangd'] }
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'python': ['black']
            \}
let g:ale_fix_on_save = 1
let g:ale_python_flake8_options='--config=~/.flake8'
let g:ale_python_pylint_options='--rcfile=~/.pylintrc'
