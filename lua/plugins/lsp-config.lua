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
			ensure_insalled = {"eslint", "volar", "tsserver"}
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
					elseif server_name == "tsserver" then
						server_config.on_attach = function(client)
							--yolo true here, or use null-ls to format idk?
							client.resolved_capabilities.document_formatting = false
						end
					end
					require("lspconfig")[server_name].setup(server_config)
				end,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			-- vertical split
			vim.keymap.set("n", "<leader>gD", function()
				vim.cmd("vsp")
				vim.lsp.buf.definition()
				vim.cmd("wincmd 1")
				end, {}
			)
			-- horizontal split
			vim.keymap.set("n", "<leader>GD", function()
			vim.cmd("sp")
				vim.lsp.buf.definition()
				vim.cmd("wincmd 1")
			end, {})
			vim.keymap.set("n", "<C-q>", ":q<CR>", {silent = true})
			vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
