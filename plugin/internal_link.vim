"This just looks for an header equal to this word
function! s:FolWo()
	"zyiw
	let curWord = expand("<cword>")
	let subcomm="/^##* *".curWord." *$"
	execute subcomm
endfunction
command! -nargs=0 FollowWord :call s:FolWo()
nmap <C-]> :FollowWord<CR>

"This will read all headings and create reserved words for them
function! s:CreateSyntax()
	let curpos=getpos(".")
	let @q=""
	g/^##* *[a-z][a-z]* *$/y Q
	let reslist=@q
	syn clear WikiWord
	syn case ignore
	for line in split(reslist)
		if empty(substitute(line, "^ *", "", ""))
			continue
		endif
		let linedue=substitute(line,"^##* *","", "")
		if empty(substitute(linedue, "^ *", "", ""))
			continue
		endif
		let subcomm=":syn keyword WikiWord ".linedue
		execute subcomm
	endfor
	hi link WikiWord Label
	call setpos(".", curpos)
endfunction
command! -nargs=0 GenerateWikiLink :call s:CreateSyntax()
hi link WikiWord Label
