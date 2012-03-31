command! Gpp call s:Gpp()
command! GppAndExecute call s:GppAndExecute()
nmap <F8> :GppAndExecute<CR>
imap <F8> <ESC><ESC>:GppAndExecute<CR>

function! s:GppDeleteWindow(windowpath)
  let ewinnr = bufwinnr(a:windowpath)
  if ewinnr != -1     "when the window already exists
    "move to the window
    :exe ewinnr."wincmd w"
    :q!     "delete it
  endif
endfunction

function! s:Gpp()
    :update    "save changes if any
    
    let path = expand('%:r').".cpp"
    let outpath = expand('%:r').".exe"
    
    "if *.cpp file is not up to date, recompile it
    if filereadable(outpath) == 0 || (system("ls -t ".path." ".outpath." | head -1") !~ outpath)
      let ret = system("g++ ".path." -o ".outpath)     "do compile
      
      ":echo ret
      let ret2 = split(ret, "\n")
      let errorpath =  $HOME."/.vimbackup/error.txt"
      :call writefile(ret2, errorpath)
      :call s:GppDeleteWindow(errorpath)

      if v:shell_error
        :call s:GppDeleteWindow(expand('%:r').".txt")
        "create new wndow and show error
        "assumes $HOME/.vimbackup/ exists
        :bo 5new $HOME/.vimbackup/error.txt
        "move to next window (should be the program code one)
        :wincmd w
      endif
    endif
endfunction

function! s:GppAndExecute()
  :call s:Gpp()
  if v:shell_error
  else
    " detect input file from source file name.
    " if you want to use other input files, use vim-quickrun instead.
    let inputpath = expand('%:r').".txt"
    
    let ewinnr = bufwinnr(inputpath)
    let inputExists = getftime(inputpath) != -1
    if ewinnr == -1     "when input window doesnt exist
      :bo 5new ./%<.txt
      if inputExists  "then user may want not to change focus
        :wincmd w
      endif
    endif
    if inputExists
      :!./%<.exe < ./%<.txt
    endif
  endif
endfunction

