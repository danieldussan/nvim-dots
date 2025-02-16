return {

  { "nvim-telescope/telescope.nvim", lazy = true }, -- Solo se carga cuando se necesita
  "linux-cultist/venv-selector.nvim",
  enabled = true,
  dependencies = { "nvim-telescope/telescope.nvim" }, -- Evita errores
  opts = {
    parents = 2, -- Número de niveles hacia arriba para buscar entornos virtuales
    name = "venv", -- Nombre del entorno virtual a buscar
  },
  event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
}
