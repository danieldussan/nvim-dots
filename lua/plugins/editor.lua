-- This file contains the configuration for various Neovim plugins related to the editor.

return {
  {
    -- Plugin: emmet-vim
    -- URL: https://github.com/mattn/emmet-vim
    -- Description: Provides support for expanding Emmet abbreviations in Vim.
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "javascriptreact", "typescriptreact", "astro" },
    -- config = function()
    --   vim.keymap.set("i", "<C-,>", "<Plug>(emmet-expand-abbr)", { noremap = false, silent = true })
    --   vim.keymap.set("n", "<C-,>", "i<Plug>(emmet-expand-abbr)", { noremap = false, silent = true })
    -- end,
    keys = {
      {
        "<C-,>",
        "<Plug>(emmet-expand-abbr)",
        mode = { "i" },
        desc = "Expand Emmet abbreviation",
      },
      {
        "<C-,>",
        "i<Plug>(emmet-expand-abbr)",
        mode = { "n" },
        desc = "Expand Emmet abbreviation",
      },
    },
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    event = "BufReadPre",
    lazy = true,
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    -- Plugin: goto-preview
    -- URL: https://github.com/rmagatti/goto-preview
    -- Description: Provides preview functionality for definitions, declarations, implementations, type definitions, and references.
    "rmagatti/goto-preview",
    event = "VeryLazy", -- Load the plugin when a buffer is entered
    config = true, -- Enable default configuration
    keys = {
      {
        "gpd",
        "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
        noremap = true, -- Do not allow remapping
        desc = "goto preview definition", -- Description for the keybinding
      },
      {
        "gpD",
        "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
        noremap = true,
        desc = "goto preview declaration",
      },
      {
        "gpi",
        "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
        noremap = true,
        desc = "goto preview implementation",
      },
      {
        "gpy",
        "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
        noremap = true,
        desc = "goto preview type definition",
      },
      {
        "gpr",
        "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
        noremap = true,
        desc = "goto preview references",
      },
      {
        "gP",
        "<cmd>lua require('goto-preview').close_all_win()<CR>",
        noremap = true,
        desc = "close all preview windows",
      },
    },
  },
  {
    -- Plugin: mini.hipatterns
    -- URL: https://github.com/echasnovski/mini.hipatterns
    -- Description: Provides highlighter patterns for various text patterns.
    "echasnovski/mini.hipatterns",
    event = "BufReadPre", -- Load the plugin before reading a buffer
    opts = {
      tailwind = {
        enabled = true,
        ft = {
          "astro",
          "css",
          "heex",
          "html",
          "html-eex",
          "javascript",
          "javascriptreact",
          "rust",
          "svelte",
          "typescript",
          "typescriptreact",
          "vue",
        },
        -- full: the whole css class will be highlighted
        -- compact: only the color will be highlighted
        style = "full",
      },
      highlighters = {
        hsl_color = {
          pattern = "hsl%(%d+,? %d+,? %d+%)", -- Pattern to match HSL color values
          group = function(_, match)
            local utils = require("config.gentleman.utils")
            local h, s, l = match:match("hsl%((%d+),? (%d+),? (%d+)%)")
            h, s, l = tonumber(h), tonumber(s), tonumber(l)
            local hex_color = utils.hslToHex(h, s, l)
            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
        },
      },
    },
  },
  {
    "https://github.com/lambdalisue/vim-suda",
  },
}
