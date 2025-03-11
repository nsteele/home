
""" Prepare for vim-plug initialization.

set nocompatible              " be iMproved, disables compatibility with vi
filetype off


""" Install vim-plug and plugins automatically, if not installed yet

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


""" Plugin configurations

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8' "syntax checking for python
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
if has('nvim')

else
	Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --clangd-completer'} 
endif

call plug#end() " - Automatically executes `filetype plugin indent on` and `syntax enable`.
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting


""" Basic Behavior

set number                     " show line numbers
set wrap                       " wrap lines
set encoding=utf-8             " set encoding to UTF-8 (default was "latin1")
set wildmenu                   " visual autocomplete for command menu
set lazyredraw                 " redraw only when necessary
set laststatus=2               " always show statusline (even with only single window)
set ruler                      " show line and column number of the cursor on right side of statusline
set visualbell                 " blink cursor on error, instead of beeping
set backspace=indent,eol,start " backspace over everything in insert mode
let c_space_errors = 1         " Highlight unnecessary whitespace in c and cpp files


""" Key Bindings

" move vertically by visual line (don't skip wrapped lines)
nmap j gj
nmap k gk
" Easy escape
imap jj <Esc>
" Use SPACE as leader key
nnoremap <SPACE> <Nop>
let mapleader = " "
" Easy fuzzy file search
map <leader>p :Files<CR>


""" Vim Appearance

" put colorscheme files in ~/.vim/colors/
" colorscheme solarized      " good colorschemes: murphy, slate, molokai, badwolf, solarized


""" Settings for faster grepping

if executable('rg')
	set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --multiline-dotall
elseif executable('ag')
	set grepprg=ag\ --vimgrep\ --smart-case\ --hidden
endif


""" Settings for yanking to/from system clipboard and tmux clipboard

" copy to attached terminal using the yank(1) script:
" https://github.com/sunaku/home/blob/master/bin/yank
function! Yank(text) abort
	let escape = system('yank', a:text)
	if v:shell_error
		echoerr escape
	else
		call writefile([escape], '/dev/tty', 'b')
	endif
endfunction
if executable('yank')
	noremap <silent> <Leader>y y:<C-U>call Yank(@0)<CR>
endif

""" YouCompleteMe Plugin Configuration

let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'  
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'


""" Options for specific filetypes
" Note that settings for specific file types can go in
" ~/.vim/ftplugin/<filetype>.vim

""" NERDTree Plugin Configuration
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


""" Read extra vimrc if available. This is useful for machine-specific configurations.

if filereadable(glob("~/.vim/extra_vimrc"))
	source ~/.vim/extra_vimrc
endif
