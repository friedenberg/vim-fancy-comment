
if exists("g:loaded_fancy_comment")
  finish
endif
let g:loaded_fancy_comment = 1

function! FancyComment(t)
  let escapedComment = substitute(substitute(&commentstring, "%s", "", "g"), "#", '#', "g")
  let command = "r!figlet " . a:t . " \| sed 's/^/" . escapedComment . "/g'"
  execute escape(command, '#')
endfunction

command! -complete=custom,ListFigletFonts -nargs=1 FancyComment call FancyComment(<f-args>)

fun ListFigletFonts(A,L,P)
  let lastArg = split(a:L)[-1]

  if lastArg == "-f"
    return system("find \"$(figlet -I2)\" -maxdepth 1 -name '*.flf' -print0 | xargs -0 basename -s .flf")
  endif

  return ""
endfun

