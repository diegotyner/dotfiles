-- Refactoring keymaps to here

vim.keymap.set({ "n", "v", "o" }, "H", "^")
vim.keymap.set({ "n", "v", "o" }, "L", "$")
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")

vim.keymap.set({ "n", "x" }, "s", "<Nop>")
--
-- Moving line up/down with alt+dir
vim.keymap.set("n", "<a-k>", ":m .-2<cr>==")
vim.keymap.set("n", "<a-j>", ":m .+1<cr>==")
vim.keymap.set("v", "<a-j>", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<a-k>", ":m '<-2<cr>gv=gv")

local opts = { noremap = true, silent = true }

-- set of commands to indent with tab
vim.keymap.set("n", "<Tab>", ">>", opts)
vim.keymap.set("n", "<S-Tab>", "<<", opts)
vim.keymap.set("v", "<Tab>", ">gv", opts)
vim.keymap.set("v", "<S-Tab>", "<gv", opts)

-- Set of commands to copy vscode alt+shift+up/down copy line
vim.keymap.set("n", "<A-S-Down>", "yyp", opts)
vim.keymap.set("n", "<A-S-Up>", "yyP", opts)
vim.keymap.set("n", "<A-S-j>", "yyp", opts)
vim.keymap.set("n", "<A-S-k>", "yyP", opts)
vim.keymap.set("v", "<A-S-Down>", "y'>p`[V", opts)
vim.keymap.set("v", "<A-S-Up>", "y`<Pgv", opts)
vim.keymap.set("v", "<A-S-j>", "y'>p`[V", opts)
vim.keymap.set("v", "<A-S-k>", "y`<Pgv", opts)

vim.keymap.set("n", "<M-h>", function()
	if vim.fn.col(".") > 1 then
		vim.cmd("normal! xhP")
	end
end, { desc = "Move char left with boundary checking" })
vim.keymap.set("n", "<M-l>", function()
	if vim.fn.col(".") < vim.fn.col("$") - 1 then
		vim.cmd("normal! xp")
	end
end, { desc = "Move char right with boundary checking" })

vim.keymap.set("n", "<leader>e", ":Explore<CR>", { noremap = true, silent = true, desc = "Open Explorer" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
