command! Gpp call s:Gpp()
command! GppAndExecute call s:GppAndExecute()
nmap <F8> :GppAndExecute<CR>
imap <F8> <ESC><ESC>:GppAndExecute<CR>

function! s:Gpp()
    :update    "save changes if any
    
    let path = expand('%:t')
    let outpath = expand('%:r').".exe"
    
    "if *.cpp file is not up to date, recompile it
    if filereadable(outpath) == 0 || (system("ls -t ".path." ".outpath." | head -1") !~ outpath)
      let ret = system("g++ ".path." -o ".outpath)     "do compile
      
      ":echo ret
      if v:shell_error
        let ret2 = split(ret, "\n")
        let errorpath =  $HOME."/.vimbackup/error.txt"
        :call writefile(ret2, errorpath)
        let ewinnr = bufwinnr(errorpath)
        if ewinnr != -1     "when error window already exists
          "move to the window
          :exe ewinnr."wincmd w"
          :q!     "delete it
        endif
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
    ":!g++ % -o %<.exe
    "let ret = system("./".outpath)
    ":echo ret
    :!./%<.exe
  endif

endfunction

