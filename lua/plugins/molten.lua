return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    ft = { "python", "markdown", "quarto" },
    init = function()
      -- vim.g.molten_cover_empty_lines = true
      -- vim.g.molten_comment_string = "# %%"

      -- vim.g.molten_auto_image_popup = true
      -- vim.g.molten_show_mimetype_debug = true
      vim.g.molten_auto_open_output = false
      vim.g.molten_image_location = "float"
      vim.g.molten_image_provider = "image.nvim"
      -- vim.g.molten_output_show_more = true
      vim.g.molten_output_win_border = { "", "━", "", "" }
      vim.g.molten_output_win_max_height = 12
      -- vim.g.molten_output_virt_lines = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_use_border_highlights = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_wrap_output = true
      vim.g.molten_tick_rate = 142
      local imb = function(e) -- init molten buffer
        vim.schedule(function()
          local kernels = vim.fn.MoltenAvailableKernels()
          local try_kernel_name = function()
            local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
            return metadata.kernelspec.name
          end
          local ok, kernel_name = pcall(try_kernel_name)
          if not ok or not vim.tbl_contains(kernels, kernel_name) then
            kernel_name = nil
            local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
            if venv ~= nil then
              kernel_name = string.match(venv, "/.+/(.+)")
            end
          end
          if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
            vim.cmd(("MoltenInit %s"):format(kernel_name))
          end
          vim.cmd("MoltenImportOutput")
        end)
      end

      -- automatically import output chunks from a jupyter notebook
      vim.api.nvim_create_autocmd("BufAdd", {
        pattern = { "*.ipynb" },
        callback = imb,
      })

      -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.ipynb" },
        callback = function(e)
          if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
            imb(e)
          end
        end,
      })
      -- automatically export output chunks to a jupyter notebook on write
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.ipynb" },
        callback = function()
          if require("molten.status").initialized() == "Molten" then
            vim.cmd("MoltenExportOutput!")
          end
        end,
      })
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
