-- Mini plugins:
-- 1) Surround yanking
-- 2) Statusline
return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	config = function()
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup({
			-- mappings = {
			--   -- add = 'sa' -- 'ys', -- Add surrounding in Normal and Visual modes
			--   -- delete = 'sd' -- 'ds', -- Delete surrounding
			--   -- replace = 'sr' -- 'cs', -- Replace surrounding
			--   -- find = 'sf', -- Find surrounding (to the right)
			--   -- find_left = 'sF', -- Find surrounding (to the left)
			--   -- highlight = 'sh', -- Highlight surrounding
			--   -- update_n_lines = 'sn', -- Update `n_lines`
			--   -- suffix_last = 'l', -- Suffix to search with "prev" method
			--   -- suffix_next = 'n', -- Suffix to search with "next" method
			-- },
		})
		vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

		-- Setup for statusline
		local custom_section_fileinfo = function()
			local filetype = vim.bo.filetype
			if filetype == "" then
				return ""
			end

			local icon = ""
			if vim.g.have_nerd_font then
				local has_devicons, devicons = pcall(require, "nvim-web-devicons")
				if has_devicons then
					icon, _ = devicons.get_icon(vim.fn.expand("%:t"), nil, { default = true })
					icon = icon .. " "
				end
			end

			local size = math.max(vim.fn.line2byte(vim.fn.line("$") + 1) - 1, 0)
			local size_str = ""
			if size < 1024 then
				size_str = size .. "B"
			elseif size < 1048576 then
				size_str = string.format("%.2fKiB", size / 1024)
			else
				size_str = string.format("%.2fMiB", size / 1048576)
			end

			return string.format("%s%s %s", icon, filetype, size_str)
		end

		local statusline = require("mini.statusline")
		local my_active_content = function()
			local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
			local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
			local filename = statusline.section_filename({ trunc_width = 140 })
			-- local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
			local fileinfo = custom_section_fileinfo()
			local location = statusline.section_location() -- Uses your override below
			local search = statusline.section_searchcount({ trunc_width = 75 })

			return statusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics, lsp } },
				"%<", -- Mark general truncate point
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=", -- End left alignment
				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
				{ hl = mode_hl, strings = { search, location } },
			})
		end

		statusline.setup({
			use_icons = vim.g.have_nerd_font,
			content = {
				active = my_active_content,
			},
		})

		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end

		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_fileinfo = function(args)
			local filetype = vim.bo.filetype

			-- 1. Add filetype icon if icons are enabled
			-- Note: MiniStatusline handles the icon provider internally if use_icons is true
			if statusline.config.use_icons and filetype ~= "" then
				local icon = require("mini.statusline").get_file_icon(filetype)
				if icon ~= "" then
					filetype = icon .. " " .. filetype
				end
			end

			-- 2. Return early for non-normal buffers or if window is too small
			-- This keeps the statusline clean in sidebars like Neo-tree
			if statusline.is_truncated(args.trunc_width) or vim.bo.buftype ~= "" then
				return filetype
			end

			-- 3. Get the raw size using the built-in helper
			-- Note: Since we are in the same scope, we call the MiniStatusline helper
			local size = statusline.get_filesize()

			-- 4. Return only filetype and size
			return string.format("%s %s", filetype, size)
		end

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
	end,
}
