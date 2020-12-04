" Author: MinuteSheep<minutesheep@163.com>"  __  __ ____        _   ___     ___
" |  \/  / ___|      | \ | \ \   / (_)_ __ ___
" | |\/| \___ \ _____|  \| |\ \ / /| | '_ ` _ \
" | |  | |___) |_____| |\  | \ V / | | | | | | |
" |_|  |_|____/      |_| \_|  \_/  |_|_| |_| |_|

" -------- -------- -------- -------- -------- --------
"  首次自动配置
" -------- -------- -------- -------- -------- --------
if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" -------- -------- -------- -------- -------- --------
"  基本设置
" -------- -------- -------- -------- -------- --------
" 自动排版
filetype indent on
" 语法高亮
syntax on
" 让vim可以使用系统的剪切板
set clipboard=unnamed
" 设置行号
set number
" set relativenumber
" 自动设当前编辑文件所在目录为当前工作目录
" set autochdir
" 高亮第81列
" set cc=81
" 80字符自动换行
set textwidth=80
" tab大小
set ts=4
set expandtab
" 自动缩进
set autoindent
set smartindent
" 去掉vi一致性模式
" set nocompatible
set backspace=indent,start
" 开启真色,MacOs Terminal不需要开启真色
" set termguicolors
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" -------- -------- -------- -------- -------- --------
"  基本键位映射
" -------- -------- -------- -------- -------- --------
noremap H 0
noremap L $
noremap J 5j
noremap K 5k
noremap U <nop>
noremap U J
noremap s <nop>
inoremap <S-CR> <Esc>o
let mapleader=" "

" -------- -------- -------- -------- -------- --------
"  auto add head info
" -------- -------- -------- -------- -------- --------
function HeaderPython()
        call setline(1, "#!/usr/bin/env python")
        call append(1, "# -*- coding:UTF-8 -*-")
        call append(1, "# Author: MinuteSheep<minutesheep@163.com>")
        normal G
        normal 3o
endf
autocmd bufnewfile *.py call HeaderPython()

function HeaderShell()
        call setline(1, "#!/usr/bin/env bash")
        call append(1, "# Author: MinuteSheep<minutesheep@163.com>")
        normal G
        normal 3o
endf
autocmd bufnewfile *.sh call HeaderShell()

" -------- -------- -------- -------- -------- --------
"  QuickFix
" -------- -------- -------- -------- -------- --------
nmap <silent> cn :cn<cr>        " next error
nmap <silent> cp :cp<cr>        " previous error
nmap <silent> cx :cclose<cr>    " closse quicfix window
nmap <silent> cl :cl<cr>        " list all errors
nmap <silent> cc :cc<cr>        " show detailed error information
nmap <silent> cw :cw<cr>        " open error window if has errors
nmap <silent> co :copen<cr>     " open quickfix window

"-------- -------- -------- -------- -------- --------
" C,C++,Fortran,Python,java,sh等按R编译运行
"-------- -------- -------- -------- -------- --------
map R :call CompileAndRun()<CR>
func! CompileAndRun()
        exec "w"
        if &filetype == 'c'
                exec "AsyncRun! gcc % -o %< && ./%<"
                exec "copen | wincmd p"
        elseif &filetype == 'cpp'
                set splitbelow
                exec "AsyncRun! g++ -std=c++11 % -Wall -o %< && ./%<"
                exec "copen | wincmd p"
        elseif &filetype == 'java'
                exec "!javac %"
                exec "!time java %<"
        elseif &filetype == 'sh'
                :!time bash %
        elseif &filetype == 'python'
                exec "AsyncRun! -raw python %"
                exec "copen | wincmd p"
        elseif &filetype == 'html'
                silent! exec "!chromium % &"
        elseif &filetype == 'markdown'
                exec "MarkdownPreview"
        elseif &filetype == 'tex'
                silent! exec "VimtexStop"
                silent! exec "VimtexCompile"
        elseif &filetype == 'go'
                set splitbelow
                :sp
                :term go run %
        endif
endfunc

