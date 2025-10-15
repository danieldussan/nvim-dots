return {
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   event = "BufReadPost",
  --   config = function()
  --     require("supermaven-nvim").setup({
  --       opts = {
  --         keymap = {
  --           accept = "<TAB>",
  --           accept_word = false,
  --           accept_line = false,
  --           next = "<M-]>",
  --           prev = "<M-[>",
  --           dismiss = "<C-c>",
  --         },
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "BufReadPost",
  --   opts = {
  --     suggestion = {
  --       enabled = true,
  --       auto_trigger = true,
  --       hide_during_completion = true,
  --       debounce = 10,
  --       trigger_on_accept = true,
  --       keymap = {
  --         accept = "<TAB>",
  --         accept_word = false,
  --         accept_line = false,
  --         next = "<M-]>",
  --         prev = "<M-[>",
  --         dismiss = "<C-c>",
  --       },
  --     },
  --   },
  -- },
  {
    "folke/sidekick.nvim",
    event = "BufReadPost",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if require("sidekick").nes_jump_or_apply() then
            return -- jumped or applied
          end

          -- if you are using Neovim's native inline completions
          if vim.lsp.inline_completion.get() then
            return
          end

          -- any other things (like snippets) you want to do on <tab> go here.

          -- fall back to normal tab
          return "<tab>"
        end,
        mode = { "i", "n" },
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<leader>za",
        function()
          require("sidekick.cli").select({ filter = { installed = true } })
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>zs",
        function()
          require("sidekick.cli").select()
        end,
        desc = "Select CLI",
      },
      {
        "<leader>zd",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>zt",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>zf",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      {
        "<leader>zv",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>zp",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      -- Example of a keybinding to open Claude directly
      {
        "<leader>zo",
        function()
          require("sidekick.cli").toggle({ name = "opencode", focus = true })
        end,
        desc = "Sidekick Toggle OpenCode",
      },
    },
  },
}
