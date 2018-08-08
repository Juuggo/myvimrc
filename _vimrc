set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/bundle/Vundle.vim
call vundle#begin('~/vimfiles/bundle/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
"
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
Plugin 'junegunn/vim-easy-align'
Plugin 'alvan/vim-closetag'
"
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Plugin 'taglist.vim'
" Plugin 'fcitx.vim'
"
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
"
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
"
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" =============================
set shiftwidth=4
set tabstop=4
set expandtab
set number
set hlsearch
set splitright
set cursorline
highlight CursorLine cterm=NONE ctermbg=gray ctermfg=NONE guibg=NONE guifg=NONE
let g:airline_powerline_fonts = 1 
let g:gruvbox_italic=1
colorscheme gruvbox
set background=light
set ttimeoutlen=100
set guifont=consolas:h14
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" == extended % matching for HTML, LaTeX, and many other languages ==
runtime macros/matchit.vim
filetype plugin on

" ======== NERDCommenter =======
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

" ========= NerdTree ===========
" Ctrl+N 打开/关闭
map <C-n> :NERDTreeToggle<CR>
" 当所有文件关闭时关闭项目树窗格
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" ========== taglist ===========
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
map <C-t> :TlistToggle<CR>

" ======= Vim-easy-align ======
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ====== 自动补全括号引号 =====
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
autocmd Syntax vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

inoremap { {}<Esc>i
inoremap } <c-r>=CloseBracket()<CR>
inoremap {<CR> {<CR>}<Esc>O

function CloseBracket()
    if getline('.')[col('.') - 1] == "}"
        return "\<Right>"
    else
        if match(getline(line('.') + 1), '\s*}') >= 0
            return "\<Esc>j0f}a"
        else
            return "\<CR>}"
        endif
    endif
endf

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf


function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
        return a:char
    elseif line[col - 1] == a:char
        return "\<Right>"
    else
        return a:char.a:char."\<Esc>i"
    endif
endf
