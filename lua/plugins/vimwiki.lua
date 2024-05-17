
return {
  'vimwiki/vimwiki',
  event = "BufEnter *.md",
  keys = {"<leader>ww", "<leader>wt"},
  enabled = true,
  init = function () --replace 'config' with 'init'
    vim.g.vimwiki_list = {
      {
        path = '~/code/tech-notes/wiki', 
        syntax = 'markdown', 
        ext = '.md'
      },
      { 
        path = '~/vimwiki',
        syntax = 'markdown',
        ext = '.md',
      }
    }
    vim.g.vimwiki_listsyms = " ◔◑◕✓"
    -- vim.api.nvim_set_keymap('n', '<C-]>', '<Plug>VimwikiNextLink', {silent=true})
    -- vim.api.nvim_set_keymap('n', '<C-[>', '<Plug>VimwikiPrevLink', {silent=true})
    vim.api.nvim_set_keymap('n', '<S-Tab>', '<Plug>VimwikiDecreaseLvlWholeItem', {silent=true})
    vim.api.nvim_set_keymap('n', '<Tab>', '<Plug>VimwikiIncreaseLvlWholeItem', {silent=true})
    vim.api.nvim_set_keymap('n', '<Leader>w2', ':VimwikiDiaryIndex 2<CR>:VimwikiMakeDiaryNote<CR>', { noremap = true, silent = true })
  end,
}
