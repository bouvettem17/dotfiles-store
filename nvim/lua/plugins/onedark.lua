return {
    "navarasu/onedark.nvim",
    config = function ()
        vim.cmd [[ colorscheme onedark ]]

        require('onedark').setup {
           style = 'darker'
        }
       require('onedark').load()
    end
}
