return {
    "sindrets/diffview.nvim",
    config = function()
        require('diffview').setup({})
        vim.keymap.set('n', '<leader>dv', '<Cmd>DiffviewOpen<CR>')
    end
}