" -------- -------- -------- -------- -------- --------
"  vim-plug
" -------- -------- -------- -------- -------- --------
call plug#begin('~/.config/nvim/plugged')

" Move
Plug 'easymotion/vim-easymotion'

" Undo Tree
Plug 'mbbill/undotree'

" Bookmarks
Plug 'MattesGroeger/vim-bookmarks'

" Editor Enhancement
" Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/switch.vim'  " press gs to switch ture/false

" Commenter
Plug 'scrooloose/nerdcommenter'

" Auto Complete
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" remember  :CocCommand python.setInterpreter
Plug 'godlygeek/tabular'  " :Tabular/: or :Tabular/=

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" LaTeX
Plug 'lervag/vimtex'

" Formatter
Plug 'Chiel92/vim-autoformat'

" Visual Multi
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Skin
Plug 'crusoexia/vim-monokai'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'jdkanani/vim-material-theme'
Plug 'lycuid/vim-far'
" File navigation
if has('nvim')
        Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
        Plug 'Shougo/defx.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/defx-icons'

" Table
Plug 'dhruvasagar/vim-table-mode'

" Rainbow
Plug 'luochen1990/rainbow'

" IndentLine
Plug 'Yggdroot/indentLine'

" Vim-airline
Plug 'vim-airline/vim-airline'

" Asyncrun
Plug 'skywind3000/asyncrun.vim'
call plug#end()

" -------- -------- -------- -------- -------- --------
"  Defx
" -------- -------- -------- -------- -------- --------
source ~/.vim/defx.vim
noremap <silent> tt :Defx<CR>


"-------- -------- -------- -------- -------- --------
" UndoTree
"-------- -------- -------- -------- -------- --------
noremap <silent> X :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1


"-------- -------- -------- -------- -------- --------
" AsyncRun
"-------- -------- -------- -------- -------- --------
" let g:asyncrun_exit=':copen | wincmd p'
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])


"-------- -------- -------- -------- -------- --------
" LaTeX
"-------- -------- -------- -------- -------- --------
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_open_on_warning = 0


"-------- -------- -------- -------- -------- --------
" AutoFormater
"-------- -------- -------- -------- -------- --------
nnoremap ff :Autoformat<CR>


" -------- -------- -------- -------- -------- --------
"  Rainbow
" -------- -------- -------- -------- -------- --------
let g:rainbow_active = 1


"-------- -------- -------- -------- -------- --------
" IndentLine
"-------- -------- -------- -------- -------- --------
let g:indentLine_color_term = 239
let g:indentLine_char = '┊'
let g:indentLine_concealcursor = ''


" -------- -------- -------- -------- -------- --------
"  AirLine
" -------- -------- -------- -------- -------- --------
let g:airline_powerline_fonts = 0


" -------- -------- -------- -------- -------- --------
"  Commenter
" -------- -------- -------- -------- -------- --------
" 注释的时候自动加个空格
let g:NERDSpaceDelims=1

" -------- -------- -------- -------- -------- --------
"  EasyMotion
" -------- -------- -------- -------- -------- --------
nmap s <Plug>(easymotion-s2)


" -------- -------- -------- -------- -------- --------
"  BookMarks
" -------- -------- -------- -------- -------- --------
let g:bookmark_sign = '¶'
let g:bookmark_annotation_sign = '§'
let g:bookmark_auto_close = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_center = 1
highlight link BookmarkLine SpellBad
highlight link BookmarkAnnotationLine SpellBad


" -------- -------- -------- -------- -------- --------
"  Visual Multi
" -------- -------- -------- -------- -------- --------
let g:VM_maps = {}
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'
let g:VM_maps["Select Cursor Down"] = '<C-j>'
let g:VM_maps["Select Cursor Up"]   = '<C-k>'

" -------- -------- -------- -------- -------- --------
"  Skin
" -------- -------- -------- -------- -------- --------
" colorscheme far

" -------- -------- -------- -------- -------- --------
"  Cursor settings
" -------- -------- -------- -------- -------- --------
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
