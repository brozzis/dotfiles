" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

set nocompatible           " we're running Vim, not Vi!
set tabpagemax=50          " open 50 tabs max
filetype plugin indent on  " load filetype plugin

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set ruler                  " show the cursor position all the time
set noshowcmd              " don't display incomplete commands
set nolazyredraw           " turn off lazy redraw
set wildmenu               " turn on wild menu (better filename completion)
set wildmode=list:longest,full
set backspace=2            " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling

" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set showmatch              " brackets/braces that is
set mat=5                  " duration to show matching brace (1/10 sec)
set laststatus=2           " always show the status line
set ignorecase             " ignore case when searching
set hlsearch               " highlight all search terms
set incsearch              " highlight search text as entered
set visualbell             " shut the fuck up

" ----------------------------------------------------------------------------
" Text Formatting
" ----------------------------------------------------------------------------

set tabstop=2
set expandtab              " expand tabs to spaces
set textwidth=80           " wrap at 80 chars by default
set formatoptions=l        " don't wrap in middle of words

" ---------------------------------------------------------------------------
" Colors / Theme
" ---------------------------------------------------------------------------

colorscheme native         " also nice: corporation, wombat
syntax on                  " enable syntax highlighting

" ----------------------------------------------------------------------------
"   Highlight Trailing Whitespace
" ----------------------------------------------------------------------------

set list listchars=trail:.,tab:>.
highlight SpecialKey ctermfg=DarkGray ctermbg=Black

" ----------------------------------------------------------------------------
"  Auto Commands
" ----------------------------------------------------------------------------

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END

" ----------------------------------------------------------------------------
"  Mappings
" ----------------------------------------------------------------------------

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" don't highlight matching brackets
let g:loaded_matchparen= 1

",v opens ~/.vimrc
map ,v :sp ~/.vimrc<CR><C-W>_

",V reloads .vimrc
map <silent> ,V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" ----------------------------------------------------------------------------
"  Graphical
" ----------------------------------------------------------------------------

if has('gui_running')
  set guifont=Monospace\ 8     " use this font 
  set anti                     " antialiasing
  "set guioptions=gemc
  winpos 1100 0
  set lines=85                 " window height
  set columns=140              " window columns

  set number                   " show line numbers

  autocmd VimEnter * NERDTree  " open NERDTree on start
  autocmd VimEnter * wincmd p  " move cursor out of NERDTree
endif
