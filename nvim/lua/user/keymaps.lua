-- Plugins --

-- NvimTree
--keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
--keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
--keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
--keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
-- keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Git
-- keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
-- keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
-- keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- DAP
--keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
-- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
-- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
-- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
-- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
-- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
-- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

local M = {}

local generic_opts_any = { noremap = true, silent = true }
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", generic_opts_any)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local generic_opts = {
	insert_mode = generic_opts_any,
	normal_mode = generic_opts_any,
	visual_mode = generic_opts_any,
	visual_block_mode = generic_opts_any,
	command_mode = generic_opts_any,
	term_mode = { silent = true },
}

local mode_adapters = {
	insert_mode = "i",
	normal_mode = "n",
	term_mode = "t",
	visual_mode = "v",
	visual_block_mode = "x",
	command_mode = "c",
}

---@class Keys
---@field insert_mode table
---@field normal_mode table
---@field terminal_mode table
---@field visual_mode table
---@field visual_block_mode table
---@field command_mode table

local defaults = {
	insert_mode = {
		-- 'jk' for quitting insert mode
		["jk"] = "<ESC>",
		-- 'kj' for quitting insert mode
		["kj"] = "<ESC>",
		-- 'jj' for quitting insert mode
		["jj"] = "<ESC>",
		-- Move current line / block with Alt-j/k ala vscode.
		["<A-j>"] = "<Esc>:m .+1<CR>==gi",
		-- Move current line / block with Alt-j/k ala vscode.
		["<A-k>"] = "<Esc>:m .-2<CR>==gi",
		-- navigation
		["<A-Up>"] = "<C-\\><C-N><C-w>k",
		["<A-Down>"] = "<C-\\><C-N><C-w>j",
		["<A-Left>"] = "<C-\\><C-N><C-w>h",
		["<A-Right>"] = "<C-\\><C-N><C-w>l",
	},

	normal_mode = {
		-- Better window movement
		["zh"] = "<C-w>h",
		["zj"] = "<C-w>j",
		["zk"] = "<C-w>k",
		["zl"] = "<C-w>l",

		-- Resize with arrows
		["<C-Up>"] = ":resize -2<CR>",
		["<C-Down>"] = ":resize +2<CR>",
		["<C-Left>"] = ":vertical resize -2<CR>",
		["<C-Right>"] = ":vertical resize +2<CR>",

		-- Tab switch buffer
		["<S-l>"] = ":BufferLineCycleNext<CR>",
		["<S-h>"] = ":BufferLineCyclePrev<CR>",

		-- Move current line / block with Alt-j/k a la vscode.
		["<A-j>"] = ":m .+1<CR>==",
		["<A-k>"] = ":m .-2<CR>==",

		-- QuickFix
		["]q"] = ":cnext<CR>",
		["[q"] = ":cprev<CR>",
		["<C-q>"] = ":call QuickFixToggle()<CR>",
		["S"] = ":w<CR>",
		["Q"] = ":wq<CR>",
	},

	term_mode = {
		-- Terminal window navigation
		["<C-h>"] = "<C-\\><C-N><C-w>h",
		["<C-j>"] = "<C-\\><C-N><C-w>j",
		["<C-k>"] = "<C-\\><C-N><C-w>k",
		["<C-l>"] = "<C-\\><C-N><C-w>l",
	},

	visual_mode = {
		-- Better indenting
		["<"] = "<gv",
		[">"] = ">gv",

		-- ["p"] = '"0p',
		-- ["P"] = '"0P',
	},

	visual_block_mode = {
		-- Move selected line / block of text in visual mode
		["K"] = ":move '<-2<CR>gv-gv",
		["J"] = ":move '>+1<CR>gv-gv",

		-- Move current line / block with Alt-j/k ala vscode.
		["<A-j>"] = ":m '>+1<CR>gv-gv",
		["<A-k>"] = ":m '<-2<CR>gv-gv",
	},
}
-- Unsets all keybindings defined in keymaps
-- @param keymaps The table of key mappings containing a list per mode (normal_mode, insert_mode, ..)
function M.clear(keymaps)
	local default = M.get_defaults()
	for mode, mappings in pairs(keymaps) do
		local translated_mode = mode_adapters[mode] or mode
		for key, _ in pairs(mappings) do
			-- some plugins may override default bindings that the user hasn't manually overridden
			if
				default[mode][key] ~= nil or (default[translated_mode] ~= nil and default[translated_mode][key] ~= nil)
			then
				pcall(vim.keymap.del, translated_mode, key)
			end
		end
	end
end

-- Set key mappings individually
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param key The key of keymap
-- @param val Can be form as a mapping or tuple of mapping and user defined opt
function M.set_keymaps(mode, key, val)
	local opt = generic_opts[mode] or generic_opts_any
	if type(val) == "table" then
		opt = val[2]
		val = val[1]
	end
	if val then
		vim.keymap.set(mode, key, val, opt)
	else
		pcall(vim.api.nvim_del_keymap, mode, key)
	end
end

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
function M.load_mode(mode, keymaps)
	mode = mode_adapters[mode] or mode
	for k, v in pairs(keymaps) do
		M.set_keymaps(mode, k, v)
	end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
function M.load(keymaps)
	keymaps = keymaps or {}
	for mode, mapping in pairs(keymaps) do
		M.load_mode(mode, mapping)
  end
end

-- Load the default keymappings
function M.load_defaults()
	M.load(M.get_defaults())
	magic.keys = magic.keys or {}
	for idx, _ in pairs(defaults) do
		if not magic.keys[idx] then
			magic.keys[idx] = {}
		end
	end
end

-- Get the default keymappings
function M.get_defaults()
	return defaults
end

return M
