" ---------------------------------------------------------------------------
"  General
" ---------------------------------------------------------------------------

set nocompatible           " we're running Vim, not Vi!
set tabpagemax=50          " open 50 tabs max
filetype plugin indent on  " load filetype plugin
set history=1000           " lots of command line history

" ----------------------------------------------------------------------------
"  Backups
" ----------------------------------------------------------------------------

set nobackup               " do not keep backups after close
set nowritebackup          " do not keep a backup while working
set noswapfile             " don't keep swp files either
set backupdir=$HOME/.vim/backup " store backups under ~/.vim/backup
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

" enable spellchecking for non-code files
au BufRead,BufNewFile *.txt set spell
au BufRead,BufNewFile *.rdoc set spell
au BufRead,BufNewFile *.textile set spell

" on save, make file executable if has shebang line with '/bin/'
au BufWritePost * if getline(1) =~ "^#!.*/bin/" | silent !chmod a+x <afile> | endif

" ----------------------------------------------------------------------------
"  Mappings
" ----------------------------------------------------------------------------

" Shift-Space to toggle insert mode
:imap <S-Space> <Esc>
:nmap <S-Space> i

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" ,; opens ~/.vimrc
map ,; :tabe ~/.vimrc<CR><C-W>_

" ,: reloads .vimrc
map <silent> ,: :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" faster viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" easy file saving
map <C-s> :w<CR>

" syntax check Ruby script
map <LocalLeader>sr :!ruby -c %<cr>

" insert Ruby hash pointer (" => ")
imap <S-A-l> <Space>=><Space>

" ---------------------------------------------------------------------------
"  Variables
" ---------------------------------------------------------------------------

let maplocalleader = ","

" ---------------------------------------------------------------------------
"  Strip Trailing Whitespace
" ---------------------------------------------------------------------------

function! KillWhitespace ()
  exec ':%s/\s\+$//g'
endfunction
map <LocalLeader>ks :call KillWhitespace ()<CR>

" ---------------------------------------------------------------------------
"  Convert Tabs to Spaces
" ---------------------------------------------------------------------------

function! KillTabs ()
  exec ':%s/\t/  /g'
endfunction
map <LocalLeader>kt :call KillTabs ()<CR>

" ---------------------------------------------------------------------------
"  Kill DOS Line Breaks
" ---------------------------------------------------------------------------

function! KillDosLineBreaks ()
  exec ':%s///g'
endfunction
map <LocalLeader>kd :call KillDosLineBreaks ()<CR>

" ----------------------------------------------------------------------------
"  Graphical
" ----------------------------------------------------------------------------

if has('gui_running')
  colorscheme lucius
  set guifont=Monospace\ 8
  "set guifont=Anonymous\ Pro\ 8
  winpos 1100 0                " put window at right edge of left monitor
  set lines=85                 " window height
  set columns=140              " window columns
  set guioptions=gemc          " show menu, tabs, console dialogs
  set number                   " show line numbers

  " -------------------------------------------------------------------------
  "  Copy/Paste Shortcuts
  " -------------------------------------------------------------------------

  " copy to system clipboard
  vmap <C-c> "+y

  " paste in NORMAL mode from system clipboard (at or after cursor)
  nmap <LocalLeader>V "+gP
  nmap <LocalLeader>v "+gp

  " paste in INSERT mode from Vim's clipboard (unnamed register)
  imap ppp <ESC>pa

  " paste in INSERT mode from system clipboard
  imap vv <ESC>"+gpa

  " paste in COMMAND mode from Vim's clipboard (unnamed register)
  cmap ppp <C-r>"

  " paste in COMMAND mode from system clipboard
  cmap vv <C-r>+

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
  map <LocalLeader>t :tabnew<cr>

  " C-TAB and C-SHIFT-TAB cycle tabs forward and backward
  nmap <c-tab> :tabnext<cr>
  imap <c-tab> <c-o>:tabnext<cr>
  vmap <c-tab> <c-o>:tabnext<cr>
  nmap <c-s-tab> :tabprevious<cr>
  imap <c-s-tab> <c-o>:tabprevious<cr>
  vmap <c-s-tab> <c-o>:tabprevious<cr>

  " jump directly to tab
  let i=1
  while i<=9
    execute "map <LocalLeader>".i." ".i."gt<cr>"
    "execute "nmap <C-".i."> ".i."gt"
    "execute "vmap <C-".i."> ".i."gt"
    "execute "imap <C-".i."> <ESC>".i."gt"
    let i+=1
  endwhile
endif
