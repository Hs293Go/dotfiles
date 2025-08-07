return {

	"neovim/nvim-lspconfig", -- LSP configuration
	dependencies = {
		{
			"mrcjkb/rustaceanvim", -- Rust LSP and DAP support
			version = "^6",
			lazy = false,
		},
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cfg = require("lspconfig.configs")
		local on_attach = function(client, bufnr)
			local function make_opts(desc)
				return { noremap = true, silent = true, buffer = bufnr, desc = desc }
			end

			local function filter_actions(key)
				return function(action)
					for _, k in ipairs(key) do
						if action.title:lower():match(k) then
							return true
						end
					end
				end
			end

			-- Other LSP keymaps can be added here
			vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, make_opts("Go to definition"))
			vim.keymap.set("n", "<M-S-F12>", vim.lsp.buf.type_definition, make_opts("Go to type definition"))
			vim.keymap.set("n", "<C-S-F12>", vim.lsp.buf.implementation, make_opts("Go to implementation"))
			vim.keymap.set("n", "<S-F12>", vim.lsp.buf.references, make_opts("Find references"))
			vim.keymap.set("n", "K", vim.lsp.buf.hover, make_opts("Show hover information"))
			vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, make_opts("Rename variable"))
			vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, make_opts("Show code actions"))
			vim.keymap.set("v", "<C-.>", vim.lsp.buf.code_action, make_opts("Show code actions on selection"))

			-- Statusline integration
			vim.opt.statusline:append("%{luaeval('vim.lsp.status()')}")

			-- Keybindings for switchSourceHeader
			vim.keymap.set(
				"n",
				"<A-o>",
				"<cmd>ClangdSwitchSourceHeader<cr>",
				{ buffer = bufnr, desc = "Switch source/header" }
			)
			vim.keymap.set("n", "<leader>V", function()
				vim.cmd("ClangdSwitchSourceHeader")
				vim.cmd("vsplit") -- Open in a vertical split
			end, { buffer = bufnr, desc = "Switch source/header (vsplit)" })
			if client.server_capabilities.inlayHintProvider then
				vim.g.inlay_hints_visible = true
				vim.lsp.inlay_hint.enable(true)
			end
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.offsetEncoding = { "utf-16" }
		lspconfig.clangd.setup({
			cmd = {
				"clangd", --
				"--background-index", -- Enable background indexing
				"--clang-tidy", -- Enable clang-tidy
				"--header-insertion=never", -- Disable header insertion
				"--fallback-style=google", -- Fallback style for formatting
			},
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig.ruff.setup({
			on_attach = on_attach, -- Your custom on_attach, if any
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

		lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })

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
	end,
}
