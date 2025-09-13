local function ensure_kernel_for_venv()
  -- from https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/code-runner/molten-nvim/init.lua
  local venv_path = os.getenv 'VIRTUAL_ENV' or os.getenv 'CONDA_PREFIX'
  if not venv_path then
    vim.notify('No virtual environment found.', vim.log.levels.WARN)
    return
  end

  -- Canonicalize the venv_path to ensure consistency
  venv_path = vim.fn.fnamemodify(venv_path, ':p')

  -- Check if the kernel spec already exists
  local handle = io.popen 'python3 -m jupyter kernelspec list --json'
  local existing_kernels = {}
  if handle then
    local result = handle:read '*a'
    handle:close()
    local json = vim.fn.json_decode(result)
    -- Iterate over available kernel specs to find the one for this virtual environment
    for kernel_name, data in pairs(json.kernelspecs) do
      existing_kernels[kernel_name] = true -- Store existing kernel names for validation
      local kernel_path = vim.fn.fnamemodify(data.spec.argv[1], ':p') -- Canonicalize the kernel path
      if kernel_path:find(venv_path, 1, true) then
        vim.notify('Kernel spec for this virtual environment already exists.', vim.log.levels.INFO)
        return kernel_name
      end
    end
  end

  -- Prompt the user for a custom kernel name, ensuring it is unique
  local new_kernel_name
  repeat
    new_kernel_name = vim.fn.input 'Enter a unique name for the new kernel spec: '
    if new_kernel_name == '' then
      vim.notify('Please provide a valid kernel name.', vim.log.levels.ERROR)
      return
    elseif existing_kernels[new_kernel_name] then
      vim.notify("Kernel name '" .. new_kernel_name .. "' already exists. Please choose another name.", vim.log.levels.WARN)
      new_kernel_name = nil
    end
  until new_kernel_name

  -- Create the kernel spec with the unique name
  print 'Creating a new kernel spec for this virtual environment...'
  local cmd = string.format('%s -m ipykernel install --user --name="%s"', vim.fn.shellescape(venv_path .. '/bin/python'), new_kernel_name)

  os.execute(cmd)
  vim.notify("Kernel spec '" .. new_kernel_name .. "' created successfully.", vim.log.levels.INFO)
  return new_kernel_name
end

