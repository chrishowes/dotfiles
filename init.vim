" plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-rvm'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround' 
Plug 'tpope/vim-commentary'
Plug 'dsawardekar/portkey'
" Plug 'dsawardekar/ember.vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fireplace', {'for': ['clojure', 'clojurescript']}
Plug 'guns/vim-sexp', {'for': ['clojure', 'clojurescript']}
Plug 'venantius/vim-cljfmt', {'for': ['clojure', 'clojurescript']}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': ['clojure', 'clojurescript']}
Plug 'sickill/vim-monokai'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'mkarmona/colorsbox'
Plug 'scrooloose/nerdtree'
Plug 'albfan/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bhurlow/vim-parinfer', {'for': ['clojure', 'clojurescript']}
Plug 'easymotion/vim-easymotion'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mustache/vim-mustache-handlebars'
Plug 'benekastah/neomake'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/dbext.vim'
Plug 'xolox/vim-misc'
Plug 'rking/ag.vim'
Plug 'Chun-Yang/vim-action-ag'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
Plug 'kchmck/vim-coffee-script', {'for': ['coffee']}
Plug 'chrisbra/csv.vim'
Plug 'Konfekt/FastFold'
Plug 'vim-scripts/Tabmerge'
Plug 'vim-scripts/marvim'
Plug 'posva/vim-vue'
Plug 'killphi/vim-legend'
call plug#end()

" easytags
let g:easytags_async = 1

" portkey
let maplocalleader = ';'

" neomake
let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'WarningMsg',
  \ }

let g:neomake_error_sign = {
  \ 'text': 'E',
  \ 'texthl': 'ErrorMsg',
  \ }

" autocmd! BufWritePost * Neomake

let g:neomake_logfile = '/tmp/neomake.log'

let g:neomake_javascript_enabled_makers = ['jshint']

" colorsbox
color monokai

" easymotion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

nmap ;l <Plug>(easymotion-lineforward)
nmap ;j <Plug>(easymotion-j)
nmap ;k <Plug>(easymotion-k)
nmap ;h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" ctrl-p
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
map <C-t> :CtrlPTag<CR>

" nerdtree
map <C-e> :NERDTreeToggle<CR>

" splits
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" tabs
set expandtab shiftwidth=2 tabstop=2

" don't wrap long lines
set nowrap

" .boot -> clojure
autocmd BufNewFile,BufRead *.boot   set syntax=clojure | set filetype=clojure

" use clipboard as main register
set clipboard=unnamedplus

""" TABS TO SPACES CODE
" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

" force brands wants tabs, not spaces
autocmd BufRead */force-brands/*.js set expandtab!

command! SPT vsp|terminal
command! MY e $MYVIMRC
cnoreabbrev SQL DBExecSQL

" visitdays
command! VD cd ~/Projects/visitdays/mvp

" fgrep
function! FGrep(term)
  :Ag! . a:term . ~/Projects/visitdays/mvp/frontend/app/
endfunction

function! BGrep(term)
  :Ag! . a:term . ~/Projects/visitdays/mvp/app/
endfunction

nnoremap <leader>z :new<CR>:terminal<CR>source $HOME/.bash_profile<CR>


