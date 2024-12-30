-- Keymaps for better default experience

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For conciseness
local function opts(desc)
	if desc == nil then
		return { noremap = true, silent = true }
	end

	return { noremap = true, silent = true, desc = desc }
end

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts())

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts())

-- save file without auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts())

-- quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts())

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts())

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts())
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts())

-- Search
--vim.keymap.set("v", "/", "y/<C-v>", opts("Search selected"))

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts("Next search"))
vim.keymap.set("n", "N", "Nzzzv", opts("Prev search"))

-- Resize with arrows
--vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts())
--vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts())
--vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts())
--vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts())

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts("Next Buffer"))
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts("Prev buffer"))
-- vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts())   -- close buffer
--vim.keymap.set("n", "<C-w>", ":bdelete!<CR>", opts("Close buffer")) -- close buffer
vim.keymap.set("n", "<leader>bn", "<cmd> enew <CR>", opts(" [B]uffer [N]we")) -- new buffer

-- Window management
vim.keymap.set("n", "<leader>bs", "<C-w>v", opts("[B]uffer [S]plit Vertically")) -- split window vertically
vim.keymap.set("n", "<leader>bh", "<C-w>s", opts("[B]uffer Split [H]orizontally")) -- split window horizontally
vim.keymap.set("n", "<leader>be", "<C-w>=", opts("[B]uffer Split [E]qually")) -- make split windows equal width & height
vim.keymap.set("n", "<leader>bq", ":close<CR>", opts("[B]uffer Split [Q]uit]")) -- close current split window
vim.keymap.set("n", "<leader>bq", ":close<CR>", opts("[B]uffer Split [Q]uit]")) -- close current split window
vim.keymap.set("n", "<C-w>", ":close<CR>", opts("[B]uffer Split [Q]uit]")) -- close current split window

-- Increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", opts("Increment numbers")) -- increment
vim.keymap.set("n", "<leader>-", "<C-x>", opts("Decrement numbers")) -- decrement

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts())
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts())
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts())
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts())

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts()) -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts()) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts()) --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts()) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts())

-- Press jk fast to exit insert mode
vim.keymap.set("i", "jk", "<ESC>", opts())
vim.keymap.set("i", "kj", "<ESC>", opts())

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts())
vim.keymap.set("v", ">", ">gv", opts())

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts())
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts())

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts())

-- Replace word under cursor
vim.keymap.set("n", "<leader>j", "*``cgn", opts())

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- CodeActions
vim.keymap.set("n", "<leader>co", ":TSToolsSortImports<CR>")

-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set("n", "<leader>do", function()
	diagnostics_active = not diagnostics_active

	if diagnostics_active then
		vim.diagnostic.enable(false)
	else
		vim.diagnostic.disable(false)
	end
end)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Save and load session
vim.keymap.set("n", "<leader>ss", ":mksession! .session.vim<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>sl", ":source .session.vim<CR>", { noremap = true, silent = false })
