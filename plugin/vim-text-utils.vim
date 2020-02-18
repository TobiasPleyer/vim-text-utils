" A line block is a number of consecutive lines and will be shown as a generic
" placeholder and the newline character inbetween: A\nB\nC
"
" This function interleaves to blocks with lines with each other, i.e. if we
" have the lines A\nB\nC and the lines X\nY\nZ, then interleaving them will
" yield A\nX\nB\nY\nC\nZ
"
" This function makes the following assumptions:
"       1. The beginning of the first block, i.e. its first line, is marked
"          witht he mark a
"       2. The line above the second block, i.e. above its first line, is
"          marked with b
"
" Executing the function will
"       1. Jump to mark b (the line above the second block)
"       2. Go down one line
"       3. Move this line below mark a, reducing the second block by one
"          line and increasing the first block
"       4. Set the mark a to this freshly moved line (deleting the old mark)
"
" The argument cnt determines how often you want to execute the macro,
" typically as often as there are lines in block 2
function! Interleave(cnt)
    let @m="'bj:m 'ajma"
    execute "normal " . a:cnt . "@m"
endfunction

" The range based version of Interleave to interleave the block marked with a
" with the current selection. This function executes the same steps as
" Interleave, but doesn't assume any mark b is set beforehand. Instead it will
" use the line before the current selection as the mark b and then run the
" macro for every line in the selection.
function! InterleaveR() range
    let @m="'bj:m 'ajma"
    if a:firstline == 1
        normal ggO
    endif
    call cursor(a:firstline-1, 0)
    normal mb
    let cnt = a:lastline - a:firstline + 1
    execute "normal " . cnt . "@m"
endfunction

" This function zips to blocks with lines with each other using the argument
" text to join both lines, i.e. if we have the lines A\nB\nC and the lines
" X\nY\nZ and the argument t, then zipping them will yield AtX\nBtY\nCtZ
"
" This function makes the following assumptions:
"       1. The beginning of the first block, i.e. its first line, is marked
"          witht he mark a
"       2. The line above the second block, i.e. above its first line, is
"          marked with b
"
" Executing the function will
"       1. Jump to mark b (the line above the second block)
"       2. Go down one line
"       3. Move this line below mark a, reducing the second block by one
"          line and increasing the first block
"       4. Append the argument text to the line of the first block
"       5. Join both lines together
"       6. Set the mark a to this freshly moved line (deleting the old mark)
"
" The argument cnt determines how often you want to execute the macro,
" typically as often as there are lines in block 2
function! ZipWith(text, cnt)
    let @t=a:text
    let @m="'bj:m 'ak$\"tpgJjma"
    execute "normal " . a:cnt . "@m"
endfunction

" The range based version of ZipWith to zip the block marked with a with the
" current selection. This function executes the same steps as ZipWith, but
" doesn't assume any mark b is set beforehand. Instead it will use the line
" before the current selection as the mark b and then run the macro for every
" line in the selection.
function! ZipWithR(text) range
    let @t=a:text
    let @m="'bj:m 'ak$\"tpgJjma"
    if a:firstline == 1
        normal ggO
    endif
    call cursor(a:firstline-1, 0)
    normal mb
    let cnt = a:lastline - a:firstline + 1
    execute "normal " . cnt . "@m"
endfunction
