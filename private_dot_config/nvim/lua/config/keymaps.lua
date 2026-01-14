vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "::", ";", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "::", ";", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })

vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>[")
vim.keymap.set("n", "[<tab>", ":tabprevious<CR>", { noremap = true, silent = true, desc = "Previous tab" })
vim.keymap.set("n", "]<tab>", ":tabnext<CR>", { noremap = true, silent = true, desc = "Next tab" })

-- Remap floating terminal to <C-`> for vscode compatibility
local Term = require("snacks").terminal
local get_unique_terminal = function()
	Term.get(nil, { env = { NVIM_TERM_UID = vim.fn.sha256(os.time() .. vim.loop.hrtime()) } })
end
local toggle_all = function()
	local termlist = Term.list()
	if #termlist == 0 then
		get_unique_terminal()
		return
	end
	for _, term in pairs(termlist) do
		term:toggle()
	end
end
vim.keymap.set("n", "<C-`>", toggle_all, { desc = "Terminal (cwd)", noremap = true, silent = true })
vim.keymap.set("t", "<C-`>", toggle_all, { desc = "Terminal (cwd)", noremap = true, silent = true })

vim.keymap.set("t", "<C-S-5>", get_unique_terminal, { desc = "Create new terminal", noremap = true, silent = true })

local delete_buffer = function()
	if string.find(vim.bo.buftype, "terminal") == nil then
		require("snacks").bufdelete()
	end
end

-- Remap delete buffer to <C-c>
vim.keymap.set("n", "<C-c>", delete_buffer, { desc = "Delete buffer", noremap = true, silent = true })

vim.keymap.del("n", "<C-/>")
-- Remap gcc to <C-/> for vscode compatibility
-- https://github.com/neovim/neovim/discussions/29075
vim.keymap.set("n", "<C-/>", function()
	vim.cmd.norm("gcc")
end)

vim.keymap.set("v", "<C-/>", "gc", {
	remap = true,
})

-- Exit terminal insert mode safely
for _, k in ipairs({ "h", "j", "k", "l" }) do
	vim.keymap.set("t", "<C-" .. k .. ">", [[<C-\><C-n><C-w>]] .. k, { noremap = true, silent = true })
end

vim.keymap.set("n", "<leader>m", ":messages<CR>", { noremap = true, silent = true, desc = "Show messages" })

vim.keymap.set({ "n", "v" }, "<leader>W", function()
	vim.cmd("wa")
end, { noremap = true, silent = true, desc = "Write all buffers" })

-- write all and quit all
vim.keymap.set({ "n", "v" }, "<leader>Q", function()
	vim.cmd("wa")
	vim.cmd("qa")
end, { noremap = true, silent = true, desc = "Write all buffers and quit Neovim" })

-- Open current folder in file explorer
local function open_current_folder()
	local cwd = vim.fn.getcwd()
	vim.notify("Opening folder: " .. cwd, vim.log.levels.INFO, { title = "Neovim" })
	if vim.fn.has("mac") == 1 then
		vim.fn.jobstart({ "open", cwd }, { detach = true })
	elseif vim.fn.has("win32") == 1 then
		vim.fn.jobstart({ "explorer", cwd }, { detach = true })
	else
		vim.fn.jobstart({ "xdg-open", cwd }, { detach = true })
	end
end

vim.keymap.set("n", "<leader>O", open_current_folder, { noremap = true, silent = true, desc = "Open current folder" })

vim.keymap.del("n", "<leader>e")
vim.keymap.del("n", "<leader>E")
vim.keymap.del("n", "<leader>fe")
