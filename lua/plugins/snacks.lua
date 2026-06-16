return {
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
                        auto_close = true,
                        hidden = true,
                        ignored = true,
                        git_status = false,
                        win = {
                            list = {
                                keys = {
                                    ["Y"] = "yank_relative",
                                },
                            },
                        },
                        actions = {
                            yank_relative = function(_, item)
                                if not item then
                                    return
                                end
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
