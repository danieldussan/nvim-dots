local prompts = require("lib.code-companion-prompts")

return {
  "olimorris/codecompanion.nvim",
  event = "BufReadPre",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  init = function()
    vim.cmd([[cab cc CodeCompanion]])
    require("lib.codecompanion-notifier"):init()

    local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "CodeCompanionInlineFinished",
      group = group,
      callback = function(request)
        vim.lsp.buf.format({ bufnr = request.buf })
      end,
    })
  end,
  opts = {
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "claude-3.7-sonnet",
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = "copilot",
        roles = {
          ---The header name for the LLM's messages
          ---@type string|fun(adapter: CodeCompanion.Adapter): string
          llm = function(adapter)
            return "AI (" .. adapter.formatted_name .. ")"
          end,

          ---The header name for your messages
          ---@type string
          user = "Daniel",
        },
        tools = {
          groups = {
            ["Daniel"] = {
              description = "Frontend expert (React, Next.js, Astro)",
              system_prompt = prompts.DANIEL_SYSTEM_PROMPT,
              tools = {
                "cmd_runner",
                "editor",
                "files",
                "mcp",
              },
            },
          },
          ["mcp"] = {
            -- Prevent mcphub from loading before needed
            callback = function()
              return require("mcphub.extensions.codecompanion")
            end,
            description = "Call tools and resources from the MCP Servers",
          },
        },
        slash_commands = {
          ["git_files"] = {
            description = "List git files",
            ---@param chat CodeCompanion.Chat
            callback = function(chat)
              local handle = io.popen("git ls-files")
              if handle ~= nil then
                local result = handle:read("*a")
                handle:close()
                chat:add_reference({ role = "user", content = result }, "git", "<git_files>")
              else
                return vim.notify("No git files available", vim.log.levels.INFO, { title = "CodeCompanion" })
              end
            end,
            opts = {
              contains_code = false,
            },
          },
          ["buffer"] = {
            callback = "strategies.chat.slash_commands.buffer",
            description = "Insert open buffers",
            opts = {
              contains_code = true,
              provider = "default", -- default|telescope|mini_pick|fzf_lua
            },
          },
          ["file"] = {
            callback = "strategies.chat.slash_commands.file",
            description = "Insert a file",
            opts = {
              contains_code = true,
              max_lines = 1000,
              provider = "default", -- telescope|mini_pick|fzf_lua
            },
          },
        },
        inline = { adapter = "copilot" },
        agent = { adapter = "copilot" },
      },
      inline = {
        adapter = "copilot",
        keymaps = {
          accept_change = {
            modes = { n = "ga" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "gr" },
            description = "Reject the suggested change",
          },
        },
      },
      agent = { adapter = "copilot" },
    },
    default_adapter = "copilot",
    opts = {
      log_level = "DEBUG",
      system_prompt = prompts.SYSTEM_PROMPT,
    },
    display = {
      chat = {
        window = {
          width = 0.35,
        },
      },
    },
    prompt_library = {
      -- Custom the default prompt
      ["Generate a Commit Message"] = {
        prompts = {
          {
            role = "user",
            content = function()
              local branch_name = vim.fn.system("git branch --show-current"):gsub("%s+", "")
              return "Write commit message with commitizen convention. Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'."
                .. "\n\nBranch: "
                .. branch_name
                .. "\n\n```\n"
                .. vim.fn.system("git diff")
                .. "\n```"
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
      ["Explain"] = {
        strategy = "chat",
        description = "Explain how code in a buffer works",
        opts = {
          default_prompt = true,
          modes = { "v" },
          short_name = "explain",
          auto_submit = true,
          user_prompt = false,
          stop_context_insertion = true,
        },
        prompts = {
          {
            role = "system",
            content = prompts.COPILOT_EXPLAIN,
            opts = {
              visible = false,
            },
          },
          {
            role = "user",
            content = function(context)
              local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

              return "Please explain how the following code works:\n\n```"
                .. context.filetype
                .. "\n"
                .. code
                .. "\n```\n\n"
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
      ["Explain Code"] = {
        strategy = "chat",
        description = "Explain how code works",
        opts = {
          short_name = "explain-code",
          auto_submit = false,
          is_slash_cmd = true,
        },
        prompts = {
          {
            role = "system",
            content = prompts.COPILOT_EXPLAIN,
            opts = {
              visible = false,
            },
          },
          {
            role = "user",
            content = [[Please explain how the following code works.]],
          },
        },
      },
      -- Add custom prompts
      ["Generate a Commit Message for Staged"] = {
        strategy = "chat",
        description = "Generate a commit message for staged change",
        opts = {
          short_name = "staged-commit",
          auto_submit = true,
          is_slash_cmd = true,
        },
        prompts = {
          {
            role = "user",
            content = function()
              local branch_name = vim.fn.system("git branch --show-current"):gsub("%s+", "")
              return "Write commit message for the change with commitizen convention. Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'."
                .. "\n\nBranch: "
                .. branch_name
                .. "\n\n```\n"
                .. vim.fn.system("git diff --staged")
                .. "\n```"
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
      ["Inline Document"] = {
        strategy = "inline",
        description = "Add documentation for code.",
        opts = {
          modes = { "v" },
          short_name = "inline-doc",
          auto_submit = true,
          user_prompt = false,
          stop_context_insertion = true,
        },
        prompts = {
          {
            role = "user",
            content = function(context)
              local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

              return "Please provide documentation in comment code for the following code and suggest to have better naming to improve readability.\n\n```"
                .. context.filetype
                .. "\n"
                .. code
                .. "\n```\n\n"
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
      ["Document"] = {
        strategy = "chat",
        description = "Write documentation for code.",
        opts = {
          modes = { "v" },
          short_name = "doc",
          auto_submit = true,
          user_prompt = false,
          stop_context_insertion = true,
        },
        prompts = {
          {
            role = "user",
            content = function(context)
              local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

              return "Please brief how it works and provide documentation in comment code for the following code. Also suggest to have better naming to improve readability.\n\n```"
                .. context.filetype
                .. "\n"
                .. code
                .. "\n```\n\n"
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
      ["Review"] = {
        strategy = "chat",
        description = "Review the provided code snippet.",
        opts = {
          modes = { "v" },
          short_name = "review",
          auto_submit = true,
          user_prompt = false,
          stop_context_insertion = true,
        },
        prompts = {
          {
            role = "system",
            content = prompts.COPILOT_REVIEW,
            opts = {
              visible = false,
            },
          },
          {
            role = "user",
            content = function(context)
              local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

              return "Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability:\n\n```"
                .. context.filetype
                .. "\n"
                .. code
                .. "\n```\n\n"
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
      ["Review Code"] = {
        strategy = "chat",
        description = "Review code and provide suggestions for improvement.",
        opts = {
          short_name = "review-code",
          auto_submit = false,
          is_slash_cmd = true,
        },
        prompts = {
          {
            role = "system",
            content = prompts.COPILOT_REVIEW,
            opts = {
              visible = false,
            },
          },
          {
            role = "user",
            content = "Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability.",
          },
        },
      },
      ["Refactor"] = {
        strategy = "inline",
        description = "Refactor the provided code snippet.",
        opts = {
          modes = { "v" },
          short_name = "refactor",
          auto_submit = true,
          user_prompt = false,
          stop_context_insertion = true,
        },
        prompts = {
          {
            role = "system",
            content = prompts.COPILOT_REFACTOR,
            opts = {
              visible = false,
            },
          },
          {
            role = "user",
            content = function(context)
              local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

              return "Please refactor the following code to improve its clarity and readability:\n\n```"
                .. context.filetype
                .. "\n"
                .. code
                .. "\n```\n\n"
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
      ["Refactor Code"] = {
        strategy = "chat",
        description = "Refactor the provided code snippet.",
        opts = {
          short_name = "refactor-code",
          auto_submit = false,
          is_slash_cmd = true,
        },
        prompts = {
          {
            role = "system",
            content = prompts.COPILOT_REFACTOR,
            opts = {
              visible = false,
            },
          },
          {
            role = "user",
            content = "Please refactor the following code to improve its clarity and readability.",
          },
        },
      },
      ["Naming"] = {
        strategy = "inline",
        description = "Give betting naming for the provided code snippet.",
        opts = {
          modes = { "v" },
          short_name = "naming",
          auto_submit = true,
          user_prompt = false,
          stop_context_insertion = true,
        },
        prompts = {
          {
            role = "user",
            content = function(context)
              local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

              return "Please provide better names for the following variables and functions:\n\n```"
                .. context.filetype
                .. "\n"
                .. code
                .. "\n```\n\n"
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
      ["Better Naming"] = {
        strategy = "chat",
        description = "Give betting naming for the provided code snippet.",
        opts = {
          short_name = "better-naming",
          auto_submit = false,
          is_slash_cmd = true,
        },
        prompts = {
          {
            role = "user",
            content = "Please provide better names for the following variables and functions.",
          },
        },
      },
    },
  },
}
