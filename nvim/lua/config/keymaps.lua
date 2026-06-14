vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

-- Leader
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Delete without yanking
vim.keymap.set("n", "x", '"_x', opts)
vim.keymap.set("n", "dd", '"_dd', opts)
vim.keymap.set("v", "d", '"_d', opts)

-- Delete and yank
vim.keymap.set("n", "<leader>d", "dd", opts)
vim.keymap.set("v", "<leader>d", "d", opts)

-- File operations
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", opts)
vim.keymap.set("n", "<C-q>", "<cmd>q<CR>", opts)

-- Scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

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
vim.keymap.set("n", "<leader>v", "<C-w>v", opts)
vim.keymap.set("n", "<leader>h", "<C-w>s", opts)
vim.keymap.set("n", "<leader>se", "<C-w>=", opts)

vim.keymap.set("n", "<leader>xs", function()
	require("winbuf").close_split()
end, opts)

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

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

vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua blines<CR>", opts) -- Find substring in CURRENT file
vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", opts) -- Find substring across WHOLE project workspace
vim.keymap.set("n", "<leader>fd", "<cmd>FzfLua files<CR>", opts) -- Find raw file names quickly
