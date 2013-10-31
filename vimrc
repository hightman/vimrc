"--------------------
" Use Vundle to manage bundles
"--------------------
set nocompatible	" be iMproved
filetype off		" required!
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
source ~/.vim/vimrc.vundle 

"--------------------
" General Settings
"--------------------
set bs=indent,eol,start	" allow backspacing over everything in insert mode
set history=100		" keep 100 lines of command line history
set ruler			" show the cursor position all the time
set ar				" auto read when file is changed from outside
set nu				" show line numbers

filetype on			" Enable filetype detection
filetype indent on	" Enable filetype-specific indenting
filetype plugin on	" Enable filetype-specific plugins

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

syntax on			" syntax highlight
set hlsearch		" search highlighting

" terminal color settings
if has("gui_running")	" GUI color and font settings
	set guifont=Courier:h18
	set background=dark 
	set t_Co=256		" 256 color mode
	set cursorline	" highlight current line
	highlight CursorLine  guibg=#003853 ctermbg=24  gui=none cterm=none
	colors moria
else
	colors evening
endif

set clipboard=unnamed	" yank to the system register (*) by default
set showmatch		" Cursor shows matching ) and }
set showmode		" Show current mode
set wildchar=<TAB>	" start wild expansion in the command line using <TAB>
set wildmenu		" wild char completion menu

" ignore these files while expanding wild chars
set wildignore+=.svn,CVS,.git 
set wildignore+=*.o,*.a,*.class,*.mo,*.la,*.so,*.lo,*.la,*.obj,*.pyc
set wildignore+=*.exe,*.zip,*.jpg,*.png,*.gif,*.jpeg 

set autoindent		" auto indentation
set incsearch		" incremental search
set backup			" save backup files
set backupdir=~/.vim/bak	" where to put backup file
set dir=~/.vim/tmp	" tell vim where to put swap files
set copyindent		" copy the previous indentation on autoindenting
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set nosmarttab		" insert tabs on the start of a line according to context

" disable sound on errors
set noerrorbells visualbell t_vb=
set tm=500

" TAB setting
set noexpandtab		"DO-NOT replace <TAB> with spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd FileType yaml set expandtab

" FOLDING
set foldenable
set foldmethod=marker
set foldlevel=0
set foldcolumn=0

" status line
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \ 
set statusline+=\ \ \ [%{&ff}/%Y] 
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\ 
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

fun! CurDir()
	let curdir = substitute(getcwd(), $HOME, "~", "")
	return curdir
endfun

fun! HasPaste()
	if &paste
		return '[PASTE]'
	else
		return ''
	endif
endfun

" C/C++ specific settings
autocmd FileType c,cpp,cc  set cindent		" comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"--------------------------------------------------------------------------- 
" Tip #382: Search for <cword> and replace with input() in all open buffers 
"--------------------------------------------------------------------------- 
fun! Replace() 
  let s:word = input("Replace " . expand('<cword>') . " with:") 
  :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge' 
  :unlet! s:word 
endfun 


"--------------------------------------------------------------------------- 
" USEFUL SHORTCUTS
"--------------------------------------------------------------------------- 
" set leader to ;
let mapleader=";"
let g:mapleader=";"

" quick alias to leave vim
nmap <leader>w :x<CR> 
nmap <leader>q :q!<CR>

"replace the current word in all opened buffers
map <leader>r :call Replace()<CR>

