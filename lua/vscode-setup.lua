local vscode = require 'vscode'

-- Enable hlsearch and system clipboard
vim.opt.hlsearch = true
vim.opt.clipboard = 'unnamedplus'

-- Debug: Test if config is loading
vim.notify 'VSCode Neovim config loaded!'

-- ============================================================================
-- NAVIGATION MAPPINGS
-- ============================================================================

-- Buffer navigation (Shift+H/L)
vim.keymap.set('n', '<S-h>', '<Cmd>lua require("vscode").call("workbench.action.previousEditor")<CR>', { silent = true })
vim.keymap.set('n', '<S-l>', '<Cmd>lua require("vscode").call("workbench.action.nextEditor")<CR>', { silent = true })

-- Window splits
vim.keymap.set('n', '<leader>v', '<Cmd>lua require("vscode").call("workbench.action.splitEditorRight")<CR>', { silent = true })
vim.keymap.set('n', '<leader>s', '<Cmd>lua require("vscode").call("workbench.action.splitEditorDown")<CR>', { silent = true })

-- ============================================================================
-- FILE OPERATIONS
-- ============================================================================

vim.keymap.set('n', '<leader>w', '<Cmd>lua require("vscode").call("workbench.action.files.save")<CR>', { silent = true })
vim.keymap.set('n', '<leader>q', '<Cmd>lua require("vscode").call("workbench.action.closeActiveEditor")<CR>', { silent = true })
vim.keymap.set('n', '<leader>Q', '<Cmd>lua require("vscode").call("workbench.action.closeOtherEditors")<CR>', { silent = true })

-- ============================================================================
-- DIAGNOSTICS & CODE ACTIONS
-- ============================================================================

vim.keymap.set('n', '[d', '<Cmd>lua require("vscode").call("editor.action.marker.prev")<CR>', { silent = true })
vim.keymap.set('n', ']d', '<Cmd>lua require("vscode").call("editor.action.marker.next")<CR>', { silent = true })
vim.keymap.set('n', '<leader>ca', '<Cmd>lua require("vscode").call("editor.action.quickFix")<CR>', { silent = true })

-- ============================================================================
-- SEARCH & FILE FINDING
-- ============================================================================

vim.keymap.set('n', '<leader>sf', '<Cmd>lua require("vscode").call("workbench.action.quickOpen")<CR>', { silent = true })
vim.keymap.set('n', '<leader>sg', '<Cmd>lua require("vscode").call("workbench.action.findInFiles")<CR>', { silent = true })

-- ============================================================================
-- FORMATTING
-- ============================================================================

vim.keymap.set('n', '<leader>p', '<Cmd>lua require("vscode").call("editor.action.formatDocument")<CR>', { silent = true })

-- ============================================================================
-- GOTO DEFINITIONS
-- ============================================================================

vim.keymap.set('n', 'gD', '<Cmd>lua require("vscode").call("editor.action.goToTypeDefinition")<CR>', { silent = true })

-- Hover with focus on popup
vim.keymap.set('n', 'gh', '<Cmd>lua require("vscode").call("editor.action.showDefinitionPreviewHover")<CR>', { silent = true })

-- ============================================================================
-- VISUAL MODE MAPPINGS
-- ============================================================================

-- Stay in visual mode while indenting
vim.keymap.set('v', '<', '<Cmd>lua require("vscode").call("editor.action.outdentLines")<CR>', { silent = true })
vim.keymap.set('v', '>', '<Cmd>lua require("vscode").call("editor.action.indentLines")<CR>', { silent = true })
vim.keymap.set('n', '<leader>g', '<Cmd>lua require("vscode").call("lazygit.openLazygit")<CR>', { silent = true })

-- ============================================================================
-- ADDITIONAL USEFUL MAPPINGS
-- ============================================================================

-- Clear search highlight
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>', { silent = true })

-- Keep cursor centered when scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })

-- Keep search terms in center
vim.keymap.set('n', 'n', 'nzzzv', { silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { silent = true })
