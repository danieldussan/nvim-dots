return {
  "aznhe21/actions-preview.nvim",
  keys = {
    {
      "gf",
      function()
        require("actions-preview").code_actions()
      end,
      mode = { "v", "n" },
      desc = "Code Actions",
    },
  },
  config = function()
    require("actions-preview").setup({
      diff = {
        ctxlen = 3,
      },

      highlight_command = {
        -- require("actions-preview.highlight").delta(),
        require("actions-preview.highlight").diff_so_fancy(),
        -- require("actions-preview.highlight").diff_highlight(),
      },

      backend = { "nui" },

      nui = {
        -- component direction. "col" or "row"
        dir = "col",
        -- keymap for selection component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu#keymap
        keymap = nil,
        -- options for nui Layout component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/layout
        layout = {
          position = "50%",
          size = {
            width = "50%",
            height = "60%",
          },
          min_width = 40,
          min_height = 10,
          relative = "editor",
        },
        -- options for preview area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
        preview = {
          size = "60%",
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
        },
        -- options for selection area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu
        select = {
          size = "40%",
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
        },
      },
    })
  end,
}
