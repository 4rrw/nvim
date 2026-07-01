return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*", -- use latest release
        ft = "markdown",
        cmd = "Obsidian",
        -- stylua: ignore
        keys = {
            { "<leader>o", "", desc = "+obsidian", ft = "markdown" },
            { "<leader>oo", "<cmd>Obsidian open<cr>", desc = "Open in Obsidian app" },
            { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New note" },
            { "<leader>oN", "<cmd>Obsidian new_from_template<cr>", desc = "New note from template" },
            { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Quick switch note" },
            { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search notes" },
            { "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Search tags" },
            { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
            { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Links in buffer" },
            { "<leader>oc", "<cmd>Obsidian toc<cr>", desc = "Table of contents" },
            { "<leader>od", "<cmd>Obsidian today<cr>", desc = "Today's daily note" },
            { "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Yesterday's daily note" },
            { "<leader>om", "<cmd>Obsidian dailies<cr>", desc = "List daily notes" },
            { "<leader>oT", "<cmd>Obsidian template<cr>", desc = "Insert template" },
            { "<leader>op", "<cmd>Obsidian paste_img<cr>", desc = "Paste image" },
            { "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Rename note" },
            { "<leader>ox", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle checkbox" },
            { "<leader>ow", "<cmd>Obsidian workspace<cr>", desc = "Switch workspace" },
            { "<leader>oe", "<cmd>Obsidian extract_note<cr>", mode = "v", desc = "Extract selection to note" },
            { "<leader>oL", "<cmd>Obsidian link<cr>", mode = "v", desc = "Link selection to note" },
        },
        ---@module 'obsidian'
        ---@type obsidian.config
        opts = {
            legacy_commands = false, -- only the `:Obsidian <subcommand>` form
            workspaces = {
                {
                    name = "personal",
                    path = "~/ObsidianVault/",
                },
            },
            notes_subdir = "Inbox", -- new notes land in ~/ObsidianVault/INBOX/
            new_notes_location = "notes_subdir", -- always use notes_subdir, not current dir
            templates = {
                folder = "Templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
                customizations = {
                    knowledge = { notes_subdir = "Knowledge" },
                    -- add later as you want them:
                    -- project  = { notes_subdir = "Projects" },
                },
            },
            daily_notes = {
                folder = "Journal",
                date_format = "%Y-%m-%d",
                template = "daily.md", -- ← the "what I did today" structure
            },
            picker = {
                name = "snacks.picker",
            },
            completion = {
                min_chars = 2,
            },
            ui = { enable = false },
        },
    },
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            spec = {
                { "<leader>o", group = "obsidian", icon = { icon = "", color = "purple" } },
            },
        },
    },
}
