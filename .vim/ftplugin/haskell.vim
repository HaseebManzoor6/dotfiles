if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

"autocmd Syntax haskell syn match HaskellLambda '\\' conceal cchar=λ
"autocmd BufEnter * ++once set conceallevel=2
"autocmd BufEnter * ++once hi link HaskellLambda Operator
syn match HaskellLambda '\\' conceal cchar=λ
set conceallevel=2
hi link HaskellLambda Operator
set expandtab
