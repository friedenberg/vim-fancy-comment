
if exists("g:loaded_fancy_comment")
  finish
endif

let g:loaded_fancy_comment = 1

function s:getSingleLineCommentChar()
  for c in split(&comments, ',')
    if c[0] == ':'
      return c[1:-1]
    endif
  endfor
endfunction

function s:fancyCommentStringTransform(i, l)
  let rawLine = s:getSingleLineCommentChar() . ' ' . a:l
  let processed = substitute(rawLine, '\s\+$', '', 'g')
  return processed
endfunction

function! FancyComment(t)
  let command = "figlet " . a:t
  let output_raw = systemlist(command)

  let output = map(output_raw, function("s:fancyCommentStringTransform"))

  let currentBuf = bufnr('%')
  let currentLine = line('.')
  call appendbufline(currentBuf, currentLine, output)
endfunction

command! -complete=custom,ListFigletFonts -nargs=1 FancyComment call FancyComment(<f-args>)

function! ListFigletFonts(A,L,P)
  let lastArg = split(a:L)[-1]

  if lastArg == "-f"
    return system("find \"$(figlet -I2)\" -maxdepth 1 -name '*.flf' -print0 | xargs -0 basename -s .flf")
  endif

  return ""
endfun

