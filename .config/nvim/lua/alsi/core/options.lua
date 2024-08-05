vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces for tabs (dotnet default)
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line on newline

opt.wrap = false

-- search setting
opt.ignorecase = true
opt.smartcase = true -- mixed case assumes case-sensitivity

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme
-- only works for true color terminals
opt.termguicolors = true
opt.background = "dark" -- either light or dark
opt.signcolumn = "yes" -- shown sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

