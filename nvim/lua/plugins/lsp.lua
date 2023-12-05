local java_filetypes = { "java" }
local mason_root = os.getenv("HOME") .. "/.local/share/nvim/mason"

return {
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "stylua",
                "selene",
                "luacheck",
                "shellcheck",
                "shfmt",
                "angular-language-server",
            })
        end,
    },

    {
        "mfussenegger/nvim-jdtls",
        dependencies = { "folke/which-key.nvim" },
        ft = java_filetypes,
        config = function()
            function bemol()
                local bemol_dir = vim.fs.find({ ".bemol" }, { upward = true, type = "directory" })[1]
                local ws_folders_lsp = {}
                if bemol_dir then
                    local file = io.open(bemol_dir .. "/ws_root_folders", "r")
                    if file then
                        for line in file:lines() do
                            table.insert(ws_folders_lsp, line)
                        end
                        file:close()
                    end
                end

                for _, line in ipairs(ws_folders_lsp) do
                    vim.lsp.buf.add_workspace_folder(line)
                end
            end

            local function attach_jdtls()
                local config = {
                    cmd = {
                        vim.fn.exepath("jdtls"),
                        "--jvm-arg=-javaagent:" .. mason_root .. "/packages/jdtls/lombok.jar",
                    },
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                }
                bemol()
                require("jdtls").start_or_attach(config)
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = java_filetypes,
                callback = attach_jdtls,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.name == "jdtls" then
                        local wk = require("which-key")
                        wk.register({
                            ["<leader>co"] = { require("jdtls").organize_imports, "Organize Imports" },
                        }, { mode = "n", buffer = args.buf })
                    end
                end,
            })

            attach_jdtls()
        end,
    },
}
