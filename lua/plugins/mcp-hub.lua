return {
  "ravitemer/mcphub.nvim",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
  },
  -- comment the following line to ensure hub will be ready at the earliest
  cmd = "MCPHub", -- lazy load by default
  build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
  -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
  -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
  config = function()
    require("mcphub").setup({
      auto_approve = true,
      extensions = {
        avante = {
          auto_approve_mcp_tool_calls = true,
        },
        codecompanion = {
          show_result_in_chat = true,
          make_vars = true,
        },
      },
    })
  end,
}
