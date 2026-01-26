return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				-- mode = "tabs",
				separator_style = "slope",
				indicator = {
					icon = "▎", -- this should be omitted if indicator style is not 'icon'
					style = "icon",
				},
				close_command = "bd %d",
				offsets = { { filetype = "NvimTree", text = "", separator = true } },
				diagnostics = "nvim_lsp",
				-- persist_buffer_sort = false,
				show_duplicate_prefix = false,

				numbers = function(opts_loc)
					local marks = require("harpoon"):list().items
					local bufname = vim.fn.bufname(opts_loc.id)

					for i, mark in ipairs(marks) do
						if bufname == mark.value then
							return tostring(i)
						end
					end
				end,

				sort_by = function(a, b)
					local aname = vim.fn.bufname(a.id)
					local bname = vim.fn.bufname(b.id)
					-- harpoon_log("Comparing:", aname, "vs", bname)
					local ha = 100
					local hb = 100
					for i, mark in ipairs(require("harpoon"):list().items) do
						if mark.value == aname then
							ha = i
						end
						if mark.value == bname then
							hb = i
						end
					end
					-- harpoon_log(("→ result: %d < %d = %s"):format(ha, hb, ha < hb))
					return ha < hb
				end,
			},
		})
	end,
}
