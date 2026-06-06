-- since this is just an example spec, don't actually load anything here and return an empty spec
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        -- Turn on / off code block & inline code rendering
        enabled = true,
        -- Turn on / off any sign column related rendering
        sign = true,
        -- Determines how code blocks & inline code are rendered:
        --  none: disables all rendering
        --  normal: adds highlight group to code blocks & inline code, adds padding to code blocks
        --  language: adds language icon to sign column if enabled and icon + name above code blocks
        --  full: normal + language
        style = "full",
        -- Amount of padding to add to the left of code blocks
        left_pad = 0,
        -- Determins how the top / bottom of code block are rendered:
        --  thick: use the same highlight as the code body
        --  thin: when lines are empty overlay the above & below icons
        border = "thin",
        -- Used above code blocks for thin border
        above = "▄",
        -- Used below code blocks for thin border
        below = "▀",
        -- Highlight for code blocks & inline code

        highlight = "RenderMarkdownCode",
      },
    },
  },
  {
    "nvim-mini/mini.hipatterns",
    event = "VeryLazy",
    opts = function()
      vim.api.nvim_set_hl(0, "JupytextCellMarker", { fg = "#888888", bold = true })
      local get_cell_marker = function(bufnr, cell_markers)
        local ft = vim.bo[bufnr].filetype

        local user_opt_cell_marker = cell_markers[ft]
        if user_opt_cell_marker then
          return user_opt_cell_marker
        end

        -- use double percent markers as default for cell markers
        -- DOCS https://jupytext.readthedocs.io/en/latest/formats-scripts.html#the-percent-format
        if not vim.bo.commentstring then
          error("There's no cell marker and no commentstring defined for filetype " .. ft)
        end
        local cstring = string.gsub(vim.bo.commentstring, "^%%", "%%%%")
        local double_percent_cell_marker = cstring:format("%%")
        return double_percent_cell_marker
      end
      local minihipatterns_spec = function(cell_markers, hl_group)
        local notebook_cells = {
          pattern = function(buf_id)
            local cell_marker = get_cell_marker(buf_id, cell_markers)
            if cell_marker then
              local regex_cell_marker = string.gsub("^" .. cell_marker, "%%", "%%%%")
              return regex_cell_marker
            else
              return nil
            end
          end,
          group = "JupytextCellMarker",
          extmark_opts = {
            virt_text = {
              {
                "────────────────────────────────────────────────────────────────────────────────────",
                hl_group,
              },
            },
            line_hl_group = hl_group,
            hl_eol = true,
          },
        }
        return notebook_cells
      end

      local opts = { highlighters = { cells = minihipatterns_spec({}, "JupytextCellMarker") } }
      return opts
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    lazy = false,
    cmd = "IncRename",
    opts = {},
  },
  {
    "folke/snacks.nvim",
    opts = {
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 20, total = 100 },
          easing = "linear",
          fps = 120,
        },
        animate_repeat = {
          delay = 50,
          duration = { step = 3, total = 20 },
          easing = "linear",
        },
      },
      picker = {
        sources = {
          explorer = {
            auto_close = false,
            hidden = true,
            ignored = true,
            win = {
              list = {
                keys = {
                  ["Y"] = "yank_relative",
                },
              },
            },
            actions = {
              yank_relative = function(_, item)
                if not item then return end
                local path = vim.fn.fnamemodify(item.file, ":.")
                vim.fn.setreg(vim.v.register or "+", path)
                vim.notify("Yanked: " .. path)
              end,
            },
          },
        },
      },
    },
  },
}
