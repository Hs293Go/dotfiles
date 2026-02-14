return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"mrcjkb/rustaceanvim",
			version = "^6",
			lazy = false, -- Recommended by plugin
		},
	},
	lazy = false, -- Load immediately to ensure LSP servers are ready when opening files
	config = function()
		-- 1. Define shared capabilities
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
		-- Required for clangd/utf-16 compatibility
		capabilities.offsetEncoding = { "utf-16" }

		-- 2. Define our global LSP behavior (the new 'on_attach')
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)

				if not client then
					return
				end

				if client.supports_method("textDocument/inlayHint") then
					-- Disable for texlab specifically as per your original config
					local should_enable = client.name ~= "texlab"
					vim.lsp.inlay_hint.enable(should_enable, { bufnr = bufnr })
				end

				-- Server-specific logic inside LspAttach
				if client.name == "clangd" then
					vim.keymap.set(
						"n",
						"<A-o>",
						"<cmd>LspClangdSwitchSourceHeader<cr>",
						{ buffer = bufnr, desc = "Switch source/header" }
					)
				end

				if client.name == "ruff" then
					client.server_capabilities.hoverProvider = false
				end
			end,
		})

		-- 3. Configure Servers via vim.lsp.enable
		-- This automatically starts the servers when a matching filetype is opened

		-- Clangd
		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=never",
				"--fallback-style=google",
			},
			capabilities = capabilities,
		})
		vim.lsp.enable("clangd")

		-- Python
		vim.lsp.config("ruff", {
			capabilities = capabilities,
		})
		vim.lsp.enable("ruff")

		vim.lsp.config("ty", { capabilities = capabilities })
		vim.lsp.enable("ty")

		-- LaTeX
		vim.lsp.config("texlab", {
			capabilities = capabilities,
			settings = {
				texlab = {
					build = { executable = "", onSave = false },
					chktex = { onOpenAndSave = true, onEdit = true },
				},
			},
		})
		vim.lsp.enable("texlab")

		-- Lua / TS / CMake
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = { Lua = { diagnostics = { globals = { "vim" } }, telemetry = { enable = false } } },
		})
		vim.lsp.enable("lua_ls")
		vim.lsp.config("ts_ls", { capabilities = capabilities })
		vim.lsp.enable("ts_ls")
		vim.lsp.config("cmake", { capabilities = capabilities })
		vim.lsp.enable("cmake")

		-- 4. Rustaceanvim (remains external as it manages its own lifecycle)
		vim.g.rustaceanvim = {
			server = {
				capabilities = capabilities,
				default_settings = {
					["rust-analyzer"] = { cargo = { features = "all" } },
				},
			},
		}

		-- Diagnostics UI
		vim.diagnostic.config({ virtual_text = true, signs = true, underline = true })
	end,
	keys = {
		{ "<leader>il", "<cmd>LspInfo<cr>", desc = "Show LSP info" },
		{ "<leader>cr", vim.lsp.buf.rename, desc = "LSP: Rename symbol" },
		{ "<leader>ca", vim.lsp.buf.code_action, desc = "LSP: Code actions", mode = { "n", "v" } },
		{ "glt", vim.lsp.buf.type_definition, desc = "Type Definition" },
		{ "glr", vim.lsp.buf.references, desc = "References" },
		{ "glD", vim.lsp.buf.implementation, desc = "Implementation" },
		{ "glo", vim.lsp.buf.document_symbol, desc = "Document Symbols" },
		{ "glW", vim.lsp.buf.workspace_symbol, desc = "Workspace Symbols" },
		{ "gd", vim.lsp.buf.definition, desc = "LSP go to definition" },
	},
}
