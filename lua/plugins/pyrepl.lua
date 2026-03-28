return {
  {
    "dangooddd/pyrepl.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local pyrepl = require("pyrepl")

      -- default config
      pyrepl.setup({
        split_horizontal = false,
        split_ratio = 0.4,
        style = "default",
        style_treesitter = true,
        image_max_history = 10,
        image_width_ratio = 0.5,
        image_height_ratio = 0.5,
        -- built-in provider, works best for ghostty and kitty
        -- for other terminals use "image" provider
        image_provider = "placeholders",
        cell_pattern = "^#%s*%%%%.*$",
        preferred_kernel = "python3",
        jupytext_hook = true,
      })

      -- main commands
      vim.keymap.set("n", "<leader>jo", pyrepl.open_repl, { desc = "Open REPL", silent = true })
      vim.keymap.set("n", "<leader>jh", pyrepl.hide_repl, { desc = "Hide REPL", silent = true })
      vim.keymap.set("n", "<leader>jc", pyrepl.close_repl, { desc = "Close REPL", silent = true })
      vim.keymap.set("n", "<leader>ji", pyrepl.open_image_history, { desc = "Open image history", silent = true })
      vim.keymap.set({ "n", "t" }, "<C-j>", pyrepl.toggle_repl_focus, { desc = "Toggle REPL focus", silent = true })

      -- send commands
      vim.keymap.set("n", "<leader>jb", pyrepl.send_buffer, { desc = "Send buffer", silent = true })
      vim.keymap.set("n", "<leader>jl", pyrepl.send_cell, { desc = "Send cell", silent = true })
      vim.keymap.set("v", "<leader>jv", pyrepl.send_visual, { desc = "Send visual", silent = true })

      -- utility commands
      vim.keymap.set("n", "<leader>jp", pyrepl.step_cell_backward, { desc = "Step cell backward", silent = true })
      vim.keymap.set("n", "<leader>jn", pyrepl.step_cell_forward, { desc = "Step cell forward", silent = true })
      vim.keymap.set("n", "<leader>je", pyrepl.export_to_notebook, { desc = "Export to notebook", silent = true })
      vim.keymap.set("n", "<leader>js", ":PyreplInstall", { desc = "Pyrepl Install", silent = true })
    end,
  },
}
