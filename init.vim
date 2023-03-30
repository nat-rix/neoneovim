set nocompatible
set showmatch
set ignorecase
set smartcase
set mouse=a
set mousehide
set mousemodel=popup_setpos
set mouseshape=
set selectmode=
set nrformats=bin,hex,unsigned
set clipboard=unnamedplus
set number
set relativenumber
set numberwidth=3
set nofoldenable
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
set nospell
set guioptions=Pdeip
set hlsearch
set incsearch
set softtabstop=0 noexpandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set smarttab
set wildmode=longest,list
set shortmess=mnrxoOstT
set noswapfile
set nowritebackup
set switchbuf=uselast
set visualbell
set wildmenu
set wildchar=<TAB>
set wildignore=*.o,*.a,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/target/*,**/node_modules/**,*/a.out
set wildoptions+=pum
set winblend=0
set termguicolors
set cursorline
set encoding=utf8
filetype plugin on
filetype indent on
syntax on
set autoread
set path+=**
set lazyredraw
set magic
set scrolloff=5
set nowrap
set history=1024
set list
set listchars+=space:⋅
" set listchars+=eol:↴
set pumblend=0
" global statusline
set laststatus=3
let mapleader = ','


let g:loaded_netrw=1
let g:loaded_netrwPlugin=1


" ==================================================
" ====   KEYMAPPING   ==============================
" ==================================================

noremap s h
noremap n j
noremap r k
noremap t l

noremap i b
noremap I B
noremap l r
noremap L R
noremap u i
noremap U I
noremap b v
noremap B V
noremap <C-b> <C-v>
noremap v u
noremap V <C-r>

noremap h s
noremap H S
noremap ä <C-i>
noremap Ä <C-o>
noremap j n
noremap J N
nnoremap 0 ^
vnoremap 0 ^

vnoremap <C-c> "+y
vnoremap <C-v> d"+p
inoremap <C-v> <esc>"+p
nnoremap <C-v> "+p

noremap gn <cmd>BufferNext<cr>
noremap gp <cmd>BufferPrevious<cr>
noremap g) <cmd>BufferMoveNext<cr>
noremap g( <cmd>BufferMovePrevious<cr>

" Movement between windows
noremap <C-UP> <C-W><UP>
noremap <C-DOWN> <C-W><DOWN>
noremap <C-LEFT> <C-W><LEFT>
noremap <C-RIGHT> <C-W><RIGHT>
inoremap <C-UP> <ESC><C-W><UP>
inoremap <C-DOWN> <ESC><C-W><DOWN>
inoremap <C-LEFT> <ESC><C-W><LEFT>
inoremap <C-RIGHT> <ESC><C-W><RIGHT>

cabbrev bc BufferClose
cabbrev Update PackerUpdate
cabbrev Install PackerInstall
cabbrev Compile PackerCompile
cabbrev Compile PackerCompile
cabbrev Cargo RustOpenCargo

" sudo write file
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

noremap gm <cmd>Telescope man_pages sections=ALL<cr>
noremap ga <cmd>Lspsaga code_action<cr>
noremap <F2> <cmd>Lspsaga rename<cr>
noremap gd <cmd>lua vim.lsp.buf.definition()<cr>
noremap gt <cmd>Trouble<cr>
noremap <leader>o <cmd>Telescope buffers<cr>
noremap ? <cmd>Lspsaga hover_doc<cr>

noremap gf <cmd>Telescope find_files<cr>

" ==================================================
" ====   Plugin Stuff ==============================
" ==================================================

lua require('plugins')
execute "source " . stdpath('config') . "/lua/plugins.lua"

" cool schemes are gruvbox, neon, habamax, slate
colorscheme melange

command LspServers lua for _, server in pairs(require('lspconfig').util.available_servers()) do print(server) end
command Format lua vim.lsp.buf.format()
autocmd BufWritePre * Format
hi Normal guibg=none

