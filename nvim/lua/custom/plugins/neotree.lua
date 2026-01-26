return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function()
		require("neo-tree").setup({
			filesystem = {
				hijack_netrw_behavior = "disabled", -- Stops Neo-tree from taking over 'nvim .'
			},
			window = {
				mappings = {
					["<space>"] = "none",
				},
			},
		})
		local map = vim.keymap.set
		map("n", "<leader>ts", ":Neotree toggle left<CR>", { desc = "Toggle Sidebar" })
		map("n", "<leader>tf", ":Neotree toggle current<CR>", { desc = "Toggle Full Screen" })
	end,
}
