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
        enabled = false,
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
          },
        },
      },
    },
  },
  -- {
  --   "GCBallesteros/NotebookNavigator.nvim",
  --   keys = {
  --     {
  --       "]h",
  --       function()
  --         require("notebook-navigator").move_cell("d")
  --       end,
  --     },
  --     {
  --       "[h",
  --       function()
  --         require("notebook-navigator").move_cell("u")
  --       end,
  --     },
  --     { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
  --     { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
  --   },
  --   dependencies = {
  --     "nvim-mini/mini.comment",
  --     -- "hkupty/iron.nvim", -- repl provider
  --     -- "akinsho/toggleterm.nvim", -- alternative repl provider
  --     "benlubas/molten-nvim", -- alternative repl provider
  --     -- "anuvyklack/hydra.nvim",
  --   },
  --   event = "VeryLazy",
  --   config = function()
  --     local nn = require("notebook-navigator")
  --     nn.setup({
  --       cell_markers = {
  --         python = "#%%",
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "nvim-mini/mini.hipatterns",
  --   event = "VeryLazy",
  --   dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
  --   opts = function()
  --     local nn = require("notebook-navigator")
  --
  --     local opts = { highlighters = { cells = nn.minihipatterns_spec } }
  --     return opts
  --   end,
  -- },
  -- {
  --   "nvim-mini/mini.ai",
  --   event = "VeryLazy",
  --   dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
  --   opts = function()
  --     local nn = require("notebook-navigator")
  --
  --     local opts = { custom_textobjects = { h = nn.miniai_spec } }
  --     return opts
  --   end,
  -- },
}
