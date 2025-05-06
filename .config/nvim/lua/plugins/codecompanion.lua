return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "gpt",
				},
				inline = {
					adapter = "claude",
                    keymaps = {
                        accept_change = {
                          modes = { n = "ga" },
                          description = "Accept the suggested change",
                        },
                        reject_change = {
                          modes = { n = "gr" },
                          description = "Reject the suggested change",
                        },
                    }
				},
			},
			adapters = require("plugins.local_only.custom_codecompanion_adapters"),
		})
		vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "CodeCompanion Chat" })
		vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionActions<CR>", { desc = "CodeCompanion Actions" })
		vim.keymap.set(
			"v",
			"<leader>a",
			"<cmd>CodeCompanionChat Add<cr>",
			{ noremap = true, silent = true, desc = "Add snippet to CodeCompanion" }
		)
		vim.cmd([[cab cc CodeCompanion]])
	end,
}
