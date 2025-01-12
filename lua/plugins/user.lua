-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
      "goolord/alpha-nvim",
      opts = function(_, opts) -- override the options using lazy.nvim
        opts.section.header.val = { -- change the header section value
        " █     █░███▄    █   ██████ ",
        "▓█░ █ ░█░██ ▀█   █ ▒██    ▒ ",
        "▒█░ █ ░█▓██  ▀█ ██▒░ ▓██▄   ",
        "░█░ █ ░█▓██▒  ▐▌██▒  ▒   ██▒",
        "░░██▒██▓▒██░   ▓██░▒██████▒▒",
        "░ ▓░▒ ▒ ░ ▒░   ▒ ▒ ▒ ▒▓▒ ▒ ░",
        "  ▒ ░ ░ ░ ░░   ░ ▒░░ ░▒  ░ ░",
        "  ░   ░    ░   ░ ░ ░  ░  ░  ",
        "    ░            ░       ░  ",
        "                            ",
        "        Code Hard           ",
        }
      end,
  },

  { -- Add in the mode text to the status line
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local status = require("astroui.status")
        opts.statusline = { -- statusline
          hl = { fg = "fg", bg = "bg" },
          status.component.mode { mode_text = { padding = { left = 1, right = 1 } } }, -- add the mode text
          status.component.git_branch(),
          status.component.file_info { filetype = {}, filename = false, file_modified = false },
          status.component.git_diff(),
          status.component.diagnostics(),
          status.component.fill(),
          status.component.cmd_info(),
          status.component.fill(),
          status.component.lsp(),
          status.component.treesitter(),
          status.component.nav(),
          -- remove the 2nd mode indicator on the right
        }

        -- return the final configuration table
        return opts
      end,
    },
    {
      "chaoren/vim-wordmotion",
      lazy = false,
      enabled = true,
    },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  { "Mofiqul/vscode.nvim", lazy = false, 
    opts = {
        disable_nvimtree_bg = false,
        color_overrides = {
          vscBack = '#0a0a0a',
          vscPopupBack = '#141414',
          vscSelection = '#163F68',
          vscDimHighlight = '#21201F'
        }
      }
  },
  { "projekt0n/github-nvim-theme", lazy = false, },
  { "cocopon/iceberg.vim", lazy = false, },
  { "folke/tokyonight.nvim", lazy = false, },
  { "rebelot/kanagawa.nvim", lazy = false, },
  { "sainnhe/sonokai", lazy = false,
    init = function() vim.g.sonokai_dim_inactive_windows = 1 end,
  },
  { "nyoom-engineering/oxocarbon.nvim", lazy = false, },
}
