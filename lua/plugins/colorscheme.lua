local colors = {
  color1 = "#5b4996",
  color2 = "#0D1116",
  color3 = "#F712FF",
  color4 = "#030f15",
}
return {
  {
    -- Plugin for enabling transparency
    "xiyaowong/transparent.nvim",
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    -- priority = 1000,
    opts = {
      style = "night",
    },
  },
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "deep",
      transparent = true,
      term_colors = true,
      ending_tildes = false,
      cmp_itemkind_reverse = false,

      -- Options are italic, bold, underline, none and combos 'italic,bold'
      code_style = {
        comments = "italic",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none",
      },

      lualine = { transparent = true },
      diagnostics = { darker = true, undercurl = true, background = false },
      colors = {},
      highlights = {
        ["NormalFloat"] = { bg = colors["color4"] },
        ["FloatBorder"] = { bg = colors["color2"], fg = colors["color1"] },
        ["FloatTitle"] = { bg = colors["color2"], fg = colors["color3"] },
        ["TroubleNormal"] = { bg = colors["color2"] },
      },
    },
  },
  {
    -- LazyVim configuration
    "LazyVim/LazyVim",
    opts = {
      -- Set the default color scheme
      colorscheme = "onedark",
    },
  },
}
