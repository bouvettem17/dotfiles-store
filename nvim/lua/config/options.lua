vim.g.mapleader = " "

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

if vim.g.neovide then
    vim.o.guifont = "Fira Code,Symbols Nerd Font Mono:h34"
    vim.g.neovide_scale_factor = 0.3
end

vim.opt.mousescroll = "ver:2,hor:6"

-- vim.g.node_host_prog = "/Users/folke/.pnpm-global/5/node_modules/neovim/bin/cli.js"
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    return keymap_set(mode, lhs, rhs, opts)
end

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m]"]])
vim.cmd([[let &t_Ce = "\e[4:0m]"]])
