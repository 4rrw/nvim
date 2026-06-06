return {
  "okuuva/auto-save.nvim",
  version = "^1",
  cmd = "ASToggle", -- toggle autosave on/off
  event = "FocusLost",
  opts = {
    trigger_events = {
      immediate_save = { "FocusLost" },
      defer_save = {},
      cancel_deferred_save = {},
    },
    condition = function(buf)
      -- skip non-file / non-modifiable buffers
      if vim.bo[buf].modifiable == false then return false end
      if vim.bo[buf].buftype ~= "" then return false end
      return true
    end,
    debounce_delay = 1000, -- wait 1s after the last change before saving
  },
}
