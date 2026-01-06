return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "quarto", "markdown" },
    config = function()
      local quarto = require("quarto")
      quarto.setup({
        lspFeatures = {
          languages = { "r", "python", "rust" },
          chunks = "all",
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
          keymap = {
            hover = "K",
            definition = "gd",
            references = "gr",
            format = "<leader>cf",
          },
        },
        codeRunner = {
          enabled = true,
          default_method = "molten",
        },
      })

      -- Quarto keymaps
      local runner = require("quarto.runner")
      vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "Run cell", silent = true })
      vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "Run cell and above", silent = true })
      vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "Run all cells", silent = true })
      vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "Run line", silent = true })
      vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "Run visual range", silent = true })
      vim.keymap.set("n", "<localleader>RA", function()
        runner.run_all(true)
      end, { desc = "Run all cells of all languages", silent = true })
    end,
  },
}
