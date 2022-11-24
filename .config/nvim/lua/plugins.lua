local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	-- Packer itself!
	use("wbthomason/packer.nvim")

	-- Theme: Tokyo Night ('night' variant)
	use({
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup {
				style = "night",
			}
			vim.cmd [[colorscheme tokyonight]]
		end
	})

	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup {
				theme = "tokyonight",
				icons_enabled = false,
				sections = {
					lualine_x = {
						"encoding",
						{
							"fileformat",
							symbols = {
								unix = 'lf',
								dos = 'crlf',
								mac = 'cr',
							},
						},
						"filetype",
					},
				},
			}
		end
	})

	-- Comment with 'gc' etc
	use("tomtom/tcomment_vim")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
