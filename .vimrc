" ---------------------------------------------------------------------------
"  General
" ---------------------------------------------------------------------------

set nocompatible           " we're running Vim, not Vi!
set modelines=0            " prevent security exploits
set tabpagemax=50          " open 50 tabs max
filetype plugin indent on  " load filetype plugin
set history=1000           " lots of command line history

" ----------------------------------------------------------------------------
"  Backups
" ----------------------------------------------------------------------------

set nobackup               " do not keep backups after close
set nowritebackup          " do not keep a backup while working
set noswapfile             " don't keep swp files either
set backupdir=~/.vim/backup " store backups under ~/.vim/backup
set backupcopy=yes         " keep attributes of original file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vim/swap,~/tmp,. " keep swp files under ~/.vim/swap

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set ruler                  " show the cursor position all the time
set scrolloff=3            " start scrolling before cursor at end
set noshowcmd              " don't display incomplete commands
set nolazyredraw           " turn off lazy redraw
set wildmenu               " turn on wild menu (better filename completion)
set wildmode=list:longest,full
set backspace=2            " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set shortmess=atI          " shorten messages
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling
set linebreak              " wrap long lines between words

" ----------------------------------------------------------------------------
"  Visual Cues
" ----------------------------------------------------------------------------

syntax on                  " enable syntax highlighting
let loaded_matchparen=1    " don't hightlight matching brackets/braces
set laststatus=2           " always show the status line
set hlsearch               " highlight all search terms
set incsearch              " highlight search text as entered
set ignorecase             " ignore case when searching
set smartcase              " case sensitive only if capitals in search term
"set colorcolumn=80        " not available until Vim 7.3
set visualbell             " shut the fuck up

" ----------------------------------------------------------------------------
"  Text Formatting
" ----------------------------------------------------------------------------

set expandtab              " expand tabs to spaces
set softtabstop=2
set shiftwidth=2           " distance to shift lines with < and >

" ----------------------------------------------------------------------------
"  Autocommands
" ----------------------------------------------------------------------------

" on save, make file executable if has shebang line with '/bin/'
au BufWritePost * if getline(1) =~ "^#!.*/bin/" | silent !chmod a+x <afile> | endif

" ---------------------------------------------------------------------------
"  Variables
" ---------------------------------------------------------------------------

let maplocalleader = ","
let g:ackprg="ack-grep\\ -H\\ --nocolor\\ --nogroup\\ --column" " for Ack plugin

" ----------------------------------------------------------------------------
"  Mappings
" ----------------------------------------------------------------------------

" kj to exit insert mode
imap kj <Esc>

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" ,; opens ~/.vimrc
map ,; :tabe ~/.vimrc<CR><C-W>_

" ,: reloads .vimrc
map <silent> ,: :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" move up and down by screen lines instead of text lines
nnoremap j gj
nnoremap k gk

" faster viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" easy file saving
map <C-s> :w<CR>

" easy ack
nnoremap <LocalLeader>a :Ack 

" syntax check Ruby script
map <LocalLeader>cr :!ruby -c %<cr>

" insert Ruby hash pointer (" => ")
imap <S-A-l> <Space>=><Space>

" change directory to that of current file
cmap cdc cd %:p:h

" ---------------------------------------------------------------------------
"  Split Navigation
" ---------------------------------------------------------------------------

" go left, right, up, down
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" ---------------------------------------------------------------------------
"  Spell Checking
" ---------------------------------------------------------------------------

" ,ss toggles spell checking
map <LocalLeader>ss :setlocal spell!<cr>

" spell checking shortcuts (next, prev, add, suggest)
map <LocalLeader>sn ]s
map <LocalLeader>sp [s
map <LocalLeader>sa zg
map <LocalLeader>s? z=

" ---------------------------------------------------------------------------
"  Handling Whitespace
" ---------------------------------------------------------------------------

"  strip trailing whitespace
map <LocalLeader>ks :%s/\s\+$//g<CR>

"  convert tabs to spaces
map <LocalLeader>kt :%s/\t/  /g<CR>

"  kill DOS line breaks
map <LocalLeader>kd :%s///g<CR>

" ---------------------------------------------------------------------------
"  Copy/Paste Shortcuts
" ---------------------------------------------------------------------------

" copy to system clipboard
vmap <C-c> "+y

" paste in NORMAL mode from system clipboard (at or after cursor)
nmap <LocalLeader>V "+gP
nmap <LocalLeader>v "+gp

" paste in INSERT mode from Vim's clipboard (unnamed register)
imap vp <ESC>pa

" paste in INSERT mode from system clipboard
imap vv <ESC>"+gpa

" paste in COMMAND mode from Vim's clipboard (unnamed register)
cmap vp <C-r>"

" paste in COMMAND mode from system clipboard
cmap vv <C-r>+

" ----------------------------------------------------------------------------
"  Graphical
" ----------------------------------------------------------------------------

if has('gui_running')

  if system("uname") == "Darwin" " on OSX
    set lines=55
    set columns=84
  else                         " on Ubuntu
    set guifont=Monospace\ 8
    winpos 1100 0              " put window at right edge of left monitor
    set lines=85
    set columns=140
  endif

  colorscheme losh_molokai
  set guioptions=gemc          " show menu, tabs, console dialogs
  set number                   " show line numbers

  " --------------------------------------------------------------------------
  "  Highlight Trailing Whitespace
  " --------------------------------------------------------------------------

  " note that this inhibits the linebreak option so lines will wrap mid-word
  set list listchars=trail:.,tab:>.
  highlight SpecialKey ctermfg=DarkGray ctermbg=Black

  " --------------------------------------------------------------------------
  "  Tab Navigation
  " --------------------------------------------------------------------------

  set guitablabel=%N\ %t\ %M\ %r

  " quick open new tab
  map <LocalLeader>t :tabnew<CR>

  " C-TAB and C-SHIFT-TAB cycle tabs forward and backward
  nmap <C-tab> :tabnext<CR>
  imap <C-tab> <C-o>:tabnext<CR>
  vmap <C-tab> <C-o>:tabnext<CR>
  nmap <C-S-tab> :tabprevious<CR>
  imap <C-S-tab> <C-o>:tabprevious<CR>
  vmap <C-S-tab> <C-o>:tabprevious<CR>

  " jump directly to tab
  let i=1
  while i<=9
    execute "map <LocalLeader>".i." ".i."gt<CR>"
    let i+=1
  endwhile
endif
