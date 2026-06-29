vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

-- Leader
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Delete without yanking
vim.keymap.set("n", "x", '"_x', opts)
vim.keymap.set("n", "dd", '"_dd', opts)
vim.keymap.set("n", "dw", '"_dw', opts)
vim.keymap.set("v", "d", '"_d', opts)

-- Delete and yank
vim.keymap.set("n", "<leader>dd", "dd", opts)
vim.keymap.set("n", "<leader>dw", "dw", opts)
vim.keymap.set("v", "<leader>d", "d", opts)

-- File operations
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", opts)
vim.keymap.set("n", "<C-q>", "<cmd>q<CR>", opts)

-- Scrolling
vim.keymap.set("n", "<C-j>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-k>", "<C-u>zz", opts)

-- Buffers (winbuf)
vim.keymap.set("n", "<Tab>", function()
	require("winbuf").cycle(1)
end, opts)

vim.keymap.set("n", "<S-Tab>", function()
	require("winbuf").cycle(-1)
end, opts)

vim.keymap.set("n", "<leader>x", function()
	if #vim.fn.getbufinfo({ buflisted = 1 }) <= 1 then
		vim.cmd("enew")
	end

	require("winbuf").close_buf()
end, opts)

vim.keymap.set("n", "<leader>b", "<cmd>enew<CR>", opts)

-- Window splits
local function safe_split(split_cmd)
	-- If we are currently sitting inside Neo-tree, bounce cursor left/right to find code first
	if vim.bo.filetype == "neo-tree" then
		vim.cmd("wincmd p") -- Moves focus to the previous active window pane
	end
	vim.cmd(split_cmd)
end

vim.keymap.set("n", "<leader>v", function()
	safe_split("vsplit")
end, opts) -- Safe Vertical Split
vim.keymap.set("n", "<leader>h", function()
	safe_split("split")
end, opts) -- Safe Horizontal Split
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- Standardize sizes evenly

vim.keymap.set("n", "<leader>xs", function()
	-- If we try to close a split while focusing on Neo-tree, don't let winbuf crash.
	-- Just toggle the sidebar shut instead!
	if vim.bo.filetype == "neo-tree" then
		vim.cmd("Neotree toggle")
	else
		require("windbuf").close_split()
	end
end, opts)

-- Window navigation
vim.keymap.set("n", "<C-M-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-M-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-M-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-M-l>", "<C-w>l", opts)

-- Move buffer between splits
vim.keymap.set("n", "<leader>mh", function()
	require("winbuf").move_buf("h")
end, opts)

vim.keymap.set("n", "<leader>mj", function()
	require("winbuf").move_buf("j")
end, opts)

vim.keymap.set("n", "<leader>mk", function()
	require("winbuf").move_buf("k")
end, opts)

vim.keymap.set("n", "<leader>ml", function()
	require("winbuf").move_buf("l")
end, opts)

-- Move lines
vim.keymap.set("n", "<A-j>", '<cmd>execute "move .+" . v:count1<CR>==', opts)
vim.keymap.set("n", "<A-k>", '<cmd>execute "move .-" . (v:count1 + 1)<CR>==', opts)

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Resize splits
vim.keymap.set("n", "<Up>", "<cmd>resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", "<cmd>resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", "<cmd>vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", "<cmd>vertical resize +2<CR>", opts)

-- Indentation
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Paste without replacing register
vim.keymap.set("v", "p", '"_dP', opts)

-- Jump forward
vim.keymap.set("n", "<C-i>", "<C-i>", opts)

vim.keymap.set("n", "<leader>fs", "<cmd>FzfLua blines<CR>", opts) -- Find substring in CURRENT file
vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", opts) -- Find substring across WHOLE project workspace
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", opts) -- Find raw file names quickly

vim.keymap.set("n", "<leader>w", function()
	-- Toggle the state
	local new_state = not vim.wo.wrap

	vim.wo.wrap = new_state
	vim.wo.linebreak = new_state -- FIX: Ensures words aren't cut off mid-character

	if new_state then
		vim.notify("Word-Wise Wrap Enabled", vim.log.levels.INFO, { title = "UI" })
	else
		vim.notify("Wrap Disabled", vim.log.levels.INFO, { title = "UI" })
	end
end, { desc = "Toggle Word-Wise Line Wrap" })

-- Map Ctrl + / in Normal mode to comment/uncomment the current line
vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Comment line" })
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Comment line" })

-- Map Ctrl + / in Visual mode to comment/uncomment highlighted code selections
vim.keymap.set("v", "<C-_>", "gc", { remap = true, desc = "Comment selection" })
vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Comment selection" })