return {
  -- {
  --   'christoomey/vim-tmux-navigator',
  --   config = function()
  --     vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>')
  --     vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>')
  --     vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>')
  --     vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>')
  --   end,
  -- },
  -- {
  --   'danymat/neogen',
  --   opts = true,
  --   keys = {
  --     {
  --       '<leader>a',
  --       function()
  --         require('neogen').generate()
  --       end,
  --       desc = 'Add Docstring',
  --     },
  --   },
  -- },
  -- {
  --   'GCBallesteros/jupytext.nvim',
  --   config = function()
  --     require('jupytext').setup {
  --       style = 'markdown',
  --       output_extension = 'md',
  --       force_ft = 'markdown',
  --     }
  --   end,
  -- },
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  --   ---@module 'render-markdown'
  --   ---@type render.md.UserConfig
  --   opts = {},
  -- },
  -- {
  --   'GCBallesteros/NotebookNavigator.nvim',
  --   keys = {
  --     {
  --       ']h',
  --       function()
  --         require('notebook-navigator').move_cell 'd'
  --       end,
  --     },
  --     {
  --       '[h',
  --       function()
  --         require('notebook-navigator').move_cell 'u'
  --       end,
  --     },
  --     { '<leader>X', "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
  --     { '<leader>x', "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
  --   },
  --   repl_provider = 'molten',
  --   dependencies = {
  --     'echasnovski/mini.comment',
  --     -- 'hkupty/iron.nvim', -- repl provider
  --     -- "akinsho/toggleterm.nvim", -- alternative repl provider
  --     'benlubas/molten-nvim', -- alternative repl provider
  --     'anuvyklack/hydra.nvim',
  --   },
  --   event = 'VeryLazy',
  --   config = function()
  --     local nn = require 'notebook-navigator'
  --     vim.g.python3_host_prog = vim.fn.expand '~/.local/nvim-venv/bin/python3'
  --     nn.setup { activate_hydra_keys = '<leader>h' }
  --   end,
  --   opts = {
  --     repl_provider = 'iron',
  --     cell_markers = {
  --       python = '#%%',
  --     },
  --   },
  -- },
  -- {
  --   'iamcco/markdown-preview.nvim',
  --   cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  --   ft = { 'markdown' },
  --   build = function()
  --     vim.cmd [[Lazy load markdown-preview.nvim]]
  --     vim.fn['mkdp#util#install']()
  --   end,
  -- },
  -- {
  --   'echasnovski/mini.hipatterns',
  --   event = 'VeryLazy',
  --   dependencies = { 'GCBallesteros/NotebookNavigator.nvim' },
  --   opts = function()
  --     local nn = require 'notebook-navigator'
  --
  --     local opts = { highlighters = { cells = nn.minihipatterns_spec } }
  --     return opts
  --   end,
  -- },
  -- {
  --   'echasnovski/mini.ai',
  --   event = 'VeryLazy',
  --   dependencies = { 'GCBallesteros/NotebookNavigator.nvim' },
  --   opts = function()
  --     local nn = require 'notebook-navigator'
  --
  --     local opts = { custom_textobjects = { h = nn.miniai_spec } }
  --     return opts
  --   end,
  -- },
  -- {
  --   'Vigemus/iron.nvim',
  --   config = function()
  --     local iron = require 'iron.core'
  --     local view = require 'iron.view'
  --     local common = require 'iron.fts.common'
  --
  --     iron.setup {
  --       config = {
  --         -- Whether a repl should be discarded or not
  --         scratch_repl = true,
  --         -- Your repl definitions come here
  --         repl_definition = {
  --           sh = {
  --             -- Can be a table or a function that
  --             -- returns a table (see below)
  --             command = { 'fish' },
  --           },
  --           python = {
  --             command = { 'ipython', '--no-autoindent' },
  --             format = common.bracketed_paste_python,
  --             block_deviders = { '# %%', '#%%' },
  --           },
  --         },
  --         -- How the repl window will be displayed
  --         -- See below for more information
  --         repl_open_cmd = view.split.vertical.rightbelow '%40',
  --       },
  --     }
  --     -- Iron doesn't set keymaps by default anymore.
  --     -- You can set them here or manually add keymaps to the functions in iron.core
  --     -- keymaps = {
  --     --   send_motion = '<space>sc',
  --     --   visual_send = '<space>sc',
  --     --   send_file = '<space>sf',
  --     --   send_line = '<space>sl',
  --     --   send_mark = '<space>sm',
  --     --   mark_motion = '<space>mc',
  --     --   mark_visual = '<space>mc',
  --     --   remove_mark = '<space>md',
  --     --   cr = '<space>s<cr>',
  --     --   interrupt = '<space>s<space>',
  --     --   exit = '<space>sq',
  --     --   clear = '<space>cl',
  --     -- },
  --     -- If the highlight is on, you can change how it looks
  --     -- For the available options, check nvim_set_hl
  --
  --     -- iron also has a list of commands, see :h iron-commands for all available commands
  --     -- vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
  --     -- vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
  --     -- vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
  --     -- vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
  --   end,
  -- },
  -- {
  --   'benlubas/molten-nvim',
  --   build = ':UpdateRemotePlugins',
  --   init = function()
  --     -- these are examples, not defaults. Please see the readme
  --     vim.g.molten_image_provider = 'image.nvim'
  --     vim.g.molten_output_win_max_height = 20
  --     vim.g.molten_virt_text_output = false
  --     vim.g.python3_host_prog = vim.fn.expand '~/.local/nvim-venv/bin/python3'
  --
  --     vim.g.molten_auto_init_behavior = 'init'
  --     vim.g.molten_enter_output_behavior = 'open_and_enter'
  --     -- vim.keymap.set('n', '<localleader>mi', ':MoltenInit<CR>', { silent = true, desc = 'Initialize the plugin' })
  --     -- vim.keymap.set('n', '<localleader>r', ':MoltenEvaluateOperator<CR>', { silent = true, desc = 'run operator selection' })
  --     -- vim.keymap.set('n', '<localleader>rl', ':MoltenEvaluateLine<CR>', { silent = true, desc = 'evaluate line' })
  --     -- vim.keymap.set('n', '<localleader>rr', ':MoltenReevaluateCell<CR>', { silent = true, desc = 're-evaluate cell' })
  --     -- vim.keymap.set('v', '<localleader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', { silent = true, desc = 'evaluate visual selection' })
  --     vim.keymap.set('n', '<localleader>os', ':noautocmd MoltenEnterOutput<CR>', { silent = true, desc = 'show/enter output' })
  --     vim.keymap.set('n', '<localleader>mr', ':MoltenRestart<CR>', { silent = true, desc = '[M]olten [R]estart' })
  --     -- -- Dynamic Kernel Initialization based on Python Virtual Environment
  --     vim.api.nvim_set_keymap('n', '<localleader>mi', '', {
  --       callback = function()
  --         local kernel_name = ensure_kernel_for_venv()
  --         if kernel_name then
  --           vim.cmd(('MoltenInit %s'):format(kernel_name))
  --         else
  --           vim.notify('No kernel to initialize.', vim.log.levels.WARN)
  --         end
  --       end,
  --       desc = '[m]olten [i]nitialize',
  --       silent = true,
  --     })
  --   end,
  -- },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    '3rd/image.nvim',
    opts = {
      backend = 'kitty', -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
    },
    dependencies = {
      'kiyoon/magick.nvim',
    },
    build = false,
  },
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
}
