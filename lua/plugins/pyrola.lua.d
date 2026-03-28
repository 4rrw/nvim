return {
  {
    dir = "/home/stshalson/projects/repos/pyrola.nvim",
    -- "matarina/pyrola.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local pyrola = require("pyrola")

      pyrola.setup({
        -- Optional: point to a specific Python (conda/venv).
        -- If omitted, uses g:python3_host_prog or "python3".
        -- python_path = "~/miniconda3/envs/ds/bin/python",

        kernel_map = {
          python = "py3", -- Jupyter kernel name for Python files
          r = "ir", -- Jupyter kernel name for R files
        },
        split_horizontal = false,
        split_ratio = 0.65,
        image = {
          cell_width = 10,
          cell_height = 20,
          max_width_ratio = 0.5,
          max_height_ratio = 0.5,
          offset_row = 0,
          offset_col = 0,
          protocol = "auto", -- auto | kitty | iterm2 | none
        },
      })

      -- Keybindings
      vim.keymap.set("n", "<CR>", pyrola.send_statement_definition, { noremap = true })
      vim.keymap.set("v", "<leader>vs", pyrola.send_visual_to_repl, { noremap = true })
      vim.keymap.set("n", "<leader>vb", pyrola.send_buffer_to_repl, { noremap = true })
      vim.keymap.set("n", "<leader>is", pyrola.inspect, { noremap = true })
      vim.keymap.set("n", "<leader>ig", pyrola.show_globals, { noremap = true })
      vim.keymap.set("n", "<leader>ik", pyrola.interrupt_kernel, { noremap = true })
      vim.keymap.set("n", "<leader>im", pyrola.open_history_manager, { noremap = true })
    end,
  },

  -- -- Tree-sitter is required.
  -- -- Parsers for languages listed in `kernel_map` must be installed.
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   build = ":TSUpdate",
  --   config = function()
  --     local ts = require("nvim-treesitter")
  --
  --     ts.setup({
  --       install_dir = vim.fn.stdpath("data") .. "/site",
  --     })
  --
  --     -- Install required parsers
  --     ts.install({ "python", "markdown", "lua" })
  --   end,
  -- },
}
