" This plugin uses pandoc to automatically convert markdown files on write

" CSS file to use for html output
" Does not need to exist.
" Will be interpreted by expand()
let s:csspath='$HOME/.mdnote.css'

augroup mdnote
	autocmd BufEnter <buffer> ++once setfiletype markdown
	autocmd BufWritePost <buffer> call mdnote#convert()
augroup END


fun mdnote#convert()
    let command=
    \ [
    \ 'pandoc',
    \ '--katex',
    \ '--toc',
    \ '--standalone',
    \ '--css',
    \ expand(s:csspath),
    \ '--metadata',
	\ 'title='..expand('%:r'),
    \ '--highlight-style=breezeDark',
	\ expand('%:p'),
	\ '-o',
	\ expand('%:p')..'.html'
    \ ]
	call jobstart(command,{})
endfun

" LaTeX shortcuts
runtime tex.vim
call tex#Shortcuts()
