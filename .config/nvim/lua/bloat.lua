--
-- The "Bloat" aka lazy.nvim plugins
-- Most which make things look fancier or act more like IDE lol
--

-- ----------------
-- lazy.nvim setup
-- https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Downloads if not exists
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- ----------------
-- Configure plugins, where some of them are optional based on "IDE"-bloat level.

local is_ide_bloat = os.getenv("NT_NVIM_IDE") == "1"

local plugins = {
	
	-- Colour scheme (main): catppuccin mocha
	-- [see if I can port emacs kaolin-aurora some time though, because I do love that one :)]
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
			})
			vim.cmd.colorscheme "catppuccin"
		end,
	},

	-- Detect indentation levels automagically
	"tpope/vim-sleuth",

	-- Comment with 'gcc'
	{ "numToStr/Comment.nvim", lazy = false, opts = {} },

	-- Classic tpope/surround style. I would use surround in mini, but it's too different...
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	-- Collection of neat stuff
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			-- Status line
			require("mini.statusline").setup({ set_vim_settings = false, })

			-- Pairs
			require("mini.pairs").setup()

			-- Tabline
			require("mini.tabline").setup({ })

			-- Move line/block around in visual mode with alt-hjkl
			require("mini.move").setup()

			-- Keep tapping f/t jumps
			require("mini.jump").setup()
			
			-- Starter
			require("mini.starter").setup()
		end,
	},

	-- Treesitter highlights
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "bash", "c", "html", "lua", "vim", "markdown", "vimdoc", "javascript", "python" },
			})
		end,
	},

	-- Multicursors
	-- (sorry vim purists, but when it's helpful it's really helpful lol)
	-- [also sorry nvim lua enjoyers, i didn't like multicursors.nvim...]
	"mg979/vim-visual-multi",


	-- ----------------
	-- Below will be the "IDE bloat level"

	-- What am I doing?
	{
		"folke/which-key.nvim",
		enabled = is_ide_bloat,
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},

	-- LSP "fun"
	{
		"neovim/nvim-lspconfig",
		enabled = is_ide_bloat,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
			})

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(event)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Goto Definition", })
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Code Action", })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "Hover (LSP)", })
				end,
			})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		enabled = is_ide_bloat,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					 -- Scroll docs window
					 ['<C-b>'] = cmp.mapping.scroll_docs(-4),
					 ['<C-f>'] = cmp.mapping.scroll_docs(4)
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer", max_item_count = 5 },
					{ name = "path", max_item_count = 3 },
					{ name = "luasnip", max_item_count = 3 },
				}
			})
		end,
	},


}

-- ----------------
-- Load with lazy.nvim!

require("lazy").setup(plugins, {
	ui = {
		-- Replace lazy.nvim icons with non-nerd-font emojis
		-- (Stolen from kickstart.nvim)
		-- icons = {
		-- 	cmd = '⌘',
		-- 	config = '🛠',
		-- 	event = '📅',
		-- 	ft = '📂',
		-- 	init = '⚙',
		-- 	keys = '🗝',
		-- 	plugin = '🔌',
		-- 	runtime = '💻',
		-- 	require = '🌙',
		-- 	source = '📄',
		-- 	start = '🚀',
		-- 	task = '📌',
		-- 	lazy = '💤 ',
		-- },
	},
})
