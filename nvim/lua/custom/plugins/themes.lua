return { -- You can easily change to a different colorscheme.
	-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
	"folke/tokyonight.nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("tokyonight").setup({
			styles = {
				comments = { italic = false }, -- Disable italics in comments
			},
		})
		vim.cmd.colorscheme("tokyonight-moon")
	end,
}
-- My Themes
-- {
--   'projekt0n/github-nvim-theme',
--   name = 'github-theme',
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     require('github-theme').setup {
--       -- ...
--     }
--
--     vim.cmd 'colorscheme github_dark_tritanopia'
--   end,
-- },
-- Unused Themes
-- {
--   "L-Colombo/atlantic-dark.nvim",
--   name = 'atlantic-dark-theme',
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
-- },
-- {
--   'rose-pine/neovim',
--   name = 'rose-pine',
--   config = function()
--     vim.cmd 'colorscheme rose-pine'
--   end,
-- },
-- {
--   'sainnhe/everforest',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     -- Optionally configure and load the colorscheme
--     -- directly inside the plugin declaration.
--     vim.g.everforest_enable_italic = true
--     vim.cmd.colorscheme 'everforest'
--   end,
-- },
-- {
--   "tiagovla/tokyodark.nvim",
--   opts = {
--     -- custom options here
--   },
--   config = function(_, opts)
--     require("tokyodark").setup(opts) -- calling setup is optional
--     vim.cmd [[colorscheme tokyodark]]
--   end,
-- },

-- My Themes Over
