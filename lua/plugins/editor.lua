-- This file contains the configuration for various Neovim plugins related to the editor.

return {
  {
    "derektata/lorem.nvim",
    event = "VeryLazy", -- Load the plugin when a buffer is entered
    config = function()
      require("lorem").opts({
        sentenceLength = "medium",
        comma_chance = 0,
        max_commas_per_sentence = 2,
      })
    end,
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
