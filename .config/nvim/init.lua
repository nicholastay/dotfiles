require("plugins")

-- Row lines
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true -- Highlight line
vim.opt.numberwidth = 4 -- More spacing on left

vim.opt.mouse = "a"

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

-- Display options
vim.opt.termguicolors = true
vim.opt.scrolloff = 3 -- Keep 3 lines when scrolling

-- Disable line stuff as we have our own bar
vim.opt.showmode = false
vim.opt.modeline = false

-- Store undo between starts
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- ----------------

-- Bindings

vim.keymap.set("n", "Space", "<nop>")
vim.g.mapleader = " "

-- Clipboard
vim.keymap.set("v", "<leader>y", '"+y', { silent = true })
vim.keymap.set("n", "<leader>p", '"+p', { silent = true })
vim.keymap.set("v", "<leader>p", '"+p', { silent = true })

-- ; as : for commands
vim.keymap.set("n", ";", ":", { noremap = true })

-- Replace all
vim.keymap.set("n", "S", ":%s//g<Left><Left>", { noremap = true })
