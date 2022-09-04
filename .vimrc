""
"" My very own .vimrc file.
"" Author: Stephan Hartig
""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""" Filetypes/Languages.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Set language type.
au BufRead,BufNewFile *.l set filetype=picolisp
au! syntax picolisp source $VIM/picolisp.vim

au BufRead,BufNewFile *.hx set filetype=haxe
au! syntax haxe source $VIM/haxe.vim

au BufRead,BufNewFile *.pn set filetype=potion
au! syntax potion source $VIM/potion.vim

au BufRead,BufNewFile *.rs set filetype=rust
au! syntax rust source $VIM/rust.vim

au BufRead,BufNewFile Makefile set noexpandtab

autocmd! BufNewFile,BufReadPre,FileReadPre  *.hs    so ~/.vim/haskell.vim
autocmd! BufNewFile,BufReadPre,FileReadPre  *.hsc   so ~/.vim/haskell.vim
autocmd! BufNewFile,BufReadPre,FileReadPre  *.lhs   so ~/.vim/haskell.vim
autocmd! BufNewFile,BufReadPre,FileReadPre  *.cabal so ~/.vim/haskell.vim






""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""" Plugin stuff.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"

let g:slime_cell_delimiter = "```"


" Start up vim-plug.
" | Plugins installed under that directory.
call plug#begin('~/.vim/plugged')

   " Lexiconal highlighting.
   Plug 'ayu-theme/ayu-vim'
   Plug 'NLKNguyen/papercolor-theme'



   " Nerdtree.
   Plug 'preservim/nerdtree'

   " Vim-Slime.
   Plug 'jpalardy/vim-slime'

   " Ale. Style checker.
   Plug 'dense-analysis/ale', { 'on': 'ALEToggle' }

   " Metals for Java/Scala.
   Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}

   " Use release branch for Conquer of Completion (COC) plugin.
   Plug 'neoclide/coc.nvim', {'branch': 'release'}

   function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1] =~ '\s'
   endfunction

   " Use <c-space> (AKA <NUL>) for trigger completion and navigate to the next complete item.
   inoremap <silent><expr> <NUL>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<c-space>" :
      \ coc#refresh()

   " Use <Tab> and <S-Tab> to navigate the completion list.
   inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
   inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

   " Use <cr> to auto import.
   "inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" Initialize plugin system.
call plug#end()


"" Start NERDTree whenever Vim is opened. Put cursor in other window.
"autocmd VimEnter * NERDTree | wincmd p

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" Close tab if it's the last window on the current tab.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"" Close if it's the last window (and no other tabs).
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
"   \  quit | endif

let g:NERDTreeQuitOnOpen=1
" By default, show hidden files in NERDTree (but not vim `.swp` files).
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['\.swp$', '\~$']





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""" Preferences.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Indentation preferences.
set shiftwidth=4
set softtabstop=4
set expandtab
set tabstop=4
"set autoindent
set smartindent
set rnu nu

set norelativenumber
set number
set whichwrap+=[,],<,>
let mapleader = ","


" Lexiconal highlighting.
let ayucolor="dark"   " Options: light, mirage, dark

syntax enable
set termguicolors
set background=dark
colorscheme ayu         " Options: desert, ayu, PaperColor


"" Instead of having Emacs ^fbnp, I'm considering having ^hjkl in insert
"" mode, that way I don't get confused when I switch from insert to normal.
"" I'm also just considering removing Emacs movement from normal mode.

" Emacs movement bindings in insert mode.
inoremap <C-n> <down>
inoremap <C-p> <up>
inoremap <C-f> <right>
inoremap <C-b> <left>

" Emacs movement bindings in normal (all?) mode.
noremap <C-n> <down>
noremap <C-p> <up>
noremap <C-f> <right>
noremap <C-b> <left>

"" Emacs style movement in insert mode.
"inoremap <C-h> <left>
"inoremap <C-j> <down>
"inoremap <C-k> <up>
"inoremap <C-l> <right>


"" Why did I ever use the following?
"augroup numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
"augroup END

" NERDTree!
nnoremap <leader>q :NERDTreeFocus<CR>
nnoremap <leader>w :NERDTreeFind<CR>
nnoremap <leader>[ :NERDTreeToggle<CR>

