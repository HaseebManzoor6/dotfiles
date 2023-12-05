" -- Statusline Function --

" set always visible
if has('nvim')
	set laststatus=3
else
	set laststatus=2
endif
" compatibility
let s:hasSearchDisplay = exists('*searchcount')
if !s:hasSearchDisplay
    set shortmess-=S
endif

" Seperators
let s:sep1=''
let s:sep2=''

" Change the seperator characters
" You might want to do this in another file, (in your .gitignore if you
"  have your vimrc in a repo) as unicode characters are not
"  available on all terminals
"  i.e. in local.vim: call SLseps("\ue0b6","\ue0b4")
function SLseps(l,r)
	let s:sep1=a:l
	let s:sep2=a:r
endfun

" StatusLine display for search pattern
function SearchDisplay()
    if !s:hasSearchDisplay || @/==""
        return ""
    endif
    let sc = searchcount()
    return "/".@/." (".sc["current"]."/".sc["total"].") "
endfunction

" Helper for GetSLColors()
" If group has a setting for param, return '[mode][param]=[that setting]'
" i.e. FetchColor('Statement','fg','cterm') = ctermfg=#<some color>
function FetchColor(group, param, mode)
    let color=synIDattr(synIDtrans(hlID(a:group)),a:param,a:mode)
    return (color=='')? 'NONE':color
endfunction

function s:Highlight(group,mode,fg,bg,other)
	exec 'hi '.a:group.' '.a:mode.'fg='.a:fg.' '.a:mode.'bg='.a:bg.' '.a:mode.'='.a:other
endfunction

function GetSLColors()
    " Try to grab from colorscheme
	" ortherwise, default to picking some existing color choices

	" cterm or gui?
	let mode=(&termguicolors==1 || has("gui_running")? 'gui':'cterm')

	if !hlexists('User1')
		hi User1 ctermfg=1
	endif
	if !hlexists('User2')
		hi User2 ctermfg=2
	endif
    if !hlexists('User3')
		hi User3 ctermfg=3
    endif

	let U1Fg=FetchColor('User1','fg',mode)
	let U1Bg=FetchColor('User1','bg',mode)
	let U2Fg=FetchColor('User2','fg',mode)
	let U2Bg=FetchColor('User2','bg',mode)
	let U3Fg=FetchColor('User3','fg',mode)
	let U3Bg=FetchColor('User3','bg',mode)

	" Sep colors
	" User1 -> User2
	call s:Highlight('User4',mode,U1Fg,U2Fg,'NONE')
	" User2 -> User3
	call s:Highlight('User5',mode,U2Fg,U3Bg,'NONE')
	" User1 -> User3
	call s:Highlight('User6',mode,U1Fg,U3Bg,'NONE')
endfunction

function SetSL()
    if &buftype ==# 'terminal'
        call SetSLTerminal()
    else
        call SetSLFile()
    endif
endfunction

function SetSLInactive()
    if &buftype ==# 'terminal'
        call SetSLTerminalInactive()
    else
        call SetSLFileInactive()
    endif
endfunction

function SetSLFile()
    " Statusline
    " color
    setlocal statusline=%1*
    " filename
    setlocal statusline+=\ %t\ 
    " modified status
    setlocal statusline+=%m

	if &ft!=""
		" sep
		setlocal statusline+=%4*
		exec 'setlocal statusline+='.s:sep2
		" color
		setlocal statusline+=%2*
		" filetype
		setlocal statusline+=\ %Y\ 
		" sep
		setlocal statusline+=%5*
		exec 'setlocal statusline+='.s:sep2
	else
		" sep
		setlocal statusline+=%6*
		exec 'setlocal statusline+='.s:sep2
	endif

    " color
    setlocal statusline+=%3*
    " left align..
    setlocal statusline+=\ \%=
    " search query
    setlocal statusline+=%{SearchDisplay()}
    " [row%,col]
    setlocal statusline+=\[\%p\%%\,\%c\]\ 
    " line count
    setlocal statusline+=%L\ Lines\ 
endfunction


function SetSLFileInactive()
    " Statusline
    " color
    setlocal statusline=%#StatusLineNC#\ 
    " filename
    setlocal statusline+=%t\ 
    " modified status
    setlocal statusline+=%m
    " filetype
    setlocal statusline+=\ %Y\ 
    " left align..
    setlocal statusline+=\ \%=
    " [row%,col]
    setlocal statusline+=\[\%p\%%\,\%c\]\ 
    " line count
    setlocal statusline+=%L\ Lines\ 
endfunction

function SetSLTerminal()
    " color
    setlocal statusline=%#User1#
    " filename
    setlocal statusline+=\ %t\ 
    " left align...
    setlocal statusline+=%=
    " search query
    setlocal statusline+=%{SearchDisplay()}
endfunction

function SetSLTerminalInactive()
    " color
    setlocal statusline=%#StatusLineNC#\ 
    " filename
    setlocal statusline+=%t\ 
endfunction

fun Hacky(timer)
	call GetSLColors()
endfun

augroup statusline_setup
    "autocmd ColorScheme * let timer=timer_start(0,'Hacky')
    autocmd ColorScheme * call GetSLColors()
    if has('nvim')
        autocmd BufEnter,TermOpen,WinEnter * call SetSL()
    else
        autocmd BufEnter,TerminalOpen,WinEnter * call SetSL()
    endif
    autocmd WinLeave * call SetSLInactive()
augroup END