" open the error console
map <leader>er :bo cope<CR> 
" move to next error
map <leader>] :cn<CR>
" move to the prev error
map <leader>[ :cp<CR>

" --- move around splits
" move to and maximize the below split 
map <C-J> <C-W>j<C-W>_
" move to and maximize the above split 
map <C-K> <C-W>k<C-W>_
" move to and maximize the left split 
nmap <c-h> <c-w>h<c-w><bar>
" move to and maximize the right split  
nmap <c-l> <c-w>l<c-w><bar>
set wmw=0			" set the min width of a window to 0 so we can maximize others 
set wmh=0			" set the min height of a window to 0 so we can maximize others

" --- move to splitted windok
map <leader>h :wincmd h<CR> 
map <leader>j :wincmd j<CR> 
map <leader>k :wincmd k<CR> 
map <leader>l :wincmd l<CR> 

" Quickly resize windows use +/-
map - <C-W>-
map + <C-W>+
map > <C-W>>
map < <C-W><

" Allows all window commands in insert mode
imap <C-w> <C-o><C-w>

" Loop to switch windows
nmap <S-w> :wincmd w<CR>

" new tab
map <C-t><C-t> :tabnew .<CR>
" close tab
map <C-t><C-w> :tabclose<CR> 

" ;/ turn off search highlighting
nmap <leader>/ :set hls!<CR>
nnoremap <silent><leader>s :nohlsearch<CR>

" Bash like keys for the command line
cnoremap <C-A>  <Home>
cnoremap <C-E>  <End>
cnoremap <C-K>  <C-U>

" ,p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

"--------------------------------------------------------------------------- 
" PROGRAMMING SHORTCUTS
"--------------------------------------------------------------------------- 

" Ctrl-[ jump out of the tag stack (undo Ctrl-])
map <C-[> <ESC>:po<CR>

map <leader>g :call IncludeGuard()<CR>
fun! IncludeGuard()
	let basename = substitute(bufname(""), '.*/', '', '')
	let guard = '_' . substitute(toupper(basename), '\.', '_', "H") . '_'
	call append(0, "#ifndef " . guard)
	call append(1, "#define " . guard)
	call append(line("$"), "#endif /* " . guard . " */")
endfun

"---------------------------------------------
" Enable omni completion. (Ctrl-X Ctrl-O)
"---------------------------------------------
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
	autocmd Filetype *
				\ if &omnifunc == "" |
				\   setlocal omnifunc=syntaxcomplete#Complete |
				\ endif
endif
set cot-=preview	"disable doc preview in omnicomplete

"---------------------------------------------
" for PHP programming
"---------------------------------------------
autocmd FileType php set makeprg=php\ -l\ %
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l

"---------------------------------------------
" for edit CSS
"---------------------------------------------
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
" make CSS omnicompletion work for SASS and SCSS
autocmd BufNewFile,BufRead *.scss			set ft=scss.css
autocmd BufNewFile,BufRead *.sass			set ft=sass.css

"---------------------------------------------
" for edit HTML
"---------------------------------------------
autocmd FileType html,xhtml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

"---------------------------------------------
" file type detection
"---------------------------------------------
" highlight action script and mxml syntax
au BufNewFile,BufRead *.mxml set filetype=mxml
au BufNewFile,BufRead *.as set filetype=actionscript
au BufNewFile,BufRead *.less set filetype=less

"---------------------------------------------
" use w!! to write protected files
"---------------------------------------------
cmap w!! %!sudo tee > /dev/null % 

"---------------------------------------------
" copy to system buffer
"---------------------------------------------
vnoremap <C-S-C> "+y<CR>
map <C-S-c>  "+y<CR>
map <C-S-v> "+p<CR>

"--------------------------------------------------------------------------- 
" ENCODING SETTINGS
"--------------------------------------------------------------------------- 
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,big5,latin1

"--------------------------------------------------------------------------- 
" COLOR SCHEME OVERRIDE
"--------------------------------------------------------------------------- 
hi StatusLine ctermfg=gray ctermbg=black
hi StatusLineNC ctermfg=darkblue ctermbg=gray

"--------------------------------------------------------------------------- 
" PLUGIN SETTINGS
"--------------------------------------------------------------------------- 
" --- AutoClose - Inserts matching bracket, paren, brace or quote 
" fixed the arrow key problems caused by AutoClose
if !has("gui_running")	
	set term=linux
	syntax on
	map OA k
	map OB j
	map OC l
	map OD h

	imap OA <ESC>ki
	imap OB <ESC>ji
	imap OC <ESC>li
	imap OD <ESC>hi
endif

" --- BufExplorer
let g:bufExplorerDetailedHelp = 0		" Do not show detailed help.
noremap <leader>b :BufExplorer<CR>

" --- TagBar
" toggle TagBar with F7 ;tb
nnoremap <silent><F7> :TagbarToggle<CR> 
nnoremap <leader>t :TagbarToggle<CR>
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1
" set default width of the Tagbar window
let g:tagbar_width = 30
" markdown support
let g:tagbar_type_markdown = {
			\ 'ctagstype': 'markdown',
			\ 'kinds': [ 'h:Heading_L1', 'i:Heading_L2', 'k:Heading_L3' ]
			\ }
" --- NERDTree
nnoremap <silent> <F3> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
" Close vim if the only window left open is the NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" --- Syntastic
nnoremap <silent> <F6> :SyntasticCheck<CR>
nnoremap <leader>sy :SyntasticCheck<CR>
let g:syntastic_auto_loc_list = 1
let g:syntastic_auto_jump = 1

" --- YankRing.vim
let g:yankring_history_dir = '~/.vim/tmp'
nnoremap <silent> <F2> :YRShow<CR>
nnoremap <leader>y :YRShow<CR>

" --- EasyMotion
let g:EasyMotion_leader_key = '<Leader><Leader>'	" default is <Leader>w
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

" --- neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
			\ 'default': '',
			\ 'vimshell': '~/.vimshell_hist',
			\ 'scheme': '~/.gosh_completions'
			\ }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
fun! s:my_cr_func()
	return pumvisible() ? neocomplcache#smart_close_popup() : "\<CR>"
endfun
"inoremap <expr><CR>  neocomplcache#smart_close_popup()."\<CR>"
inoremap <silent> <CR> <C-r>=<SID>my_cr_func()<CR>
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" --- neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif

" --- vim-javascript
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" --- php-search-doc, vim-jquery-doc
let g:php_search_doc_command = 'open'
let g:php_search_doc_function_mapping='<Leader>pf'
let g:php_search_doc_manual_mapping='<Leader>pm'
let g:jquery_doc_command = 'open'
let g:jquery_doc_mapping = '<Leader>jm'

" --- ctrlp.vim
nnoremap <leader>f :CtrlP<CR>
set wildignore+=*/tmp/*
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_root_markers = ['protected','CVS','tags']
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn)$',
			\ 'file': '\v\.(exe|so|dll)$',
			\ 'link': 'some_bad_symbolic_links',
			\ }

" --- vim-easytags
nnoremap <leader>ut :UpdateTags!<CR>
nnoremap <leader>ht :HighlightTags<CR>
nnoremap <silent><leader>hh :let b:easytags_auto_highlight = 1<CR>
nnoremap <silent><leader>nh :let b:easytags_auto_highlight = 0<CR>
let g:easytags_dynamic_files = 1
let g:easytags_resolve_links = 1
" disable split by filetype, it seems is a bug!!
"let g:easytags_by_filetype = '~/.vim/tmp'

"---------------------------------------------
" using ctags
"---------------------------------------------
set tags=tags

"---------------------------------------------
" shorcut for ctags
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
"---------------------------------------------
map <C-\> :bel 8sp <CR>:exec("tag ".expand("<cword>"))<CR>

"--------------------
" For JavaScriptLint
" Ref: http://panweizeng.com/write-javascript-in-vim.html
"--------------------
"autocmd FileType javascript set makeprg=~/bin/jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -conf\ ~/bin/jsl.default.conf\ -process\ %
"autocmd FileType javascript set errorformat=%f(%l):\ %m
"autocmd FileType javascript inoremap <silent> <F9> <C-O>:make<CR>
"autocmd FileType javascript map <silent> <F9> :make<CR>

"--------------------
" for using php-cs-fixer
"--------------------
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

"--------------------
" insert php namespace
"--------------------
imap <buffer> <leader><Leader>u <C-O>:call PhpInsertUse()<CR>
map <buffer> <leader><Leader>u :call PhpInsertUse()<CR>

"--------------------
" For phpDocumentor (pdv)
"--------------------
inoremap <leader>pd <ESC>:call PhpDocSingle()<CR>i 
nnoremap <leader>pd :call PhpDocSingle()<CR> 
vnoremap <leader>pd :call PhpDocRange()<CR> 

"--------------------
" Load path of util
"--------------------
source ~/.vim/vimrc.path

