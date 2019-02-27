set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Vundle plugins
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe' "requires additional installation steps. See Valloric/YouCompleteMe on GitHub. Also requires a .ycm_extra_conf.py file for C language completion. Specific .ycm_extra_conf.py files can be used for specific contexts, like ROS dev.
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8' "syntax checking for python
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'rdnetto/YCM-Generator'

"taketwo/vim-ros plugin requires python2, but YCM requires python3, so we are
"disabling vim-ros
"Plugin 'taketwo/vim-ros'

call vundle#end() "required
filetype plugin indent on "required

nnoremap <SPACE> <Nop>
let mapleader = " "
syntax on
set backspace=indent,eol,start " backspace over everything in insert mode
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis
imap jj <Esc>

"key-mapping to regenerate a tags file in local directory
nmap ,t :!(cd %:p:h && ~/.ctags/dirtags.bash)&
set tags=./.tags,.tags

set number

"YCM options
let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
"map <leader>f :YcmCompleter FixIt<CR>
let g:ycm_semantic_triggers = {
\   'roslaunch' : ['="', '$(', '/'],
\   'rosmsg,rossrv,rosaction' : ['re!^', '/'],
\ }
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'  
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

"options for *.py scripts
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix encoding=utf-8

"Syntastic options
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = []

"NERDTree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


if filereadable(glob("./.vimrc.local"))
	source ./.vimrc.local
endif
