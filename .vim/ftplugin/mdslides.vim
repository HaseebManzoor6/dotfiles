" This plugin uses pandoc to automatically convert markdown files on write

augroup mdslides
	autocmd BufEnter <buffer> ++once setfiletype markdown
	autocmd BufWritePost <buffer> call mdslides#convert()
augroup END


fun mdslides#convert()
    let command=
    \ [
    \ 'pandoc',
    \ '--standalone',
	\ '-t',
	\ 'beamer',
	\ expand('%:p'),
	\ '-o',
	\ expand('%:p')..'.pdf'
    \ ]
	call jobstart(command,{})
endfun

" LaTeX shortcuts
runtime tex.vim
call tex#Shortcuts()
