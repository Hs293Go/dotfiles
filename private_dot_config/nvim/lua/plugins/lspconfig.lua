return {

	"neovim/nvim-lspconfig", -- LSP configuration
	dependencies = {
		{
			"mrcjkb/rustaceanvim", -- Rust LSP and DAP support
			version = "^6",
			lazy = false,
		},
		"folke/which-key.nvim", -- Keybinding helper
	},
	config = function()
		local lspconfig = require("lspconfig")
		local on_attach = function(client, bufnr)
			local function make_opts(desc)
				return { noremap = true, silent = true, buffer = bufnr, desc = desc }
			end

			-- Other LSP keymaps can be added here
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, make_opts("LSP go to definition"))
			local wk = require("which-key")
			wk.add({
				{ "gl", group = "LSP: goto" },
				{
					"glt",
					vim.lsp.buf.type_definition,
					desc = "LSP: Go to type definition",
					buffer = bufnr,
					noremap = true,
				},
				{ "glr", vim.lsp.buf.references, desc = "LSP: Go to references", buffer = bufnr, noremap = true },
				{
					"glD",
					vim.lsp.buf.implementation,
					desc = "LSP: Go to implementation",
					buffer = bufnr,
					noremap = true,
				},
				{
					"glo",
					vim.lsp.buf.document_symbol,
					desc = "LSP: Go to document symbols",
					buffer = bufnr,
					noremap = true,
				},
				{
					"glW",
					vim.lsp.buf.workspace_symbol,
					desc = "LSP: Go to workspace symbols",
					buffer = bufnr,
					noremap = true,
				},
			})

			vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, make_opts("Rename variable"))
			vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, make_opts("Show code actions"))
			vim.keymap.set("v", "<C-.>", vim.lsp.buf.code_action, make_opts("Show code actions on selection"))

			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, make_opts("LSP: Rename variable"))
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, make_opts("LSP: Show code actions"))

			-- Statusline integration
			vim.opt.statusline:append("%{luaeval('vim.lsp.status()')}")

			if client.server_capabilities.inlayHintProvider then
				vim.g.inlay_hints_visible = true
				vim.lsp.inlay_hint.enable(true)
			end

			vim.diagnostic.config({ virtual_text = true, signs = true, underline = true })
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
		capabilities.offsetEncoding = { "utf-16" }
		lspconfig.clangd.setup({
			cmd = {
				"clangd", --
				"--background-index", -- Enable background indexing
				"--clang-tidy", -- Enable clang-tidy
				"--header-insertion=never", -- Disable header insertion
				"--fallback-style=google", -- Fallback style for formatting
			},
			on_attach = function(client, bufnr)
				-- Keybindings for switchSourceHeader
				vim.keymap.set(
					"n",
					"<A-o>",
					"<cmd>ClangdSwitchSourceHeader<cr>",
					{ buffer = bufnr, desc = "Switch source/header" }
				)

				on_attach(client, bufnr)
			end,
			capabilities = capabilities,
		})

		lspconfig.ruff.setup({
			capabilities = capabilities, -- Your custom capabilities (e.g., for nvim-cmp)
			on_attach = function(client, bufnr_attached)
				on_attach(client, bufnr_attached)
				client.server_capabilities.hoverProvider = false
				_ = client
				-- Ruff automatic import organization.
				LazyVim.format.register({
					name = "ruff.organize_imports",
					priority = 50, -- Smaller than Conform's 100.
					primary = false, -- Conform is primary.
					format = function(bufnr)
						if bufnr == bufnr_attached then
							vim.lsp.buf.code_action({
								context = {
									only = { "source.organizeImports" },
									diagnostics = {},
								},
								apply = true,
							})
						end
					end,
					sources = function(_)
						return { "ruff.organize_imports" } -- Dummy name.
					end,
				})
			end,
		})

		lspconfig.basedpyright.setup({ on_attach = on_attach, capabilities = capabilities })

		lspconfig.texlab.setup({
			settings = {
				texlab = {
					build = {
						executable = "", -- Disable the build command
						args = {},
						forwardSearchAfter = false,
						onSave = false, -- Prevent texlab from triggering builds
					},
					diagnostics = { enabled = true },
					chktex = {
						onOpenAndSave = true, -- Run chktex on open and save
						onEdit = true, -- Run chktex while editing
					},
				},
			},
			on_attach = function(c, b)
				on_attach(c, b)
				vim.lsp.inlay_hint.enable(false) -- Enable inlay hints
			end,
		})
		lspconfig.cmake.setup({})

		vim.g.rustaceanvim = {
			-- Plugin configuration
			tools = {},
			-- LSP configuration
			server = {
				on_attach = on_attach,
				default_settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						cargo = {
							features = "all",
						},
					},
				},
			},
			-- DAP configuration
			dap = {},
		}

		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
}
