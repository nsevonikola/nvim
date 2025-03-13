require("core.keymaps")
require("core.options")
require("core.options-neovide")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field

vim.opt.rtp:prepend(lazypath)

--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
require("lazy").setup({
	require("plugins.neo-tree"),
	require("plugins.snacks"),
	require("plugins.colorscheme"),
	require("plugins.lazygit"),
	require("plugins.diffview"),
	require("plugins.noice"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.treesitter-context"),
	--require("plugins.telescope"),
	require("plugins.lsp"),
	require("plugins.autocompletion"),
	require("plugins.none-ls"),
	require("plugins.gitsigns"),
	require("plugins.indent-blankline"),
	require("plugins.hlchunk"),
	require("plugins.typescript-tools"),
	require("plugins.harpoon"),
	--require("plugins.smart-open"),
	--require("plugins.hbac"),
	require("plugins.barbecue"),
	require("plugins.misc"),
	require("plugins.copilot-chat"),
})
