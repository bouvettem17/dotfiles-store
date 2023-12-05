return {
    {
        "folke/noice.nvim",
        opts = function(_, opts)
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
            opts.presets.lsp_doc_border = true
        end,
    },

    -- Notify Duration
    {
        "rcarriga/nvim-notify",
        opts = {
            timeout = 5000,
        },
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

    {
        "lewis6991/gitsigns.nvim",
        enabled = true,
        opts = function(_, opts)
            opts.debug_mode = true
        end,
    },
}
