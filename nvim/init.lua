-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("util.dashboard").setup()

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("util").version()
    end,
})
