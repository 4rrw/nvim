return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    ft = { "python", "markdown", "quarto" },
    init = function()
      -- Molten configuration
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = false
    end,
    config = function()
      -- Keymaps for Molten
      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })
      vim.keymap.set(
        "n",
        "<localleader>me",
        ":MoltenEvaluateOperator<CR>",
        { desc = "Evaluate operator", silent = true }
      )
      vim.keymap.set("n", "<localleader>ml", ":MoltenEvaluateLine<CR>", { desc = "Evaluate line", silent = true })
      vim.keymap.set("n", "<localleader>mr", ":MoltenReevaluateCell<CR>", { desc = "Re-evaluate cell", silent = true })
      vim.keymap.set(
        "v",
        "<localleader>mv",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        { desc = "Evaluate visual", silent = true }
      )
      vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "Delete cell", silent = true })
      vim.keymap.set("n", "<localleader>mo", ":MoltenHideOutput<CR>", { desc = "Hide output", silent = true })
      vim.keymap.set("n", "<localleader>ms", ":MoltenShowOutput<CR>", { desc = "Show output", silent = true })
      vim.keymap.set("n", "<localleader>mp", ":MoltenImagePopup<CR>", { desc = "Image popup", silent = true })
    end,
  },
}
