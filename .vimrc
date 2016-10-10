" Written by Josh Hartwell, borrowed from many other places

" TODO: ruler not working

" load my custom functions. I keep them in a separate file because they're messy and long
source ~/.vim/my-functions.vim

" don't try to be compatible with original vi, meaning don't assume weird settings
set nocompatible

" sets location of viminfo, to clean up home directory
set viminfo+=n~/.vim/viminfo

" show line count, but show relative line count. Toggle with <leader>n (see below)
set number
set relativenumber

" Always show current position in text at the bottom right
set ruler

" Height of the command bar, we like two so there's a line dedicated to mode
set cmdheight=2

" Always show the status line
set laststatus=2

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
" filetype plugin on
" filetype indent on

" Set to auto read when a file is changed from the outside
let autoreadargs={'autoread':1} 
execute WatchForChanges("*",autoreadargs) 

" Turn on the wild menu, set it up to act nice
set wildmenu
set wildmode=list:longest,full

" Ignore compiled files and some common binary files with wild menu
set wildignore=*.o,*~,*.pyc,*.exe,*.dll,*.jar,*.zip,*.tar.gz,*.tar,*.bz2

" A buffer becomes hidden when it is abandoned
" TODO: I don't know what buffers are
" set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Search with ignore case, smart case, highlight results, incrementally
" smart case ignores "ignore case" if we include uppercase characters
set ignorecase
set smartcase
set hlsearch
set incsearch

" Have the bottom of the screen tell us what mode we're in, show our command
set showmode
set showcmd

" Disable modelines, a feature that lets text files have special vim commands in them, y u c k
set modelines=0

" Tells vim we have a fast tty connection, so it's not shy about writing characters to screen
set ttyfast

" Always ensure there are N lines above and below cursor when scrolling
set scrolloff=3

" Auto indent text
set autoindent

" Don't redraw while executing macros (good performance config)
"set lazyredraw

" make special regex chars work, and disable with \. example: $ is eol, \$ is $
set magic

" disable parenthesis match highlighting
let loaded_matchparen = 1

" Disable audible notifications on error
" set noerrorbells

" Disable visual notifications on error
" set novisualbell                  
" set t_vb=                         

" How long to wait for character input for commands
set timeoutlen=500                          

" Setup mouse. We need to put this in some kind of if
" set ttymouse=xterm2
" set mouse=a

" Enable syntax, setup our theme, set background, and other visual niceties
" our theme doesn't have a good cursorline setting, so we hard code one. TODO: "todo" doesn't highlight right
syntax enable
colorscheme desert256
set background=dark
hi CursorLine ctermbg=237 cterm=NONE

"Show cursorline when we're in insert mode
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set extra options when running in GUI mode
" if has("gui_running")
"     set guioptions-=T
"     set guioptions+=e
"     set guitablabel=%M\ %t
" endif

" Turn backup and swapfile off
set nobackup
set nowritebackup
set noswapfile

" Use spaces instead of tabs and set tabwidth
set expandtab
set softtabstop=3              
set shiftwidth=3
set smarttab
set tabstop=3

" Break lines visually (without inserting a newlinew character) if they're too long
" set linebreak

" Smart indent
set smartindent

" Wrap lines
set wrap

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Smart way to move between split panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Specify the behavior when switching between buffers
" try
"   set switchbuf=useopen,usetab,newtab
"   set stal=2
" catch
" endtry

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
   function! HasPaste()
       if &paste
           return 'PASTE MODE  '
       en
       return ''
   endfunction

" make it default to using the system clipboard
set clipboard=unnamed

" make wrapped lines indent properly, but only if we're on a new enough version of vim
if v:version >= 704
	set breakindent
endif

" Allow 256 colors
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

""""""""""""""""""""""""""""""""""""""""""
"            Map Leader Codes            "
""""""""""""""""""""""""""""""""""""""""""

" Set our map leader to space, and get rid of spaces's previous functionality (moving the cursor)
noremap <Space> <NOP>
let mapleader = " " 

" <space>: Clear higlights
nmap <silent> <leader><space> :noh<cr>

" n: toggle line number absolute / relative
nnoremap <leader>n :call NumberToggle()<cr>
   function! NumberToggle()
     if(&relativenumber == 1)
       set norelativenumber
     else
       set relativenumber
     endif
   endfunc

" o and O: add blank lines, below and above
nmap <leader>o o<Esc>
nmap <leader>O O<Esc>

" p: Toggle paste mode on and off
map <leader>p :setlocal paste!<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>

" Pressing <leader>ss will toggle and untoggle spell checking, and other spellcheck shortcuts
map <leader>ss :setlocal spell!<cr>
" map <leader>sn ]s
" map <leader>sp [s
" map <leader>sa zg
" map <leader>s? z=

" This is really cool
" http://unix.stackexchange.com/questions/252948/vim-is-there-a-way-to-get-immediate-visual-feedback-during-insert-in-visual-bl/
" Lets me get immediate visual feedback when doing an insert in visual-block mode

nmap <buffer> <silent> <expr> <F12> InsertCol()
imap <buffer> <silent> <expr> <F12> InsertCol()

vmap I I<F12>

function! InsertCol()
   let w:first_call = exists('w:first_call') ? 0 : 1
   "if w:first_call
   "    startinsert
   "endif
   try
       let char = getchar()
   catch /^Vim:Interrupt$/
       let char = "\<Esc>"
   endtry
   if char == '^\d\+$' || type(char) == 0
       let char = nr2char(char)
   endif " It is the ascii code.
   if char == "\<Esc>"
       unlet w:first_call
       return char
   endif
   redraw
   if w:first_call
       return char."\<Esc>gvA\<C-R>=Redraw()\<CR>\<F12>"
   else
       return char."\<Esc>gvlA\<C-R>=Redraw()\<CR>\<F12>"
   endif
endfunction

function! Redraw()
    redraw
    return ''
endfunction
