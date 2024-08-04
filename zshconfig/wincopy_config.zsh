function wincopy() {
    bat --paging=never "$1" | winclip
}

