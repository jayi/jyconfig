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
map <C-K> :CtrlPTag<CR>

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
       		\ 'passive_filetypes': ['c'] }
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
Bundle 'DoxygenToolkit.vim'

" solarized 主题
Bundle 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256

call vundle#end()

filetype plugin on
filetype plugin indent on

" -- key map --
" reload ~/.vimrc
map<leader>r :source ~/.vimrc <CR>
map<leader>u :call UpdateCtagsCscope() <CR><CR><CR>
map <leader>c :make <CR><CR><CR>
nmap <leader>c <ESC> :make <CR><CR><CR>

" -- gui depend --
if has("gui_running")
	set guioptions-=T
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin

	set guifont=Source\ Code\ Pro\ ExtraLight:h14
	colorscheme solarized
else
	colorschem desert
	highlight TabLine ctermbg=4
endif

" -- autocmd --
" different indent of language
if has("autocmd")
	autocmd FileType python,ruby
	\ setlocal tabstop=8 shiftwidth=4 softtabstop=4 expandtab

	autocmd FileType java,cpp,javascript,c
	\ setlocal tabstop=8 shiftwidth=4 softtabstop=4 cindent expandtab
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
	! ctags -R; cscope -ubR
	cs r
endfunction
