return {
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false, -- Don't lazy load - important for auto-conversion
    config = function()
      require("jupytext").setup({
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
      })
    end,
  },
}
