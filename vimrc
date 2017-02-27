set nocompatible	" nocompatible with vi
set scrolloff=999	" 光标锁定在中间
set number		" display line number
set nobackup		" 不创建备份
set noswapfile		" 不创建 swp 文件
set clipboard=unnamed	" 使用系统剪贴板，vim 编译选项要加+clipboard
set incsearch		" 增量搜索
set ignorecase		" 搜索时忽略大小写
set smartcase		" 搜索模式包含大写字符时，不使用 ignorecase 选项
set mouse=		" 所有模式下都可使用鼠标
set hlsearch		" highlight search
set splitright		"  分割新窗口到右边
set backspace=indent,eol,start " 允许自动缩进上退格，换行符上退格，插入开始位置上退格

" language and encoding setting
set encoding=utf-8
if has("win32")
    language US
    language messages US
else
    language en_US.UTF-8
    language messages en_US.UTF-8
endif
set t_Co=256
set laststatus=2 " 总是显示状态栏
set fileencodings=utf8,gbk
syntax on

" -- vundle, 插件管理 --
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" vim  插件包管理工具
" let Vundle manage Vundle, required
Plugin 'Vundle/Vundle.vim'

" objc 支持
Plugin 'msanders/cocoa.vim'

" 快速注释 <leader>cc <leader>cu <leader>c<space>
Plugin 'scrooloose/nerdcommenter'
" 注释的时候自动加个空格, 强迫症必配
let g:NERDSpaceDelims=1
" 整行注释，而不是只注释选中的
let NERDCommentWholeLinesInVMode=1

" 底部状态栏
Plugin 'bling/vim-airline'
" let g:airline_powerline_fonts = 1 " enable powerline-fonts
let g:airline_theme="dark"
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#tabline#enabled = 1 " enable tabline
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#buffer_nr_show = 1

" directory tree
Plugin 'scrooloose/nerdtree'

" ctrl+p, search file
Plugin 'kien/ctrlp.vim'
map <C-K> :CtrlPBuffer<CR>

" 文件内跳转，<leader><leader>w/b/e 词跳转, j/k 行跳转, f/F/t/T 搜索
Plugin 'Lokaltog/vim-easymotion'

" 显示marks - 方便自己进行标记和跳转
" m[a-zA-Z] add mark
" '[a-zA-Z] go to mark
" m<Space>  del all marks
Plugin 'kshenoy/vim-signature'
let g:SignatureEnabledAtStartup = 0
map <leader>m :SignatureToggleSigns<CR>

" <C-N> 多重选择/替换
Plugin 'terryma/vim-multiple-cursors'

" 删除行末空格
Plugin 'bronson/vim-trailing-whitespace'
map <leader><space> :FixWhitespace<cr>

" taglist
Plugin 'majutsushi/tagbar'
map <leader>t :Tagbar<CR>
" 启动时自动focus
let g:tagbar_autofocus = 1

" syntax check
Plugin 'scrooloose/syntastic'
map <leader>s :SyntasticToggleMode<CR>
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['c', 'java'] }
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting=0
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_c_check_header = 1
let g:syntastic_c_no_inclued_search = 1
let g:syntastic_c_no_default_include_dirs = 1
let g:syntastic_c_auto_refresh_includes = 1
let g:syntastic_c_compiler_options = '-Wall'
highlight SyntasticErrorSign guifg=white guibg=black

" python 自动补全
Plugin 'davidhalter/jedi-vim'
let g:jedi#completions_command = "<C-/>"

" 使用 tab 键补全
Plugin 'ervandew/supertab'

" 中文文档
Plugin 'vimcn/vimcdoc'

" 生成 doxygen 注释
" :DoxAuthor 	将文件名，作者，时间等
" :DoxLic 	license注释
" :Dox 		函数及类注释
Plugin 'DoxygenToolkit.vim'

" solarized 主题
Plugin 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256

" 搜索dash
Plugin 'rizzatti/dash.vim'
nmap <silent> <leader>d <Plug>DashSearch

call vundle#end()

filetype plugin on
filetype plugin indent on

" -- key map --

" reload ~/.vimrc
map<leader>r :source ~/.vimrc <CR>
map<leader>u :call UpdateCtagsCscope() <CR><CR><CR>
map <leader>c :make <CR><CR><CR>
nmap <leader>c <ESC> :make <CR><CR><CR>
map <leader>p :set invpaste <CR>
" Make Y yank everything from the cursor to the end of the line. This makes Y
" act more like C or D because by default, Y yanks the current line (i.e. the
" same as yy).
noremap Y y$
" Stay in visual mode when indenting. You will never have to run gv after
" performing an indentation.
vnoremap < <gv
vnoremap > >gv

" -- gui depend --
if has("gui_running")
    set guioptions-=T
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin

    set guifont=Source\ Code\ Pro\ ExtraLight:h14
    set background=dark
    colorscheme desert
    let g:airline_powerline_fonts = 1 " enable powerline-fonts
else
    colorschem desert
    highlight TabLine ctermbg=4
endif

" -- autocmd --
" different indent of language
set tabstop=8 		" 文件里的 <Tab> 代表的空格数
set shiftwidth=4 	" (自动) 缩进每一步使用的空白数目
"set expandtab  		" <Tab> 展开为空格
set softtabstop=4 	" 输入<Tab> 时, 插入的空格数
set autoindent 		" 开启新行时，从当前行复制缩进
if has("autocmd")
    autocmd FileType python,ruby,css
                \ setlocal tabstop=8 shiftwidth=4 softtabstop=4 expandtab

    autocmd FileType java,javascript
                \ setlocal tabstop=8 shiftwidth=4 softtabstop=4 cindent expandtab
    autocmd FileType cpp,c
                \ setlocal tabstop=8 shiftwidth=8 softtabstop=8 cindent noexpandtab
endif

" -- switch tab --
map L :tabnext <CR>
nmap L :tabnext <CR>
map H :tabprevious <CR>
nmap H :tabprevious <CR>

" -- save session --
autocmd VimEnter *
            \ if argc() == 0 && filereadable("Session.vim") |
            \ source Session.vim |
            \ endif
autocmd VimLeave *
            \ if argc() == 0 && filereadable("Session.vim") |
            \ mksession! |
            \ endif

" -- functions --
function! UpdateCtagsCscope()
    !gtags
    " ! ctags -R; cscope -ubR
    cs r
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
  set csto=1
  set cst
  set nocsverb
  set cscopetag " 使用 cscope 作为 tags 命令
  set cscopeprg='gtags-cscope'
  " add any database in current directory
  if filereadable("GTAGS")
      cs add GTAGS
  endif
  set csverb
endif

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" buffer setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" buffer快速导航
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
" 查看buffers
nnoremap <Leader>l :ls<CR>
" 通过索引快速跳转
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

