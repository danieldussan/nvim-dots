local colors = {
  linkarzu_color18 = "#5b4996",
  linkarzu_color19 = "#21925b",
  linkarzu_color20 = "#027d95",
  linkarzu_color21 = "#585c89",
  linkarzu_color22 = "#0f857c",
  linkarzu_color23 = "#396592",
  linkarzu_color04 = "#987afb",
  linkarzu_color02 = "#37f499",
  linkarzu_color03 = "#04d1f9",
  linkarzu_color01 = "#949ae5",
  linkarzu_color05 = "#19dfcf",
  linkarzu_color08 = "#5fa9f4",
  linkarzu_color06 = "#1682ef",
  linkarzu_color07 = "#1c242f",
  linkarzu_color09 = "#a5afc2",
  linkarzu_color10 = "#0D1116",
  linkarzu_color11 = "#f16c75",
  linkarzu_color12 = "#f1fc79",
  linkarzu_color13 = "#314154",
  linkarzu_color14 = "#ebfafa",
  linkarzu_color15 = "#013e4a",
  linkarzu_color16 = "#e9b3fd",
  linkarzu_color17 = "#141b22",
  linkarzu_color24 = "#F712FF",
  linkarzu_color25 = "#232e3b",
}
return {
  {
    -- Plugin for enabling transparency
    "xiyaowong/transparent.nvim",
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
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
        ["NormalFloat"] = { bg = colors["linkarzu_color10"] },
        ["FloatBorder"] = { bg = colors["linkarzu_color10"], fg = colors["linkarzu_color18"] },
        ["FloatTitle"] = { bg = colors["linkarzu_color10"], fg = colors["linkarzu_color24"] },
        ["TroubleNormal"] = { bg = colors["linkarzu_color10"] },
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
