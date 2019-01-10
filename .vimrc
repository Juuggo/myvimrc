set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
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
Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
" 这个插件可以显示文件的Git增删状态
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'wakatime/vim-wakatime'
Plugin 'scrooloose/nerdcommenter'
Plugin 'junegunn/vim-easy-align'
" Plugin 'alvan/vim-closetag'
Plugin 'vimwiki/vimwiki'
"
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
Plugin 'taglist.vim'
Plugin 'fcitx.vim'
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
set background=dark
set ttimeoutlen=100

" ======for vimwiki======
set nocompatible
syntax on;
let g:vimwiki_folding = 'syntax'

" == extended % matching for HTML, LaTeX, and many other languages ==
runtime macros/matchit.vim
filetype plugin on

" ============ YCM =============
" turn off YCM
nnoremap <leader>y :let g:ycm_auto_trigger=0<CR>               
"turn on YCM
nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR>                
let g:ycm_auto_trigger = 0
let g:ycm_cache_omnifunc = 1

" ======== NERDCommenter =======
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

" ========= NerdTree ===========
" Ctrl+N 打开/关闭
map <C-n> :NERDTreeToggle<CR>
" 当所有文件关闭时关闭项目树窗格
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() ) | q | endif

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

