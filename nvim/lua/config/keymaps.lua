local util = require("util")
local discipline = require("config.discipline")
discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Navigation
local nav = {
    h = "Left",
    j = "Down",
    k = "Up",
    l = "Right",
}

local function navigate(dir)
    return function()
        local win = vim.api.nvim_get_current_win()
        vim.cmd.wincmd(dir)
        local pane = vim.env.WEZTERM_PANE
        if pane and win == vim.api.nvim_get_current_win() then
            local pane_dir = nav[dir]
            vim.system({ "wezterm", "cli", "activate-pane-direction", pane_dir }, { text = true }, function(p)
                if p.code ~= 0 then
                    vim.notify(
                        "Failed to move to pane " .. pane_dir .. "\n" .. p.stderr,
                        vim.log.levels.ERROR,
                        { title = "Wezterm" }
                    )
                end
            end)
        end
    end
end

util.set_user_var("IS_NVIM", true)
-- Move to window using the movement keys
for key, dir in pairs(nav) do
    keymap.set("n", "<" .. dir .. ">", navigate(key))
    keymap.set("n", "<C-" .. key .. ">", navigate(key))
end

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", "vb_d")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", "tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split Window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- change word with <c-c>
keymap.set("n", "<C-c>", "<cmd>normal! ciw<cr>a")

-- ChatGPT
keymap.set("n", "<leader>gpt", ":ChatGPT<Return>")
