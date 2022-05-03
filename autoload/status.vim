scriptencoding utf-8

""""""""""""""""""""""""""
"  STATUSLINE FUNCTIONS  "
""""""""""""""""""""""""""

let s:save_cpo = &cpoptions
set cpoptions&vim

function! s:capWidth(str, width)
    return winwidth(0) > a:width ? a:str : ''
endfunction

" mode
function! status#mode()
    let l:fname = expand('%:t')
    return l:fname =~# 'NERD_tree' ? 'NERD' :
                \ s:capWidth(lightline#mode(), 70)
endfunction

" percent
function! status#percent()
    return s:capWidth((100 * line('.') / line('$')) . '%', 70)
endfunction

" fileencoding
function! status#fileencoding()
    return s:capWidth(&fileencoding, 70)
endfunction

" filetype
function! status#filetype()
    return s:capWidth(&filetype !=# '' ? &filetype : 'no ft', 70)
endfunction

" readonly
function! status#readonly() abort
    return s:capWidth((&readonly || !&modifiable) ? '⏏' : '', 70)
endfunction

" filename
function! status#filename() abort
    let l:fname = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let l:modified = &modified ? ' +' : ''
    return s:capWidth(l:fname . l:modified, 30)
endfunction

" git branch
function! status#gitbranch() abort
    let l:git = fugitive#head()
    return s:capWidth(empty(l:git) ? '' : '⇅ ' . l:git, 70)
endfunction

" trailing
function! status#trailing() abort
    let l:line = search('\s\+$', 'nw')
    return l:line ? winwidth(0) < 100 ? 'Ξ' : 'Ξ' . l:line : ''
endfunction

" mixed indent
function! status#mixedindent() abort
    let l:tabs = search('^\t', 'nw')
    let l:spaces = search('^ ', 'nw')
    if l:tabs && l:spaces
        return winwidth(0) < 100 ? '⇄' : l:tabs . '⇄' . l:spaces
    elseif l:spaces && !&expandtab
        return winwidth(0) < 100 ? '›' : '›' . l:spaces
    elseif l:tabs && &expandtab
        " gofmt handles this
        if index(['go'], &filetype) >= 0
            return ''
        endif
        return winwidth(0) < 100 ? '~' : '~' . l:tabs
    endif
    return ''
endfunction

" long lines
function! status#longline() abort
    if !&textwidth
        return ''
    endif
    let l:line = search('^.\{' . (&textwidth + 1) . ',}' , 'nw')
    return l:line ? winwidth(0) < 100 ? '→' : '→' . l:line : ''
endfunction

" syntax highlight group
function! status#syntaxhlgroup() abort
    return synIDattr(synID(line('.'), col('.'), 1), 'name')
endfunction

" word count
function! status#wordcount() abort
    if index(['asciidoc', 'help', 'mail', 'markdown', 'org', 'rst', 'tex', 'text'], &filetype) < 0
        return ''
    endif
    let l:wc = get(wordcount(), 'visual_words', 0)
    if !l:wc
        let l:wc = get(wordcount(), 'words', 0)
    endif
    return l:wc == 1 ? l:wc . ' word' : l:wc . ' words'
endfunction

" git version
function! status#gitversion() abort
  let l:fname = expand('%')
  let l:gitversion = ''
  if l:fname =~? 'fugitive://.*/\.git//0/.*'
      let l:gitversion = 'git index'
  elseif l:fname =~? 'fugitive://.*/\.git//2/.*'
      let l:gitversion = 'git target'
  elseif l:fname =~? 'fugitive://.*/\.git//3/.*'
      let l:gitversion = 'git merge'
  elseif &diff == 1
      let l:gitversion = 'working copy'
  endif
  return l:gitversion
endfunction

let &cpoptions = s:save_cpo
