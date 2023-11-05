return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        -- disable netrw at the very start of your init.lua (strongly advised)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup{
          hijack_netrw = true,
          sort_by = "case_sensitive",
          hijack_cursor = true,
          update_cwd = true,
          git = {
            enable = true,
            ignore = true,
            timeout = 500
          },
          view = {
            width = 60,
          },
          renderer = {
            group_empty = true,
          },
          filters = {
            dotfiles = true,
          },
        }


        vim.keymap.set("n", "sf", ":NvimTreeToggle<cr>")

        local function open_nvim_tree(data)

          -- buffer is a [No Name]
          local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

          -- buffer is a directory
          local directory = vim.fn.isdirectory(data.file) == 1

          if not no_name and not directory then
            return
          end

          -- change to the directory
          if directory then
            vim.cmd.cd(data.file)
          end

          -- open the tree
          require("nvim-tree.api").tree.open()
        end

        vim.api.nvim_create_autocmd("VimEnter", { callback = open_nvim_tree })

    end

}
