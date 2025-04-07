-- Plugin: lualine.nvim
-- URL: https://github.com/nvim-lualine/lualine.nvim
-- Description: A blazing fast and easy to configure Neovim statusline plugin.

local function codecompanion_adapter_name()
  local chat = require("codecompanion").buf_get_chat(vim.api.nvim_get_current_buf())
  if not chat then
    return nil
  end

  return " " .. chat.adapter.formatted_name
end

local function codecompanion_current_model_name()
  local chat = require("codecompanion").buf_get_chat(vim.api.nvim_get_current_buf())
  if not chat then
    return nil
  end

  return chat.settings.model
end

return {
  {
    "nvim-lualine/lualine.nvim",
    event = { "VimEnter" },
    opts = {
      options = {
        theme = "onedark", -- Set the theme for lualine
        section_separators = "",
        component_separators = { left = "|", right = "|" },
        disabled_filetypes = {
          "alpha",
          "trouble",
        },
      },
      sections = {
        lualine_a = {
          "mode",
        },
        lualine_b = {
          "diff",
          "diagnostics",
        },
        lualine_c = {
          "filename",
          {
            function()
              local register = vim.fn.reg_recording()
              if #register > 0 then
                return "recording @" .. register
              else
                return ""
              end
            end,
            color = { fg = "#fabd2f", gui = "bold" }, -- TODO: don't directly rely on Gruvbox color here?
          },
        },
        lualine_x = {
          "filetype",
        },
        lualine_y = {
          "searchcount",
          "progress",
        },
        lualine_z = {
          "location",
        },
      },
      extensions = {
        "quickfix",
        {
          filetypes = { "oil" },
          sections = {
            lualine_a = {
              "mode",
            },
            lualine_b = {
              function()
                local ok, oil = pcall(require, "oil")
                if not ok then
                  return ""
                end

                ---@diagnostic disable-next-line: param-type-mismatch
                local path = vim.fn.fnamemodify(oil.get_current_dir(), ":~")
                return path .. " %m"
              end,
            },
          },
        },
        {
          filetypes = { "codecompanion" },
          sections = {
            lualine_a = {
              "mode",
            },
            lualine_b = {
              codecompanion_adapter_name,
            },
            lualine_c = {
              codecompanion_current_model_name,
            },
            lualine_x = {},
            lualine_y = {
              "progress",
            },
            lualine_z = {
              "location",
            },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {
              codecompanion_adapter_name,
            },
            lualine_c = {},
            lualine_x = {},
            lualine_y = {
              "progress",
            },
            lualine_z = {},
          },
        },
      },
    },
  },
}
