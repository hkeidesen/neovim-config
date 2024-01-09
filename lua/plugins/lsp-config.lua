return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local server_config = {
						capabilities = capabilities,
					}
					if server_name == "volar" then
						server_config.filetypes = { "vue", "typescript", "javascript" }
					elseif server_name == "eslint" then
						server_config.settings = {
							-- ESLint server settings here
						}
					end
					require("lspconfig")[server_name].setup(server_config)
				end,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
