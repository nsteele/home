set encoding=utf-8
set number
set nocompatible              " be iMproved
filetype off

"Install vim-plug and plugins automatically if not installed yet
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Plugin configurations
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --clangd-completer'} 
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8' "syntax checking for python
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'

"Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" Highlight unnecessary whitespace in c and cpp files
let c_space_errors = 1

imap jj <Esc>
nnoremap <SPACE> <Nop>
let mapleader = " "
set backspace=indent,eol,start " backspace over everything in insert mode
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis

"Faster grepping
if executable('rg')
	set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --multiline-dotall
elseif executable('ag')
	set grepprg=ag\ --vimgrep\ --smart-case\ --hidden
endif

"YCM options
let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
"map <leader>f :YcmCompleter FixIt<CR>
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'  
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

"FZF file search shortcut
map <leader>p :Files<CR>

"options for *.py scripts
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix encoding=utf-8

"NERDTree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


if filereadable(glob("./.vimrc.local"))
	source ./.vimrc.local
endif
