vim.cmd("let g:netrw_liststyle = 3")
local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- indentation
opt.autoindent = true

-- search options
opt.ignorecase = true
opt.smartcase = true

-- colors
opt.termguicolors = false
opt.background = "dark"
-- opt.signcolumn = "yes"

-- clipboard
opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

-- turn off swapfile
opt.swapfile = false
