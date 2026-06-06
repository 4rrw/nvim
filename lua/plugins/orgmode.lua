return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    -- stylua: ignore
    keys = {
      { "<leader>o", icon="󱗃", desc = "+org" },
      { "<leader>oa", function() require("orgmode").action("agenda.prompt") end, desc = "Agenda" },
      { "<leader>oc", function() require("orgmode").action("capture.prompt") end, desc = "Capture" },
    },
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/orgfiles/**/*",
        org_default_notes_file = "~/orgfiles/refile.org",
      })

      -- Experimental LSP support
      vim.lsp.enable("org")
    end,
  },

  -- Register the org keymap groups + icons in which-key, so the many
  -- built-in `<leader>o*` mappings show up organized like other LazyVim plugins.
  {
    "folke/which-key.nvim",
    opts = {
      -- Names for the org prefix tree (LazyVim style: just group names).
      spec = {
        {
          mode = { "n", "x" },
          { "<leader>o", group = "org" },
          { "<leader>od", group = "dates" },
          { "<leader>oi", group = "insert" },
          { "<leader>ol", group = "link" },
          { "<leader>on", group = "note" },
          { "<leader>ox", group = "clock" },
        },
      },
      -- Icons assigned via which-key rules (pattern-matched on the keymap
      -- desc/group), the same mechanism LazyVim relies on for its own groups.
      icons = {
        rules = {
          { pattern = "org", icon = "󱗃", color = "green" },
          { pattern = "agenda", icon = "", color = "green" },
          { pattern = "capture", icon = "", color = "yellow" },
          { pattern = "clock", icon = "", color = "orange" },
          { pattern = "deadline", icon = "", color = "red" },
          { pattern = "schedule", icon = "", color = "blue" },
          { pattern = "refile", icon = "", color = "cyan" },
          { pattern = "link", icon = "", color = "cyan" },
          { pattern = "note", icon = "", color = "yellow" },
        },
      },
    },
  },
}
