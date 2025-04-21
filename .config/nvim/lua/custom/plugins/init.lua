return {
  -- require 'fs/oil',
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    -- --@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      require('oil').setup {
        view_options = {
          show_hidden = true,
        },
      }
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Use the latest stable version
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          inlay_hints = {
            auto = true,
          },
        },
      }
    end,
  },
  {
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    config = function()
      require('chatgpt').setup {
        -- Optional configuration
      }
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
}
