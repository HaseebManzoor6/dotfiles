highlight clear

if exists("syntax_on")
  syntax reset
endif

let colors_name="cool"

highlight TrailingWhitespace ctermfg=1 cterm=reverse

highlight User1        ctermfg=6
highlight User2        ctermfg=6
highlight User3        ctermfg=7

highlight DiffAdd      ctermfg=0    ctermbg=2
highlight DiffChange   ctermfg=0    ctermbg=3
highlight DiffDelete   ctermfg=0    ctermbg=1
highlight DiffText     ctermfg=0    ctermbg=11   cterm=bold

highlight Visual       ctermfg=NONE ctermbg=NONE cterm=inverse

highlight Search       ctermfg=4    ctermbg=NONE cterm=reverse
highlight IncSearch    ctermfg=1    ctermbg=NONE cterm=reverse

highlight LineNr       ctermfg=8
highlight CursorLineNr ctermfg=7
highlight Comment      ctermfg=8    cterm=italic
highlight ColorColumn  ctermfg=7    ctermbg=8
highlight Folded       ctermfg=7    ctermbg=8
highlight FoldColumn   ctermfg=7    ctermbg=8

highlight StatusLine   ctermfg=15   cterm=bold
highlight StatusLineNC ctermfg=8    cterm=italic
highlight VertSplit    ctermfg=15   cterm=NONE
highlight SignColumn                ctermbg=8

highlight SpecialKey     ctermfg=4
highlight TermCursor     cterm=reverse
highlight NonText        ctermfg=12
highlight Directory      ctermfg=4
highlight ErrorMsg       ctermfg=1 ctermbg=NONE cterm=reverse
highlight MoreMsg        ctermfg=2
highlight ModeMsg        cterm=bold
highlight Question       ctermfg=2
highlight Title          ctermfg=5
highlight WarningMsg     ctermfg=1
highlight Conceal        ctermfg=14 ctermbg=NONE

highlight SpellBad       ctermbg=9
highlight SpellRare      ctermbg=13
highlight SpellLocal     ctermbg=14
highlight SpellCap     ctermfg=7    ctermbg=8

highlight Pmenu        ctermfg=8   ctermbg=NONE cterm=reverse
highlight PmenuSel     ctermfg=15  ctermbg=NONE cterm=reverse
highlight PmenuSbar    ctermbg=8
highlight PmenuThumb   ctermbg=0
highlight WildMenu     ctermfg=10 ctermbg=NONE cterm=reverse,bold

highlight TabLine        ctermfg=7 ctermbg=0 cterm=NONE
highlight TabLineSel     cterm=bold,underline ctermfg=10
highlight TabLineFill    cterm=NONE

highlight CursorColumn   ctermbg=7
highlight CursorLine     cterm=underline
highlight MatchParen     ctermfg=6 ctermbg=0 cterm=underline
highlight Constant       ctermfg=1
highlight Special        ctermfg=5
highlight Identifier     cterm=NONE ctermfg=6
highlight Statement      ctermfg=3
highlight PreProc        ctermfg=5
highlight Type           ctermfg=2
highlight Underlined     cterm=underline ctermfg=5
highlight Ignore         ctermfg=15
highlight Error          ctermfg=15 ctermbg=9
highlight Todo           ctermfg=1 ctermbg=NONE cterm=reverse
