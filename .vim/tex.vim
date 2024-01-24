fun tex#Getstr(prompt)
	call inputsave()
	let name=input(a:prompt)
	call inputrestore()
	return name
endfun

fun tex#Env()
	let name=tex#Getstr('Environment: ')
	return '\begin{'.name."}\n\\end{".name."}\<Esc>O"
endfun

fun tex#Shortcuts()
	let mapleader='\'

	" Environments
	inoremap <buffer><expr> <leader>be<Space> tex#Env()
	inoremap <buffer><expr> <leader>lst<Space> '\begin{lstlisting}[language='.tex#Getstr('Language: ')."]\<CR>\\end{lstlisting}\<Esc>O"
	inoremap <buffer><expr> <leader>ite<Space> '\begin{itemize}'."\<CR>\\end{itemize}\<Esc>O"
	inoremap <buffer> <leader>i<Space> \item<Space>

	" Text Formatting
	inoremap <buffer> <leader>bf<Space> \textbf{
	inoremap <buffer> <leader>it<Space> \textit{
	inoremap <buffer> <leader>ul<Space> \underline{
	inoremap <buffer> <leader>ve<Space> \verb|

	" Layout
	inoremap <buffer> <leader><leader> \\
	inoremap <buffer> <leader>== \section{
	inoremap <buffer> <leader>=<Space> \section*{
	inoremap <buffer> <leader>-- \subsection{
	inoremap <buffer> <leader>-<Space> \subsection*{

	" Math
	inoremap <buffer> <leader>x<Space> \times{}
	inoremap <buffer> <leader>* \cdot{}
	inoremap <buffer> <leader>. \rightarrow{}
	inoremap <buffer> <leader>, \leftarrow{}
	inoremap <buffer> <leader>> \implies{}
	inoremap <buffer> <leader>< \impliedby{}
	inoremap <buffer> <leader>fr \frac{
	inoremap <buffer> <leader>bb \mathbb{
	inoremap <buffer> <leader>wh \widehat{
	inoremap <buffer> <leader>~ \approx{}
	inoremap <buffer><expr> <leader>su<Space> '\sum_{'.tex#Getstr('Bottom: ').'}^{'.tex#Getstr('Top: ').'}'
	inoremap <buffer><expr> <leader>mat<Space> '\left[\begin{array}{'.tex#Getstr('Matrix Width: ')."}%\<CR>\\end{array}\\right]\<ESC>O%\<Left>"

	" Greek
	inoremap <buffer> <leader>a<Space> \alpha{}
	inoremap <buffer> <leader>b<Space> \beta{}
	inoremap <buffer> <leader>y<Space> \gamma{}
	inoremap <buffer> <leader>l<Space> \lambda{}
	inoremap <buffer> <leader>0<Space> \theta{}
	inoremap <buffer> <leader>d<Space> \Delta{}
	inoremap <buffer> <leader>e<Space> \epsilon{}

endfun

if &ft=='tex'
	call tex#Shortcuts()
endif
