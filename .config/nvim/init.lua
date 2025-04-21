vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function load_dotenv(filepath)
  local file = io.open(filepath, 'r')
  if not file then
    return
  end

  for line in file:lines() do
    local key, value = line:match '^%s*([^#=]+)%s*=%s*(.-)%s*$'
    if key and value then
      vim.env[key] = value
    end
  end

  file:close()
end

-- Automatically load the .env file from your Nushell config dir
local home = os.getenv 'HOME'
load_dotenv(home .. '/.config/nushell/.env')

vim.g.openai_api_key = vim.env.OPENAI_API_KEY

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- other setup TODO: move this somewhere proper
local cmp = require 'cmp'

cmp.setup {
  mapping = {
    ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item
    ['<Tab>'] = cmp.mapping.select_next_item(), -- Navigate to next item
    ['<S-Tab>'] = cmp.mapping.select_prev_item(), -- Navigate to previous item
  },
  -- ... other configurations
}
