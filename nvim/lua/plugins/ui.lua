return {
    -- Stop JDTLS spam notifications
    -- {
    --     "folke/noice.nvim",
    --     opts = function(_, opts)
    --         local filters = {
    --             {
    --                 event = "lsp",
    --                 find = "Validate documents",
    --             },
    --             {
    --                 event = "lsp",
    --                 find = "Publish Diagnostics",
    --             },
    --         }
    --
    --         for _, filter in ipairs(filters) do
    --             table.insert(opts.routes, {
    --                 filter = filter,
    --                 opts = { stop = true },
    --             })
    --         end
    --         opts.presets.lsp_doc_border = true
    --     end,
    -- },
    {
        "folke/noice.nvim",
        opts = function(_, opts)
            table.insert(opts.routes, {
                filter = {
                    event = "notify",
                    find = "No information available",
                },
                opts = { skip = true },
            })
            local focused = true
            vim.api.nvim_create_autocmd("FocusGained", {
                callback = function()
                    focused = true
                end,
            })
            vim.api.nvim_create_autocmd("FocusLost", {
                callback = function()
                    focused = false
                end,
            })
            table.insert(opts.routes, 1, {
                filter = {
                    ["not"] = {
                        event = "lsp",
                        kind = "progress",
                    },
                    cond = function()
                        return not focused
                    end,
                },
                view = "notify_send",
                opts = { stop = false },
            })

            local filters = {
                {
                    event = "lsp",
                    find = "Validate documents",
                },
                {
                    event = "lsp",
                    find = "Publish Diagnostics",
                },
            }

            for _, filter in ipairs(filters) do
                table.insert(opts.routes, {
                    filter = filter,
                    opts = { stop = true },
                })
            end
            -- opts.status = { lsp_progress = { event = "lsp", kind = "progress" } }

            opts.commands = {
                all = {
                    -- options for the message history that you get with `:Noice`
                    view = "split",
                    opts = { enter = true, format = "details" },
                    filter = {},
                },
            }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function(event)
                    vim.schedule(function()
                        require("noice.text.markdown").keys(event.buf)
                    end)
                end,
            })
        end,
    },
    -- Notify Duration
    {
        "rcarriga/nvim-notify",
        opts = {
            timeout = 5000,
        },
    },

    -- auto-resize windows
    {
        "anuvyklack/windows.nvim",
        event = "WinNew",
        dependencies = {
            { "anuvyklack/middleclass" },
            { "anuvyklack/animation.nvim", enabled = false },
        },
        keys = { { "<leader>m", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
        config = function()
            vim.o.winwidth = 5
            vim.o.equalalways = false
            require("windows").setup({
                animation = { enable = false, duration = 150 },
            })
        end,
    },

    -- Dim code not being edited
    "folke/twilight.nvim",
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        opts = {
            plugins = {
                gitsigns = true,
                tmux = true,
                kitty = { enabled = false, font = "+2" },
            },
        },
        keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
    },

    -- filename
    --[[{
        "b0o/incline.nvim",
        event = "BufReadPre",
        priority = 1200,
        config = function()
            require("incline").setup({
                highlight = {
                    groups = {
                        InclineNormal = { guibg = "#FF5F1F", guifg = "#0E1013" },
                        InclineNormalNC = { guibg = "#0E1013", guifg = "#FF5F1F" },
                    },
                },
                window = { margin = { vertical = 0, horizontal = 1 } },
                hide = {
                    cursorline = true,
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    if vim.bo[props.buf].modified then
                        filename = "[+]" .. filename
                    end

                    local icon, color = require("nvim-web-devicons").get_icon_color(filename)
                    return { { icon, guifg = color }, { " " }, { filename } }
                end,
            })
        end,
    },]]

    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            table.insert(opts.sections.lualine_x, {
                function()
                    return require("util.dashboard").status()
                end,
            })
        end,
    },
}
