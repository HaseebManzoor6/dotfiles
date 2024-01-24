" Mouse behavior
set mouse=a
" -- From mswin.vim --
" Use CTRL-S for saving, also in Insert mode (<C-O> doesn't work well when
" using completions).
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<Esc>:update<CR>gi
"if has("clipboard")
"    vnoremap <C-X> "+x
"    vnoremap <C-C> "+y
"    cmap <C-V>		<C-R>+
"endif
" --------------------
" fast scrolling
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>

command W w
command Q q
command WQ wq

" Persist global variables whose names are all caps
set viminfo=!,'100,<50,s10,h,rA:,rB:

" hex editor script
runtime hex.vim
" run command script
runtime runcmd.vim
runtime statusline.vim

" --- Settings ---
" Line numbers
set number
" Split below by default
set splitbelow
" backspace over everything
set backspace=indent,eol,start
" search highlighting
set incsearch
set hlsearch
set wildmenu
set t_Co=16

augroup new_window_autocfg
    " on startup - hack to fix weird resizing in CMD
    " | Problem occurs if you run vim from fullscreened CMD
    "if has('win32') && &term ==# 'win32'
        "autocmd GUIEnter * simalt \<CR>
    "endif
    " No line numbers in (terminal inside vim)
    if has('nvim')
        autocmd TermOpen * setlocal nonumber norelativenumber
    else
        autocmd TerminalOpen * setlocal nonumber norelativenumber
    endif
augroup END

" --- Persist light/dark and colorscheme ---


" --- Visual Settings ---
augroup visual_cfg_after_colorschemes
	" Highlight trailing whitespace
	autocmd ColorScheme * if hlexists('TrailingWhitespace') | call matchadd('TrailingWhitespace','\v\s+$') | endif
augroup END
colo cool

" tab key => 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
" Syntax highlighting
syntax enable
filetype plugin indent on " needed by Rust syntax highlighting
" Default latex type (see :help tex_flavor)
let g:tex_flavor = "latex"







" --- Commands ---
" Theme Commands
command Dark :set bg=dark
command Light :set bg=light

" cd Here Shortcut
command Here :cd %:p:h

" terminal
" -nargs=* => any # of args
" command -nargs=* T :sp res 15 term <args>
" -complete=file_in_path => tab autocompletion type
if has('nvim')
    command -nargs=* -complete=file_in_path T :sp|term <args>
else
    command -nargs=* -complete=file_in_path T :term <args>
endif

" Clear search
command CL :let @/=""

" Quick make/load session
command MS :mks! ~\session.vim
command LS :source ~\session.vim

" Autorun
command P :call Autorun()





" --- Plugins ---

"  -- Vim-Plug --
if exists('plug#begin')
    call plug#begin()
    " -- language support --
    " Rust syntax highlighting
    Plug 'rust-lang/rust.vim'
    call plug#end()
endif

" --- Templates ---
" Templates for new files. Make sure the template files exist!
let templatedir=$HOME."/.vim/templates"
augroup templates
    autocmd BufNewFile *.* call LoadTemplate(templatedir)
augroup END

" modified from https://vim.fandom.com/wiki/Use_eval_to_create_dynamic_templates
function LoadTemplate(template_dir)
    " the template file for the current file's extension type
    let template = a:template_dir."/template\.".expand("%:e")
    if filereadable(template)
        silent execute "0r ".template
        " have vim evaluate anything in [VIM_EVAL] ... [END_EVAL]
        %substitute#\[VIM_EVAL\]\(.\{-\}\)\[END_EVAL\]#\=eval(submatch(1))#ge
        "^ In the entire file...                        ^ replace with: eval(...)
        "           ^  pattern to replace, contained between delimeter #
    endif
endfunction

" local script
runtime local.vim

" ----- FROM DEFAULT VIMRC: diff function -----

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  input('no internal diff')
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
