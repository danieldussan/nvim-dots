return {
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   config = function()
  --     require("supermaven-nvim").setup({})
  --   end,
  -- },
  {
    "zbirenbaum/copilot.lua",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 10,
        trigger_on_accept = true,
        keymap = {
          accept = "<TAB>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-c>",
        },
      },
    },
  },
}
