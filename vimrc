" start pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on
set ts=4
set shiftwidth=4
set cursorline
set expandtab

set nu
set backspace=indent,eol,start
set background=dark

set path=$PWD/**

let g:solarized_termcolors=256
colorscheme solarized

let g:go_disable_autoinstall = 0

" Highlight
let g:go_highlight_functions = 1  
let g:go_highlight_methods = 1  
let g:go_highlight_structs = 1  
let g:go_highlight_operators = 1  
let g:go_highlight_build_constraints = 1
let g:neocomplete#enable_at_startup = 1
" setlocal omnifunc=go#complete#Complete
" colorscheme molokai

" cptrl+p disable dirs
let g:ctrlp_custom_ignore = '\.(git|hg|svn),vendor'
" set ctags binary to gnu version
let g:tagbar_ctag_bin = '/usr/local/bin/ctags'

" automatically add current dir to gopath
if !empty(glob("src"))
    let $GOPATH=getcwd()
    let $GOBIN=getcwd() . "/bin"
    let $PATH=$GOBIN . ":" . $PATH
endif
if !empty(glob("vendor"))
    let $P=getcwd() . "/vendor"
    let $GOPATH=$GOPATH . ":" . $P
endif
" key mappings
nmap <F8> :TagbarToggle<CR>
map <F7> :NERDTreeToggle<CR>

" configure tags for go 
let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" show overlenght
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
au FileType python match OverLength /\%81v.\+/


" vim airline configuration
" show bufferlist
let g:airline#extensions#tabline#enabled = 1
" show filename
let g:airline#extensions#tabline#fnamemod = ':t'

"Working with buffers
set hidden
nnoremap bn :bnext<CR>
nnoremap bp :bprev<CR>
nnoremap bd :bdelete<CR>
nnoremap bl :BufExplorer<CR>

au BufNewFile,BufRead *jenkinsfile* setf groovy
