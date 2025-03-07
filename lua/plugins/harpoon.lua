return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	-- Follow this to make deletion work
	-- https://github.com/folke/snacks.nvim/discussions/1058
	config = function()
		local harpoon = require("harpoon")

		local function generate_harpoon_picker()
			local file_paths = {}
			for _, item in ipairs(harpoon:list().items) do
				table.insert(file_paths, {
					text = item.value,
					file = item.value,
				})
			end
			return file_paths
		end

		harpoon:setup({})

		local sPicker = require("snacks.picker")
		sPicker.harpoon = function()
			Snacks.picker.pick({

				finder = generate_harpoon_picker,
				format = SnacksFormatter,
				title = "Harpoon",
				confirm = function(picker, item)
					picker:close()
					-- Custom action to jump using harpoon
					harpoon:list():select(item.idx)
				end,
				preview = "file", -- Show file preview
				-- layout = "vertical",
				layout = SnacksPickerLayout,
				win = {
					input = {
						keys = {
							["dd"] = { "harpoon_delete", mode = { "n", "x" } },
						},
					},
					list = {
						keys = {
							["dd"] = { "harpoon_delete", mode = { "n", "x" } },
						},
					},
				},
				actions = {
					-- harpoon_delete = {
					-- 	fn = function(picker, item)
					-- 		-- Custom action to delete using harpoon
					-- 		harpoon:list():delete(item.idx)
					-- 		picker:refresh()
					-- 	end,
					-- 	desc = "Delete Harpooned Item",
					-- },
					harpoon_delete = function(picker, item)
						local to_remove = item or picker:selected()
						table.remove(harpoon:list().items, to_remove.idx)
						picker:find({
							refresh = true, -- refresh picker after removing values
						})
					end,
				},
			})
		end

		--
		-- -- Use Snacks.picker as a UI
		-- local function toggle_picker(harpoon_files)
		-- 	local file_paths = {}
		-- 	for _, item in ipairs(harpoon_files.items) do
		-- 		table.insert(file_paths, {
		-- 			text = item.value,
		-- 			file = item.value,
		-- 		})
		-- 	end
		--
		-- 	-- Register the custom source
		-- 	Snacks.picker.sources.harpoon_source = {
		-- 		finder = function()
		-- 			return file_paths
		-- 		end,
		-- 		format = "text",
		-- 	}
		--
		-- 	-- Define custom actions
		-- 	local actions = {
		-- 		harpoon_delete = {
		-- 			fn = function(picker, item)
		-- 				-- Your logic to delete the harpooned item
		-- 				print("Deleting item:", item.text)
		-- 			end,
		-- 			desc = "Delete Harpooned Item",
		-- 		},
		-- 	}
		--
		-- 	Snacks.picker.pick("harpoon_source", {
		-- 		title = "Harpooni",
		-- 		prompt = ">",
		-- 		show_empty = true,
		-- 		--actions = actions,
		-- 		win = {
		-- 			list = {
		-- 				keys = {
		-- 					["dd"] = "harpoon_delete", -- Bind 'dd' to delete action
		-- 				},
		-- 			},
		-- 		},
		-- 	})
		-- end

		vim.keymap.set("n", "<leader>hl", function()
			Snacks.picker.harpoon()
		end, { desc = "Open harpoon window" })

		-- Default UI
		vim.keymap.set("n", "<leader>he", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "󱢺 Harp Edit" })

		vim.keymap.set("n", "<leader>hh", function()
			harpoon:list():add()
		end, { desc = "󱢺 Add" })

		vim.keymap.set("n", "<leader>h1", function() -- qwer == 1234
			harpoon:list():select(1)
		end, { desc = "󱢺  1" })

		vim.keymap.set("n", "<leader>h2", function()
			harpoon:list():select(2)
		end, { desc = "󱢺  2" })

		vim.keymap.set("n", "<leader>h3", function()
			harpoon:list():select(3)
		end, { desc = "󱢺  3" })

		vim.keymap.set("n", "<leader>h4", function()
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
