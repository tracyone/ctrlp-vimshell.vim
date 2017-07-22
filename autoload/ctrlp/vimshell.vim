if ( exists('g:loaded_ctrlp_vimshell') && g:loaded_ctrlp_vimshell ) || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_vimshell = 1

call add(g:ctrlp_ext_vars, {
  \ 'init': 'ctrlp#vimshell#init()',
  \ 'accept': 'ctrlp#vimshell#accept',
  \ 'lname': 'vimshell-history',
  \ 'sname': 'vimshell',
  \ 'type': 'line',
  \ 'sort': 0,
  \ 'specinput': 0,
  \ })

let s:text = ''
function! ctrlp#vimshell#init() abort
  return s:text
endfunction

function! ctrlp#vimshell#accept(mode, str) abort
  call ctrlp#exit()
  if !empty(s:cur_line)
    let l:result=matchstr(a:str,s:default_input.'\zs.*\ze')
  else
    let l:result=a:str
  endif
  if a:mode ==# 'h'
    call feedkeys('i'.l:result)
  else
    call feedkeys('i'.l:result."\<CR>")
  endif
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#vimshell#id() abort
  return s:id
endfunction

function! ctrlp#vimshell#start(...) abort
  if get(g:, 'vimshell_temporary_directory') !=# ''
    if filereadable(g:vimshell_temporary_directory.'/command-history')
      let s:text=readfile(g:vimshell_temporary_directory.'/command-history')
    else
      return
    endif
  else
    return
  endif
  let s:cur_line=getline(line('.'))
  let s:cur_line=matchstr(s:cur_line,g:vimshell_prompt.'\zs.*\ze')
  if empty(s:cur_line)
    let g:ctrlp_default_input=s:text[len(s:text)-1]
  else
    let g:ctrlp_default_input=s:cur_line
  endif
  let s:default_input=g:ctrlp_default_input
  call ctrlp#init(ctrlp#vimshell#id()) 
  call feedkeys("\<C-h>")
  let g:ctrlp_default_input=''
endfunction

" vim:nofen:fdl=0:ts=2:sw=2:sts=2
