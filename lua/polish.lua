-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

-- Keymappings for moving lines up/down
vim.api.nvim_set_keymap('i', '<M-k>', '<Esc>:m .-2<CR>gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<M-j>', '<Esc>:m .+1<CR>gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-k>', '<Esc>:m .-2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-j>', '<Esc>:m .+1<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', '<M-k>', "<Esc>:lua MoveBlockUp()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<M-j>', "<Esc>:lua MoveBlockDown()<CR>", { noremap = true, silent = true })

local function move_block_up()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    if start_line == 1 then return end
    vim.cmd("silent! normal! " .. (start_line-1) .. "Gdd")
    vim.cmd("silent! normal! " .. (end_line-1) .. "Gp")
    vim.cmd("silent! normal! " .. (start_line-1) .. "GV" .. (end_line-1) .. "G")
end

local function move_block_down()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    if end_line == vim.fn.line("$") then return end
    vim.cmd("silent! normal! " .. (end_line+1) .. "Gdd")
    vim.cmd("silent! normal! " .. start_line-1 .. "Gp")
    vim.cmd("silent! normal! " .. (start_line+1) .. "GV" .. (end_line+1) .. "G")
end

_G.MoveBlockUp = move_block_up
_G.MoveBlockDown = move_block_down

-- Duplicate lines keymappings
vim.api.nvim_set_keymap('i', '<M-S-k>', '<Esc>:t .-1<CR>gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<M-S-j>', '<Esc>:t .<CR>gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-S-k>', '<Esc>:t .-1<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-S-j>', '<Esc>:t .<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', '<M-S-k>', "<Esc>:lua CopyBlockUp()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<M-S-j>', "<Esc>:lua CopyBlockDown()<CR>", { noremap = true, silent = true })

local function copy_block_up()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local lines_to_duplicate = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    vim.api.nvim_buf_set_lines(0, end_line, end_line, false, lines_to_duplicate)
    local new_end_line = end_line + (end_line-start_line) + 1
    vim.cmd("silent! normal! " .. end_line+1 .. "GV" .. new_end_line .. "G")
end

local function copy_block_down()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    local lines_to_duplicate = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    vim.api.nvim_buf_set_lines(0, end_line, end_line, false, lines_to_duplicate)
    vim.cmd("silent! normal! " .. start_line .. "GV" .. end_line .. "G")

end

_G.CopyBlockUp = copy_block_up
_G.CopyBlockDown = copy_block_down

-- Function to move buffer to next window
function MoveBufferToLeftWindow()
  -- Save the current buffer number
  local bufnr = vim.api.nvim_get_current_buf()

  -- Move to the right window
  vim.api.nvim_command('wincmd h')

  -- If successful, open the buffer in this window and create a new one in the original window
  if vim.api.nvim_get_current_buf() ~= bufnr then
    vim.api.nvim_command('buffer ' .. bufnr)

    -- Move back to the original window
    vim.api.nvim_command('wincmd l')
  end
end

-- Function to move buffer to next window
function MoveBufferToRightWindow()
  -- Save the current buffer number
  local bufnr = vim.api.nvim_get_current_buf()

  -- Move to the right window
  vim.api.nvim_command('wincmd l')

  -- If successful, open the buffer in this window and create a new one in the original window
  if vim.api.nvim_get_current_buf() ~= bufnr then
    vim.api.nvim_command('buffer ' .. bufnr)

    -- Move back to the original window
    vim.api.nvim_command('wincmd h')
  end
end

-- Create a command to call the function
_G.MoveCurrBufferToLeft = MoveBufferToLeftWindow
_G.MoveCurrBufferToRight = MoveBufferToRightWindow

vim.api.nvim_set_keymap('n', '<M-S-h>', "<Esc>:lua MoveCurrBufferToLeft()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<M-S-h>', "<Esc>:lua MoveCurrBufferToLeft()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-S-l>', "<Esc>:lua MoveCurrBufferToRight()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<M-S-l>', "<Esc>:lua MoveCurrBufferToRight()<CR>", { noremap = true, silent = true })


-- Telescope find files
vim.api.nvim_set_keymap('n', '<C-p>', "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-p>', "<Esc><cmd>Telescope find_files<cr><gi>", { noremap = true, silent = true })

-- Telescope find buffer mappings
vim.api.nvim_set_keymap('n', '<C-b>', "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-b>', "<Esc><cmd>Telescope buffers<cr><gi>", { noremap = true, silent = true })


-- Switch to the buffers using Ctrl+(Shift+)Tab
vim.api.nvim_set_keymap('n', '<C-Tab>', ':lua require("astrocore.buffer").nav(1)<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-Tab>', '<Esc>:lua require("astrocore.buffer").nav(1)<CR>gi', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-S-Tab>', ':lua require("astrocore..buffer").nav(-1)<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-S-Tab>', '<Esc>:lua require("astrocore.buffer").nav(-1)<CR>gi', {noremap = true, silent = true})

-- Shift Tab should unindent in insert/normal mode.
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', {silent = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', '<C-d>', {silent = true})

vim.api.nvim_set_keymap('n', '<C-_>', ':VimwikiIncrementListItem<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Bslash>', ':VimwikiDecrementListItem<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('i', '<C-s>', '<C-o>:w<CR>', { noremap = true, silent = true })

-- Change visual mode paste to not copy the overwritten portion into the clipboard register
-- Instead delete the contents into the black hole register "_ and then paste.
vim.api.nvim_set_keymap('v', 'p', '"_dP', { noremap = true, silent = true })

-- Start visual selection on ctrl+shift+left/right
vim.api.nvim_set_keymap('i', '<C-S-Left>', '<Esc>vge', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-S-Right>', '<Esc>v<Space>w', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-S-Left>', 'vge', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-S-Right>', 'v<Space>w', {noremap = true})


-- Setup loading the DAP configuration from the local .vscode/launch.json on entering a directory
local function on_directory_change()
    -- print("Changed directory to: " .. vim.fn.getcwd())
    -- Tell nvim-dap to try loading dap configs from .vscode/launch.json
    require('dap.ext.vscode').load_launchjs(nil, {})
end

vim.api.nvim_create_autocmd("DirChanged", {
    pattern = "*",
    callback = on_directory_change,
})

-- Force normal mode so that double click doesn't select a file.
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'neo-tree*',
  callback = function()
    vim.cmd('stopinsert') -- Forces to normal mode
  end,
})

-- Enter the current directory when vim starts
-- % curr file, :p full path, :h get dir
local file_path = vim.fn.expand("%p")
local is_dir = vim.fn.isdirectory(file_path)
if is_dir == 1 then
  vim.api.nvim_create_autocmd("VimEnter", {pattern = "*", command = "silent! cd %:p"})
  vim.api.nvim_create_autocmd("VimEnter", {pattern = "*", command = "TermExec open=0 cmd='cd %:p && clear'"})
else
  vim.api.nvim_create_autocmd("VimEnter", {pattern = "*", command = "silent! cd %:p:h"})
  vim.api.nvim_create_autocmd("VimEnter", {pattern = "*", command = "TermExec open=0 cmd='cd %:p:h && clear'"})
end

-- Try to load the launch.json once init is done.
--vim.api.nvim_create_autocmd("VimEnter", {pattern = "*", callback = on_directory_change()})

vim.opt.list = true
vim.opt.listchars:append({space = "·", lead = "·", tab = "» ", trail = "·"}) --, trail = '·', setbreak = "···", space = '·' }
vim.opt.showbreak = "↪  "
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

-- Fix the expander background in NeoTree
local hl = vim.api.nvim_set_hl
local c = require('vscode.colors').get_colors

-- Function to apply your highlight changes
local function apply_highlight()
  local current_colorscheme = vim.g.colors_name
  if current_colorscheme == 'vscode' then
    local colors = c()
    hl(0, 'NeoTreeIndentMarker', { fg = colors.vscLineNumber, bg = 'NONE' })
  end
end

-- Apply the highlight on startup
apply_highlight()

-- Apply the highlight whenever the colorscheme changes
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
      apply_highlight()
  end,
})


local hl = vim.api.nvim_set_hl
local c = require('vscode.colors').get_colors()
local isDark = vim.o.background == 'dark'
hl(0, 'NeoTreeIndentMarker', { fg = c.vscLineNumber, bg = 'NONE' })

