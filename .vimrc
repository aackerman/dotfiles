" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" =============== Pathogen Initialization ===============
" This loads all the plugins in ~/.vim/bundle
" Use tpope's pathogen plugin to manage all other plugins

  runtime bundle/tpope-vim-pathogen/autoload/pathogen.vim
  call pathogen#infect()
  call pathogen#helptags()

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" ================ Search Settings  =================

set incsearch        "Find the next match as we type the search
set hlsearch         "Hilight searches by default
set viminfo='100,f1  "Save up to 100 marks, enable capital marks

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
"set list listchars=tab:\ \ ,trail:·
"set list listchars=trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1


" =============== Personal Customizations ================
colors monokai
set ff=unix

" Allow for split window expand / collapse using CTRL-j / CTRL-k.  Useful for
" editing many files in one window, switching back and forth.
map <c-j> <c-w>j<c-w>_
map <c-k> <c-w>k<c-w>_
set winminheight=0

" Amendment to the window-switching tip above.  This allows them
" to be hidden out of sight for more real estate.
set hidden

" Begin switch mode code: handle either buffer or window c-j/c-k switches
function MapForBuffers()
	noremap <c-j> :only<cr>:bnext<cr>
	inoremap <c-j> <esc>:only<cr>:bnext<cr>
	noremap <c-k> :only<cr>:bprev<cr>
	inoremap <c-k> <esc>:only<cr>:bprev<cr>
	:only
endfunction

function MapForWindows()
	:unhide
	noremap <c-j> <c-w>j<c-w>_
	inoremap <c-j> <esc><c-w>j<c-w>_
	noremap <c-k> <c-w>k<c-w>_
	inoremap <c-k> <esc><c-w>k<c-w>_
endfunction

function MapSwitchMode()
	if g:switchmode == "windows"
		call MapForWindows()
	else
		call MapForBuffers()
	endif
endfunction

let g:switchmode = "windows"
call MapSwitchMode()

function ToggleSwitchMode()
	if g:switchmode == "windows"
		let g:switchmode = "buffers"
	else
		let g:switchmode = "windows"
	endif
	call MapSwitchMode()
	
endfunction
