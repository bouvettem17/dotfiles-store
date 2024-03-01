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
                "prettierd",
                "prettier",
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
                if not bemol_dir then
                    print("Bemol directory not found.") -- Log for debugging
                end

                local ws_folders_lsp = vim.lsp.buf.list_workspace_folders() or {}
                local folders_to_add = {}

                local file = io.open(bemol_dir .. "/ws_root_folders", "r")
                if file then
                    for line in file:lines() do
                        if not vim.tbl_contains(ws_folders_lsp, line) then
                            table.insert(folders_to_add, line)
                        end
                    end
                    file:close()
                else
                    print("Failed to open " .. bemol_dir .. "/ws_root_folders") -- Log for debugging
                end

                for _, folder in ipairs(folders_to_add) do
                    vim.lsp.buf.add_workspace_folder(folder)
                end
            end

            local function attach_jdtls()
                local jdtls_cmd = vim.fn.exepath("jdtls")
                local lombok_path = "--jvm-arg=-javaagent:" .. mason_root .. "/packages/jdtls/lombok.jar"
                local filename = vim.api.nvim_buf_get_name(0) -- Get the current buffer's filename

                local function project_name(root_dir)
                    return root_dir and vim.fs.basename(root_dir)
                end

                local root_dir_func = require("lspconfig.server_configurations.jdtls").default_config.root_dir
                local root_dir = root_dir_func(filename)

                if not root_dir then
                    print("Error: Failed to determine the root directory.")
                    return
                end

                local project_name_str = project_name(root_dir)

                local jdtls_workspace_dir = "-data " ..
                    vim.fn.stdpath("cache") .. "/jdtls/" .. project_name_str .. "/workspace"

                local jdtls_config_dir = "-configuration " ..
                    vim.fn.stdpath("cache") .. "/jdtls/" .. project_name_str .. "/config"

                local function on_attach(client, bufnr)
                    bemol()
                end

                local config = {
                    cmd = { jdtls_cmd, lombok_path, jdtls_config_dir, jdtls_workspace_dir },
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    on_attach = on_attach,
                }

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
        end,
    },

    {
        "stevearc/conform.nvim",
        optional = true,
        enabled = false,
        opts = {
            formatters_by_ft = {
                ["markdown"] = { { "prettierd", "prettier" } },
                ["markdown.mdx"] = { { "prettierd", "prettier" } },
                ["javascript"] = { "dprint" },
                ["javascriptreact"] = { "dprint" },
                ["typescript"] = { "dprint" },
                ["typescriptreact"] = { "dprint" },
            },
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "2", "-ci" },
                },
                dprint = {
                    condition = function(ctx)
                        return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
                    end,
                },
            },
        },
    },
}
