call plug#begin('~/.vim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'itchyny/lightline.vim'
Plug 'gregsexton/MatchTag'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/syntastic'
Plug 'Chiel92/vim-autoformat'
Plug 'skammer/vim-css-color'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'mgpnd/vim-lapmat256'
Plug 'editorconfig/editorconfig-vim'

call plug#end()

colorscheme lapmat256

set ignorecase
set number
set laststatus=2
set showcmd
set tabstop=2
set shiftwidth=2
set expandtab
set encoding=utf-8

syntax on
filetype plugin indent on

" Navigate with jkl; instead of hjkl
noremap ; l
noremap l k
noremap k j
noremap j h

nnoremap <C-w>; <C-w>l
nnoremap <C-w>l <C-w>k
nnoremap <C-w>k <C-w>j
nnoremap <C-w>j <C-w>h

nnoremap <C-w>: <C-w>L
nnoremap <C-w>L <C-w>K
nnoremap <C-w>K <C-w>J
nnoremap <C-w>J <C-w>H

nmap <M-q> <Esc>
imap <M-q> <Esc>
vmap <M-q> <Esc>

" NERDTree
map <silent> <C-n> :NERDTreeToggle<CR>

" Unite
nnoremap <space>/ :Unite grep:.<CR>
nnoremap <C-p> :Unite -start-insert file_rec<CR>
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 14
let g:unite_candidate_icon="▷"

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_full_redraws = 0
let g:syntastic_javascript_checkers = ['eslint']

" OmniSharp
set noshowmatch
" let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" let g:OmniSharp_timeout = 1
let g:OmniSharp_server_type = 'roslyn'
" let g:Omnisharp_start_server = 0
" let g:Omnisharp_stop_server = 0
" let g:OmniSharp_server_type = 'v1'
let g:OmniSharp_selector_ui = 'unite'
let g:syntastic_cs_checkers = ['code_checker']
augroup omnisharp_commands
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
    " Contextual code actions (requires CtrlP or unite.vim)
    nnoremap <C-space> :OmniSharpGetCodeActions<cr>
    " Run code actions with text selected in visual mode to extract method
    vnoremap <C-space> :call OmniSharp#GetCodeActions('visual')<cr>
    " rename with dialog
    nnoremap <F2> :OmniSharpRename<cr>
    nnoremap <F12> :OmniSharpGotoDefinition<cr>
augroup END

" Autoformat
noremap <F3> :Autoformat<CR>
let g:formatdef_my_custom_cs = '"astyle --mode=cs --style=allman -pcOHNs4"'
let g:formatters_cs = ['my_custom_cs']
let g:formatters_js = ['jscs']

" Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ }
    \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? ' '._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'Function_Name_1',
  \ 'prog': 'Function_Name_2',
  \ }
function! Function_Name_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  let g:lightline.ctrlp_marked = a:marked
  return lightline#statusline(0)
endfunction
function! Function_Name_2(str)
  return lightline#statusline(0)
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
