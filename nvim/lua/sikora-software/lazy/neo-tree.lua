return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "echasnovski/mini.icons",
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
            never_show = { ".git", ".DS_Store" },
          },
          follow_current_file = {
            enabled = true,    -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          hijack_netrw_behavior = "disabled",
          use_libuv_file_watcher = true,
        },
        buffers = {
          follow_current_file = {
            enabled = true,    -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
        },
        default_component_configs = {
          name = {
            use_git_status_colors = true,
          },
        },
        window = {
          position = "right",
        },
      })

      vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right<CR>")
      vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})

      vim.cmd([[
        highlight! NeoTreeGitModified guifg=#FFA000
        highlight! NeoTreeGitUntracked guifg=#00FFA5
      ]])
    end,
  },
}
