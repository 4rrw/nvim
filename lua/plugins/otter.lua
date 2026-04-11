return {
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.schedule(function()
            require("otter").activate({ "python", "lua", "bash" }, true, true)
          end)
        end,
      })
    end,
  },
}
