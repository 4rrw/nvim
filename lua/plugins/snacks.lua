return {
    {
        "folke/snacks.nvim",
        opts = {
            -- Render images and LaTeX math inline in markdown buffers (same
            -- renderer the picker preview already uses). Needs a kitty-graphics
            -- terminal (ghostty ✓) plus magick + a LaTeX engine for math.
            image = { enabled = true },
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
                    files = {
                        -- Show .env files even though they're hidden/gitignored.
                        -- `include` takes precedence over exclude/ignored/hidden.
                        include = { ".env", ".env.*" },
                    },
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
