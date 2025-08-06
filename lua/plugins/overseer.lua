return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerOpen",
    "OverseerClose",
    "OverseerToggle",
    "OverseerSaveBundle",
    "OverseerLoadBundle",
    "OverseerDeleteBundle",
    "OverseerRunCmd",
    "OverseerRun",
    "OverseerInfo",
    "OverseerBuild",
    "OverseerQuickAction",
    "OverseerTaskAction",
    "OverseerClearCache",
  },
  opts = function(_, opts)
    opts.dap = false
    opts.components = {
      "open_output",
      direction = "vertical",
      focus = true,
    }
    opts.task_list = {
      bindings = {
        ["<C-h>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<C-l>"] = false,
      },
    }

    -- Registra tu template personalizado
    require("overseer").register_template({
      name = "Build & Run Maven Project",
      builder = function()
        return {
          cmd = { "bash" },
          args = { "-c", "mvn compile && mvn exec:java" },
          components = {
            { "open_output", direction = "vertical", focus = true },
            "default",
          },
        }
      end,
      condition = {
        dir = vim.fn.getcwd(),
        filetype = "java",
      },
    })

    require("overseer").register_template({
      name = "Build Maven Project",
      builder = function()
        return {
          cmd = { "bash" },
          args = { "-c", "mvn compile" },
          components = {
            { "open_output", direction = "vertical", focus = true },
            "default",
          },
        }
      end,
      condition = {
        dir = vim.fn.getcwd(),
        filetype = "java",
      },
    })

    require("overseer").register_template({
      name = "Run Maven Project",
      builder = function()
        return {
          cmd = { "bash" },
          args = { "-c", "mvn exec:java" },
          components = {
            { "open_output", direction = "vertical", focus = true },
            "default",
          },
        }
      end,
      condition = {
        dir = vim.fn.getcwd(),
        filetype = "java",
      },
    })

    require("overseer").register_template({
      name = "Python Script (venv)",
      builder = function()
        local file = vim.fn.expand("%:p")
        return {
          cmd = { "bash" },
          args = { "-c", "act && python3 " .. file },
          components = {
            { "open_output", direction = "vertical", focus = true },
            "default",
          },
        }
      end,
      condition = {
        dir = vim.fn.getcwd(),
        filetype = { "python", "py" },
      },
    })

    require("overseer").register_template({
      name = "Python Script",
      builder = function()
        local file = vim.fn.expand("%:p")
        return {
          cmd = { "bash" },
          args = { "-c", "python3 " .. file },
          components = {
            { "open_output", direction = "vertical", focus = true },
            "default",
          },
        }
      end,
      condition = {
        dir = vim.fn.getcwd(),
        filetype = { "python", "py" },
      },
    })

    return opts
  end,
}
