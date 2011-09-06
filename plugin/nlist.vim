" Vim global plugin for putting lists of numbers in a file
" Maintainer: Brian Medley <freesoftware@4321.tv>
" Version: 2.0

if exists("loaded_nlist")
    finish
endif
let loaded_nlist = 1

" don't do anything if someone else has already defined either a function or a
" command called 'Nlist'
if exists(":Nlist") || exists("*Nlist")
    finish
endif

" Description:
" This provides a command and a function.  They both can be called with or
" without a range.  In addition, they can be called with or without
" arguments.  Without a range they operate on the current line.  The arguments
" are described below:
"
"     arg1 -> if a number :
"               the number to start at.  The default is one.  This will
"             number your selected lines sequentially.  The start can be a
"             number, ., $, or, 'x (like getline).
"             if a group of letters :
"               the "alphabetic number" to start at. For the following lines,
"             this string will be incremented like this :
"             a b c ... x y z aa ab ac ... az ba ... zy zz aaa ...
"             The first character gives the alpha-numbering's case
"             if "*" :
"               only arg2 is displayed as bullet (the default for arg2 is "* ")
"     arg2 -> Text to append after numbers.  The default is a space.
"     arg3 -> Controls formatting.  Can be "left", "right", or "none".  The
"             default is "right".
"
" Examples:
"     To make a list start at 1:
"         :'<,'>Nlist
"         :'<,'>call Nlist()
"     To number the whole buffer (with it's actual line number):
"         :%Nlist
"         :%call Nlist()
"     To number a subset of lines with their line number (and put a '] ' in
"     front of every number):
"         :'<,'>Nlist . ]\
"         :'<,'>call Nlist(".", "] ")
"     To number the whole buffer (with it's actual line number) without
"     justification:
"         :%Nlist 1 \ left
"         :%call Nlist("1", " ", "none")

" Example mappings that a user can define:
" nnoremap <unique> <Leader>N :%Nlist<cr>
" vnoremap <unique> <Leader>N :Nlist<cr>

command -nargs=* -range Nlist <line1>,<line2>call Nlist(<f-args>)

function Nlist(...) range
    let start = 1
    let append = " "
    let s:formatting = "right"
    if 1 <= a:0
        let start = a:1 
    endif
    if 2 <= a:0
        let append = a:2
    endif
    if 3 <= a:0
        let s:formatting = a:3
    endif

    " if first parameter contains only letters, create a list by incrementing
    " letters like this : a b c ... y z aa ab ac ... az ba ... zy zz aaa ...
    " the second parameter is displayed between the letters and the text
    if 1 == (start =~? "^\\a\\+$")
        let numstart = s:Alph2Num(start)
        if "none" != s:formatting
            let s:max_len = s:Num2Alph(numstart + (a:lastline - a:firstline))
            let s:max_len = strlen(s:max_len)
        endif
        if (char2nr(start) > 96)
            exe a:firstline . "," . a:lastline . 's/^/\=s:JustifyNum(tolower(s:Num2Alph(line(".")-a:firstline+numstart))).append/'
        else
            exe a:firstline . "," . a:lastline . 's/^/\=s:JustifyNum(s:Num2Alph(line(".")-a:firstline+numstart)).append/'
        endif

    " if first parameter is '*', add only the second parameter as bullet
    elseif "*" == start
        if 1 == a:0
            let append = "* "
        endif
        exe a:firstline . "," . a:lastline . 's/^/\=append/'

    " else create an ordinary numbered list 
    else
        " try to work like getline (i.e. allow the user to pass in . $ or 'x)
        if 0 == (start + 0)
            let start = line(start)
        endif
        if "none" != s:formatting
            let s:max_len = start + (a:lastline - a:firstline)
            let s:max_len = strlen(s:max_len)
        endif
        exe a:firstline . "," . a:lastline . 's/^/\=s:JustifyNum(line(".")-a:firstline+start).append/'
    endif
endfunction

let s:twenty_spaces="                    "
function s:JustifyNum(num)
    if "none" == s:formatting
        return a:num
    endif

    let len           = strlen(a:num)
    let needed_spaces = s:max_len - len

    if 0 == needed_spaces
        return a:num
    endif

    let spaces = strpart(s:twenty_spaces, 0, needed_spaces)
    if "left" == s:formatting
        return a:num . spaces
    else
        return spaces . a:num
    endif
endfunction

" The function Num2Alph() returns the base26 representation of a number.
" (in fact it's not really base26 but it looks like...) 
func s:Num2Alph(nbr)
  let n = a:nbr
  let alph = ""
  while n > 0
    let alph = 'ZABCDEFGHIJKLMNOPQRSTUVWXY'[n % 26] . alph
    let n = (n - 1) / 26
  endwhile
  return alph
endfunc

" The function Alph2Num() return the decimal representation of a base26 number
func s:Alph2Num(str)
  let nbr = 0
  let i = 0
  let l:str = toupper(a:str)
  let l = strlen(l:str)
  while i < l
    let nbr = nbr + (char2nr(l:str[i]) - 64) * s:Pow(26, l-i-1)
    let i = i + 1
  endwhile
  return nbr
endfunc

func s:Pow(num, pow)
    let res = 1
    let pow = a:pow
    while pow > 0
        let res = res * a:num
        let pow = pow - 1
    endw
    return res
endfunc
