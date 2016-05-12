" nocompatible with vi
set nocompatible
" 光标锁定在中间
set scrolloff=999
" no display line number
set number
set nobackup
set noswapfile
set clipboard=unnamed
" 增量搜索
set incsearch
" ignorecase when search
set ignorecase
set smartcase
set mouse=
set backspace=indent,eol,start
" highlight search
set hlsearch
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
set laststatus=2
set fileencodings=utf8,gbk
"language messages zh_CN.utf-8
syntax on

" -- vundle --
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'

Bundle 'msanders/cocoa.vim'

" 快速注释 <leader>cc <leader>cu <leader>c<space>
Bundle 'scrooloose/nerdcommenter'

Bundle 'bling/vim-airline'
let g:airline_theme="dark"
let g:airline_section_z="%3p%% %{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#:%3c%V%"
let g:airline#extensions#whitespace#mixed_indent_algo = 1

Bundle 'tpope/vim-commentary'
" directory tree
Bundle 'scrooloose/nerdtree'
" ctrl+p, search file
Bundle 'kien/ctrlp.vim'
map <C-K> :CtrlPTag<CR>

"Bundle 'vim-scripts/taglist.vim'
Bundle 'Lokaltog/vim-easymotion'

" 显示marks - 方便自己进行标记和跳转
" m[a-zA-Z] add mark
" '[a-zA-Z] go to mark
" m<Space>  del all marks
Bundle 'kshenoy/vim-signature'
let g:SignatureEnabledAtStartup = 0
map <leader>m :SignatureToggleSigns<CR>

Bundle 'terryma/vim-multiple-cursors'

Bundle 'bronson/vim-trailing-whitespace'
map <leader><space> :FixWhitespace<cr>

if v:version > 700 || v:version == 700 && has('patch167')
       "Bundle 'majutsushi/tagbar'
       "let g:tagbar_ctags_bin = '~/.vim/ctags'
       "map <leader>t :Tagbar<CR>
endif

" syntax check
Bundle 'scrooloose/syntastic'
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
Bundle 'davidhalter/jedi-vim'
let g:jedi#completions_command = "<C-/>"

" 使用 tab 键补全
Bundle 'ervandew/supertab'

filetype plugin on
filetype plugin indent on

function! UpdateCtagsCscope()
	! ctags -R; cscope -ubR
	cs r
endfunction

" -- key map --
" reload ~/.vimrc
map<leader>r :source ~/.vimrc <CR>
map<leader>u :call UpdateCtagsCscope() <CR><CR><CR>
map <leader>c :make <CR><CR><CR>
nmap <leader>c <ESC> :make <CR><CR><CR>

" -- gui depend --
if has("gui_running")
	colorschem desert
	set guioptions-=T
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin
else
	colorschem desert
	highlight TabLine ctermbg=4
endif

" -- autocmd --
" different indent of language
if has("autocmd")
"	autocmd BufNewFile,BufRead *.h,*.c setfiletype c
"	autocmd BufEnter *.h setfiletype c
	autocmd FileType python
	\ setlocal tabstop=8 shiftwidth=4 softtabstop=4 expandtab

	autocmd FileType java,cpp
	\ setlocal tabstop=8 shiftwidth=4 softtabstop=4 cindent expandtab

	autocmd FileType ruby
	\ setlocal tabstop=8 shiftwidth=4 softtabstop=4 expandtab
endif

" -- switch tab --
map L :tabnext <CR>
nmap L :tabnext <CR>
map H :tabprevious <CR>
nmap H :tabprevious <CR>

" -- tabline --
function! MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	return a:n-1 . ') ' . fnamemodify(bufname(buflist[winnr - 1]), ":t")
endfunction

function! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		" 选择高亮
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif

		" 设置标签页号
		let s .= '%' . (i + 1) . 'T'

		" MyTabLabel() 提供标签
		let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
	endfor

	" 最后一个标签页之后用 TabLineFill 填充并复位标签页号
	let s .= '%#TabLineFill#%T'

	" 右对齐用于关闭当前标签页的标签
	if tabpagenr('$') > 1
		"let s .= '%=%#TabLine#%999Xclose'
	endif

	return s
endfunction
set tabline=%!MyTabLine()

" -- save session --
autocmd VimEnter *
	\ if argc() == 0 && filereadable("Session.vim") |
	\ source Session.vim |
	\ endif
autocmd VimLeave *
	\ if argc() == 0 && filereadable("Session.vim") |
	\ mksession! |
	\ endif

" -- taglist --
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
"let Tlist_Show_One_File = 1

