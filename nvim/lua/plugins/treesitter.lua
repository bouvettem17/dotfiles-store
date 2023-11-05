return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
    config = function()
        require("nvim-treesitter.configs").setup {
              highlight = {
                enable = true,
                disable = {},
              },
              indent = {
                enable = true,
                disable = {},
              },
              ensure_installed = {
                "markdown",
                "tsx",
                "typescript",
                "toml",
                "fish",
                "json",
                "yaml",
                "css",
                "html",
                "lua",
                "java",
                "javascript"
              },
              autotag = {
                enable = true,
              },
        }

        local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
        parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
    end
}
