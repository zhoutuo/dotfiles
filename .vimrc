" General settings
set nocompatible
filetype off

" Plug Setting
call plug#begin('~/.local/share/nvim/plugged')


Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'Shougo/deoplete.nvim'
Plug 'honza/vim-snippets'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-eunuch'
Plug 'vimwiki/vimwiki'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'autowitch/hive.vim'
Plug 'solarnz/thrift.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}


" Themes
Plug 'altercation/vim-colors-solarized'
Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}
Plug 'w0ng/vim-hybrid'


" Initialize plugin system
call plug#end()

filetype plugin indent on

syntax on
set mouse=
set mousehide
scriptencoding utf-8

if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else                   " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000

" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" Persistent Undo
set undofile
set undolevels=1000
set undoreload=10000


" Formating
set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=2                " Use indents of 2 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=2                   " An indentation every two columns
set softtabstop=2               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

" Remove trailing whitespaces and ^M chars
" To disable the stripping of whitespace, add the following to your
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,ruby autocmd BufWritePre <buffer> call StripTrailingWhitespace()
"autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
" preceding line best in a plugin but here for now.
autocmd BufNewFile,BufRead *.coffee set filetype=coffee

" for .hql files
au BufNewFile,BufRead *.hql set filetype=hive expandtab
" for .q files
au BufNewFile,BufRead *.q set filetype=hive expandtab

" UI
set background=dark             " Dark theme
let g:hybrid_custom_term_colors = 1
colorscheme hybrid              " Load a colorscheme

set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode

set cursorline                  " Highlight current line

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode


set colorcolumn=80              " A ruler for 80 characters
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set relativenumber              " Relative line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor

" Highlight problematic whitespace
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.





"  Key Mappings
let mapleader = ','

" Shift Fixes
if has("user_commands")
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif

" Easer moving in panes and tabs
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

map <S-H> gT
map <S-L> gt

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Yanked char goes to blackhole
nnoremap x "_x

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

nmap <F8> :TagbarOpenAutoClose<CR>

" Disable Ex mode
map Q <Nop>



" Funcions

function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function CopyPath()
  let @*=expand('%')
endfunction
command! -nargs=0 CopyPath     call CopyPath()

function PrintPath()
  echo expand('%')
endfunction
command! -nargs=0 Path     call PrintPath()

function CopyName()
  let @*=expand('%:t')
endfunction
command! -nargs=0 CopyName     call CopyName()


"  Plugin Configurations

" Deoplete
let g:deoplete#enable_at_startup = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


" remap Ultisnips for compatibility for YCM
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'


" airline
set laststatus=2  " vim-airline doesn't appear until I create a new split
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'


"" Ale
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0
"let g:ale_linter_aliases = {'javascript.jsx': 'javascript', 'jsx': 'javascript'}
"let g:ale_linters = { 'javascript': ['eslint'] }
"let g:ale_javascript_eslint_use_global = 0


" Tagbar
let g:tagbar_sort = 0

" repeat.vim
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" startify 
let g:ctrlp_reuse_window = 'startify'
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1

let g:github_enterprise_urls = ['https://git.musta.ch']

" fzf
let g:fzf_layout = { 'down': '~40%' }
nnoremap <C-P> :GFiles --exclude-standard -co<cr>
nnoremap <Leader>fu :BLines<Cr>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W>\b<CR>
