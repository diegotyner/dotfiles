-- Refactoring init.lua, putting kickstart opts here

vim.g.have_nerd_font = true
vim.g.netrw_browsex_viewer = ""
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true
vim.opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line

vim.opt.showmatch = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 400 -- Decrease mapped sequence wait time
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true -- Sets how neovim will display certain whitespace characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 15
-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`), confirm
vim.opt.confirm = true

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

if vim.fn.has("termguicolors") == 1 then
	vim.opt.termguicolors = true
end

-- OSC52 clipboard: lets yank/paste work over SSH without a system clipboard,
-- by sending the terminal an escape sequence your local terminal intercepts.
-- Requires Neovim 0.10+ and a terminal that supports OSC52 (most modern ones do).
vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
	},
}
