-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/blink-cmp.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/blink-cmp.lua

-- HACK: blink.cmp updates | Remove LuaSnip | Emoji and Dictionary Sources | Fix Jump Autosave Issue
-- https://youtu.be/JrgfpWap_Pg

-- completion plugin with support for LSPs and external sources that updates
-- on every keystroke with minimal overhead

-- https://www.lazyvim.org/extras/coding/blink
-- https://github.com/saghen/blink.cmp
-- Documentation site: https://cmp.saghen.dev/

-- NOTE: Specify the trigger character(s) used for luasnip
local trigger_text = ";"

return {
  {
    "saghen/blink.cmp",
    enabled = true,
    -- In case there are breaking changes and you want to go back to the last
    -- working release
    -- https://github.com/Saghen/blink.cmp/releases
    -- version = "v0.9.3",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
    },
    opts = function(_, opts)
      -- I noticed that telescope was extremeley slow and taking too long to open,
      -- assumed related to blink, so disabled blink and in fact it was related
      -- :lua print(vim.bo[0].filetype)
      -- So I'm disabling blink.cmp for Telescope
      opts.enabled = function()
        -- Get the current buffer's filetype
        local filetype = vim.bo[0].filetype
        -- Disable for Telescope buffers
        if filetype == "TelescopePrompt" or filetype == "minifiles" or filetype == "snacks_picker_input" then
          return false
        end
        return true
      end

      -- NOTE: The new way to enable LuaSnip
      -- Merge custom sources with the existing ones from lazyvim
      -- NOTE: by default lazyvim already includes the lazydev source, so not adding it here again
      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        default = { "lsp", "path", "snippets", "buffer", "avante" },
        providers = {
          lsp = {
            name = "lsp",
            enabled = true,
            module = "blink.cmp.sources.lsp",
            kind = "LSP",
            -- When linking markdown notes, I would get snippets and text in the
            -- suggestions, I want those to show only if there are no LSP
            -- suggestions
            --
            -- Enabled fallbacks as this seems to be working now
            -- Disabling fallbacks as my snippets wouldn't show up when editing
            -- lua files
            -- fallbacks = { "snippets", "buffer" },
            score_offset = 90, -- the higher the number, the higher the priority
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 25,
            -- When typing a path, I would get snippets and text in the
            -- suggestions, I want those to show only if there are no path
            -- suggestions
            fallbacks = { "snippets", "buffer" },
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
              end,
              show_hidden_files_by_default = true,
            },
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 25,
          },
          buffer = {
            name = "Buffer",
            enabled = true,
            max_items = 3,
            module = "blink.cmp.sources.buffer",
            min_keyword_length = 2,
            score_offset = 15, -- the higher the number, the higher the priority
          },
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- options for blink-cmp-avante
            },
          },
          snippets = {
            name = "snippets",
            enabled = true,
            max_items = 6,
            min_keyword_length = 1,
            module = "blink.cmp.sources.snippets",
            score_offset = 1000, -- the higher the number, the higher the priority
            -- Only show snippets if I type the trigger_text characters, so
            -- to expand the "bash" snippet, if the trigger_text is ";" I have to
            should_show_items = function()
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
              -- NOTE: remember that `trigger_text` is modified at the top of the file
              return before_cursor:match(trigger_text .. "%w*$") ~= nil
            end,
            -- After accepting the completion, delete the trigger_text characters
            -- from the final inserted text
            transform_items = function(_, items)
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
              local trigger_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
              if trigger_pos then
                for _, item in ipairs(items) do
                  item.textEdit = {
                    newText = item.insertText or item.label,
                    range = {
                      start = { line = vim.fn.line(".") - 1, character = trigger_pos - 1 },
                      ["end"] = { line = vim.fn.line(".") - 1, character = col },
                    },
                  }
                end
              end
              -- NOTE: After the transformation, I have to reload the luasnip source
              -- Otherwise really crazy shit happens and I spent way too much time
              -- figurig this out
              vim.schedule(function()
                require("blink.cmp").reload("snippets")
              end)
              return items
            end,
          },
        },
      })
      opts.cmdline = {
        completion = {
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
          menu = {
            auto_show = true,
          },
        },
        keymap = {
          ["<CR>"] = { "accept_and_enter", "fallback" },
          ["<TAB>"] = { "accept", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<C-c>"] = { "hide", "fallback" },
        },
        sources = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          -- Commands
          if type == ":" or type == "@" then
            return { "cmdline" }
          end
          return {}
        end,
      }
      opts.completion = {
        --   keyword = {
        --     -- 'prefix' will fuzzy match on the text before the cursor
        --     -- 'full' will fuzzy match on the text before *and* after the cursor
        --     -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        --     range = "full",
        --   },
        menu = {
          border = "rounded",
          draw = {
            columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind", gap = 1 } },
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          window = {
            border = "rounded",
          },
        },
        -- Displays a preview of the selected item on the current line
        ghost_text = {
          enabled = true,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
      }

      -- opts.fuzzy = {
      --   -- Disabling this matches the behavior of fzf
      --   use_typo_resistance = false,
      --   -- Frecency tracks the most recently/frequently used items and boosts the score of the item
      --   use_frecency = true,
      --   -- Proximity bonus boosts the score of items matching nearby words
      --   use_proximity = false,
      -- }

      opts.snippets = {
        preset = "luasnip",
        -- This comes from the luasnip extra, if you don't add it, won't be able to
        -- jump forward or backward in luasnip snippets
        -- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      }

      -- The default preset used by lazyvim accepts completions with enter
      -- I don't like using enter because if on markdown and typing
      -- something, but you want to go to the line below, if you press enter,
      -- the completion will be accepted
      -- https://cmp.saghen.dev/configuration/keymap.html#default
      opts.keymap = {
        preset = "enter",
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<S-k>"] = { "scroll_documentation_up", "fallback" },
        ["<S-j>"] = { "scroll_documentation_down", "fallback" },

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-c>"] = { "hide", "fallback" },
      }

      return opts
    end,
  },
}
