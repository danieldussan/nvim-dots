return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "gemini",
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              url = "https://generativelanguage.googleapis.com/v1beta/models/${model}:streamGenerateContent?alt=sse&key=${api_key}",
              env = {
                api_key = function()
                  return os.getenv("GEMINI_API_KEY_DSS1")
                end,
              },
              model = "gemini-2.0-flash-001",
            },
          })
        end,
      },
    },
    default_adapter = "gemini",
    opts = {
      log_level = "DEBUG",
    },
    display = {
      chat = {
        width = 20,
      },
    },
  },
}
