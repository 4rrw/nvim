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
                            -- allow an optional space before the markers (e.g. both `# %%` and `#%%`)
                            regex_cell_marker = string.gsub(regex_cell_marker, " ", " *")
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
}
