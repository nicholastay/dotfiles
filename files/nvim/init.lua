--
-- [[ Nick's /neovim/ config ]]
--       l a z y  edition
--

-- ----------------
-- The Basics

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

vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = false

-- Display options
vim.opt.termguicolors = true
vim.opt.scrolloff = 3 -- Keep 3 lines when scrolling

-- Store undo between starts
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- Split on our preferred sides
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Use LF line endings
vim.opt.fileformat = "unix"

-- ----------------
-- Bindings

-- Leader is Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clipboard via Leader
vim.keymap.set("v", "<leader>y", '"+y', { silent = true })
vim.keymap.set("n", "<leader>p", '"+p', { silent = true })
vim.keymap.set("v", "<leader>p", '"+p', { silent = true })

-- ; as : for commands
vim.keymap.set("n", ";", ":", { noremap = true })

-- Replace all
vim.keymap.set("n", "S", ":%s//g<Left><Left>", { noremap = true })

-- Save and next buffer when multiple files
vim.keymap.set("n", "<leader>-", ':w|bd<cr>')

-- Move lines in visual or with ctrl(insert+visual)
-- (https://stackoverflow.com/questions/41084565/moving-multiple-lines-in-vim-visual-mode)
vim.keymap.set("n", "<c-j>", ":<C-u>m+<CR>==", { noremap = true })
vim.keymap.set("n", "<c-k>", ":<C-u>m-2<CR>==", { noremap = true })
vim.keymap.set("i", "<c-j>", ":m+<CR>==gi", { noremap = true })
vim.keymap.set("i", "<c-k>", ":m-2<CR>==gi", { noremap = true })
vim.keymap.set("x", "J", ":m'>+<CR>gv=gv", { noremap = true })
vim.keymap.set("x", "K", ":m-2<CR>gv=gv", { noremap = true })

-- ----------------
-- Bloat

-- Load Bloat if not in lite mode (by setting env NT_NVIM_LITE to anything), otherwise apply default tweaks

if os.getenv("NT_NVIM_LITE") == nil then
	-- Load away!
	require("bloat")
else
	-- Default colour scheme
	vim.cmd [[
		colorscheme slate
		hi Normal guibg=NONE ctermbg=NONE
	]]
end
