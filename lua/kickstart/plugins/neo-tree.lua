-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<leader>e', '<cmd>Neotree filesystem reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  lazy = false,
  config = function()
    require('neo-tree').setup {
      event_handlers = {

        {
          event = 'file_open_requested',
          handler = function()
            require('neo-tree.command').execute { action = 'close' }
          end,
        },
      },
      filesystem = {
        filtered_items = {
          visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        window = {
          position = 'current',
          mappings = {
            ['<leader>'] = 'noop', -- This disables any <leader> mappings in NeoTree
            ['o'] = 'system_open',
          },
        },
        hijack_netrw_behavior = 'open_current',
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          vim.fn.jobstart({ 'xdg-open', path }, { detach = true })
          local p
          vim.cmd('silent !start explorer ' .. p)
        end,
      },
    }
  end,
}
