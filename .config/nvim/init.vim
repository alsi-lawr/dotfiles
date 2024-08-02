for f in split(glob('/usr/share/config/.config/nvim/config/*.vim'), '\n')
    exe 'source' f
endfor

