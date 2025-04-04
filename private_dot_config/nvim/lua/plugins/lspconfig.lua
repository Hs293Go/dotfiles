return {

	"neovim/nvim-lspconfig", -- LSP configuration
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
			-- The blow command will highlight the current variable and its usages in the buffer.
			if client.server_capabilities.documentHighlightProvider then
				local gid = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
				vim.api.nvim_create_autocmd("CursorHold", {
					group = gid,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.document_highlight()
					end,
				})
			end
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
			},
			init_options = { fallbackFlags = { "-std=c++17" } },
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig.pylsp.setup({
			settings = {
				pylsp = {
					configurationSources = { "pylint" },
					plugins = {
						-- Mypy Type Checking
						pylsp_mypy = {
							enabled = true,
							live_mode = true, -- Real-time checking
							dmypy = true, -- Use daemon mode for speed
						},
						-- Linting and Formatting
						flake8 = {
							enabled = true,
							maxLineLength = 88,
							extendIgnore = { "E203", "W503", "D102", "D107" },
						},
						black = { enabled = true },
						isort = { enabled = true },
						pylint = { enabled = true },
						autopep8 = { enabled = false },
						yapf = { enabled = false },
						pyflakes = { enabled = false },
						mccabe = { enabled = false },
						pycodestyle = { enabled = false },
					},
				},
			},
			on_attach = on_attach,
		})

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
			on_attach = on_attach,
		})
		lspconfig.cmake.setup({})
	end,
}
