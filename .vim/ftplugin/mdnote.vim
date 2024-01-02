" This plugin uses pandoc to automatically convert markdown files on write

" CSS file to use for html output
" Does not need to exist.
" Your shell will interpret the value of s:csspath, so use single quotes.
let s:csspath='$HOME/.mdnote.css'

augroup mdnote
	autocmd BufEnter <buffer> ++once setfiletype markdown
	autocmd BufWritePost <buffer> call mdnote#convert()
augroup END

fun mdnote#convert()
	let options='--mathml --toc --standalone --css '..s:csspath..' --metadata title="'..expand('%:t')..'" --highlight-style=breezeDark'
	exec '!pandoc '..options..' -o '..expand('%:p')..'.html '..expand('%:p')
endfun
