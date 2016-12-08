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
Plugin 'scrooloose/syntastic'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'rdnetto/YCM-Generator'
Plugin 'taketwo/vim-ros'

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
nmap ,t :!(cd %:p:h && ctags --languages=c,c++ --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q -o .tags *)&
set tags=./.tags,.tags

set number

"SimpylFold options
let g:SimpylFold_docstring_preview=1
"YCM options
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>f :YcmCompleter FixIt<CR>
set foldmethod=indent
set foldlevel=99

"options for *.py scripts
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix encoding=utf-8

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

"Syntastic options
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"nnoremap <silent> <leader>gs :Gstatus<CR>
"nnoremap <silent> <leader>ga :Gwrite<CR><CR>
"nnoremap <silent> <leader>gt :Gcommit -v -q %:p<CR>
"nnoremap <silent> <leader>gd :Gdiff<CR>
"nnoremap <silent> <leader>gc :Gcommit -v -q<CR>
"nnoremap <silent> <leader>gb :Gblame<CR>
"nnoremap <silent> <leader>gl :Glog<CR>
"nnoremap <silent> <leader>gp :Git push<CR>

let g:ycm_semantic_triggers = {
\   'roslaunch' : ['="', '$(', '/'],
\   'rosmsg,rossrv,rosaction' : ['re!^', '/'],
\ }
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'  

if filereadable(glob("./.vimrc.local"))
	source ./.vimrc.local
endif
