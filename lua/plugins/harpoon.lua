return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({})

		-- -- Use Telescope as a UI
		-- local conf = require('telescope.config').values
		-- local function toggle_telescope(harpoon_files)
		--   local file_paths = {}
		--   for _, item in ipairs(harpoon_files.items) do
		--     table.insert(file_paths, item.value)
		--   end
		--
		--   require('telescope.pickers')
		--     .new({}, {
		--       prompt_title = 'Harpoon',
		--       finder = require('telescope.finders').new_table {
		--         results = file_paths,
		--       },
		--       previewer = conf.file_previewer {},
		--       sorter = conf.generic_sorter {},
		--     })
		--     :find()
		-- end
		--
		-- vim.keymap.set('n', '<leader>M', function()
		--   toggle_telescope(harpoon:list())
		-- end, { desc = 'Open harpoon window' })

		-- Default UI
		vim.keymap.set("n", "<leader>hl", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "󱢺 Harp list" })

		vim.keymap.set("n", "<leader>hh", function()
			harpoon:list():add()
		end, { desc = "󱢺 Add" })

		vim.keymap.set("n", "<leader>hq", function() -- qwer == 1234
			harpoon:list():select(1)
		end, { desc = "󱢺  1" })

		vim.keymap.set("n", "<leader>hw", function()
			harpoon:list():select(2)
		end, { desc = "󱢺  2" })

		vim.keymap.set("n", "<leader>he", function()
			harpoon:list():select(3)
		end, { desc = "󱢺  3" })

		vim.keymap.set("n", "<leader>hr", function()
			harpoon:list():select(4)
		end, { desc = "󱢺  4" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():prev()
		end, { desc = "󱢺  Next" })

		vim.keymap.set("n", "<leader>hn", function()
			harpoon:list():next()
		end, { desc = "󱢺  Prev" })
	end,
}
