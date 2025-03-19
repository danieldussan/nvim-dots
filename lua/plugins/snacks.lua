local icons = require("lib.icons")
return {
  {
    "folke/snacks.nvim",
    opts = {
      animate = {
        enabled = true,
        duration = 20, -- ms per step
        easing = "linear",
        fps = 60,
      },
      bigfile = {
        enabled = true,
        notify = true,
        size = 100 * 1024, -- 100 KB
      },
      bufdelete = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          {
            icon = icons.ui.Keyboard,
            title = "Keymaps",
            section = "keys",
            indent = 2,
            padding = 1,
          },
          {
            icon = icons.documents.File,
            title = "Recent Files",
            section = "recent_files",
            indent = 2,
            padding = 1,
          },
          {
            icon = icons.documents.OpenFolder,
            title = "Projects",
            section = "projects",
            indent = 2,
            padding = 1,
          },
          { section = "startup" },
        },
        preset = {
            -- stylua: ignore
            ---@type snacks.dashboard.Item[]
            keys = {
              { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
              { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
              { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
              { icon = " ", key = "e", desc = "Tree Explorer", action = ":lua Snacks.explorer()" },
              { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
              { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
              { icon = " ", key = "s", desc = "Restore Session", section = "session" },
              { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
              { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
              { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
        },
      },
      debug = { enabled = true },
      dim = {
        enabled = true,
        scope = {
          min_size = 5,
          max_size = 20,
          siblings = true,
        },
      },
      git = { enabled = true },
      gitbrowse = { enabled = true },
      indent = {
        enabled = true,
        priority = 1,
        char = icons.ui.SeparatorLight,
        only_scope = false,
        only_current = false,
        hl = {
          "SnacksIndent1",
          "SnacksIndent2",
          "SnacksIndent3",
          "SnacksIndent4",
          "SnacksIndent5",
          "SnacksIndent6",
          "SnacksIndent7",
          "SnacksIndent8",
        },
      },
      input = {
        enabled = true,
        icon = icons.ui.Edit,
        icon_hl = "SnacksInputIcon",
        icon_pos = "left",
        prompt_pos = "title",
        win = { style = "input" },
        expand = true,
      },
      lazygit = {
        enabled = true,
        win = {
          style = "float",
          width = 0.95,
          height = 0.95,
        },
      },
      notifier = {
        enabled = true,
        timeout = 2000,
        width = { min = 40, max = 0.4 },
        height = { min = 1, max = 0.6 },
        margin = { top = 0, right = 1, bottom = 0 },
        padding = true,
        sort = { "level", "added" },
        level = vim.log.levels.TRACE,
        icons = {
          debug = icons.ui.Bug,
          error = icons.diagnostics.Error,
          info = icons.diagnostics.Information,
          trace = icons.ui.Bookmark,
          warn = icons.diagnostics.Warning,
        },
        style = "compact",
        top_down = true,
        date_format = "%R",
        more_format = " ↓ %d lines ",
        refresh = 50,
      },
      notify = { enabled = true },
      profiler = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      scope = {
        enabled = true,
        keys = {
          textobject = {
            ii = {
              min_size = 2,
              edge = false,
              cursor = false,
              treesitter = { blocks = { enabled = false } },
              desc = "inner scope",
            },
            ai = {
              cursor = false,
              min_size = 2,
              treesitter = { blocks = { enabled = false } },
              desc = "full scope",
            },
          },
          jump = {
            ["[a"] = {
              min_size = 1,
              bottom = false,
              cursor = false,
              edge = true,
              treesitter = { blocks = { enabled = false } },
              desc = "jump to top edge of scope",
            },
            ["]a"] = {
              min_size = 1,
              bottom = true,
              cursor = false,
              edge = true,
              treesitter = { blocks = { enabled = false } },
              desc = "jump to bottom edge of scope",
            },
          },
        },
      },
      scratch = {
        enabled = true,
        name = "SCRATCH",
        ft = function()
          if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
            return vim.bo.filetype
          end
          return "markdown"
        end,
        icon = nil,
        root = vim.fn.stdpath("data") .. "/scratch",
        autowrite = true,
        filekey = {
          cwd = true,
          branch = true,
          count = true,
        },
        win = {
          width = 120,
          height = 40,
          bo = { buftype = "", buflisted = false, bufhidden = "hide", swapfile = false },
          minimal = false,
          noautocmd = false,
          zindex = 20,
          wo = { winhighlight = "NormalFloat:Normal" },
          border = "rounded",
          title_pos = "center",
          footer_pos = "center",
        },
      },
      scroll = { enabled = true },
      statuscolumn = {
        enabled = true,
        left = { "mark", "sign" },
        right = { "fold", "git" },
        folds = {
          open = false,
          git_hl = false,
        },
        git = {
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50,
      },
      terminal = {
        enabled = true,
        win = {
          style = "float",
          width = 0.6,
          height = 0.5,
          border = "rounded",
        },
      },
      toggle = { enabled = false },
      win = { enabled = true },
      words = { enabled = false },
      zen = {
        enabled = true,
        toggles = {
          dim = true,
          git_signs = false,
          mini_diff_signs = false,
        },
        show = {
          statusline = false,
          tabline = false,
        },
        win = { style = "zen" },
      },
      picker = {
        -- My ~/github/dotfiles-latest/neovim/lazyvim/lua/config/keymaps.lua
        -- file was always showing at the top, I needed a way to decrease its
        -- score, in frecency you could use :FrecencyDelete to delete a file
        -- from the database, here you can decrease it's score
        transform = function(item)
          if not item.file then
            return item
          end
          -- Demote the "lazyvim" keymaps file:
          if item.file:match("lazyvim/lua/config/keymaps%.lua") then
            item.score_add = (item.score_add or 0) - 30
          end
          -- Boost the "neobean" keymaps file:
          -- if item.file:match("neobean/lua/config/keymaps%.lua") then
          --   item.score_add = (item.score_add or 0) + 100
          -- end
          return item
        end,
        sources = {
          explorer = {
            finder = "explorer",
            sort = { fields = { "sort" } },
            supports_live = true,
            tree = true,
            watch = true,
            git_status = true,
            git_status_open = true,
            follow_file = true,
            focus = "list",
            auto_close = true,
            jump = { close = false },
            layout = { preset = "default", preview = true },
          },
          files = {
            exclude = { "node_modules", ".git", "build", "dist", "venv", "__pycache__" },
          },
        },
        -- In case you want to make sure that the score manipulation above works
        -- or if you want to check the score of each file
        debug = {
          scores = true, -- show scores in the list
        },
        -- I like the "ivy" layout, so I set it as the default globaly, you can
        -- still override it in different keymaps
        layout = {
          preset = "default",
          -- When reaching the bottom of the results in the picker, I don't want
          -- it to cycle and go back to the top
          cycle = false,
        },
        layouts = {
          -- I wanted to modify the ivy layout height and preview pane width,
          -- this is the only way I was able to do it
          -- NOTE: I don't think this is the right way as I'm declaring all the
          -- other values below, if you know a better way, let me know
          --
          -- Then call this layout in the keymaps above
          -- got example from here
          -- https://github.com/folke/snacks.nvim/discussions/468
          ivy = {
            layout = {
              box = "vertical",
              backdrop = false,
              row = -1,
              width = 0,
              height = 0.6,
              border = "top",
              title = " {title} {live} {flags}",
              title_pos = "left",
              { win = "input", height = 1, border = "bottom" },
              {
                box = "horizontal",
                { win = "list", border = "none" },
                { win = "preview", title = "{preview}", width = 0.65, border = "left" },
              },
            },
          },
          -- I wanted to modify the layout width
          --
          vertical = {
            layout = {
              backdrop = false,
              width = 0.8,
              min_width = 80,
              height = 0.8,
              min_height = 30,
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
          default = {
            layout = {
              box = "horizontal",
              width = 0.95,
              height = 0.95,
              {
                box = "vertical",
                border = "rounded",
                title = " {title} {live} {flags}",
                title_pos = "center",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", border = "rounded", width = 0.65 },
            },
          },
        },
        matcher = {
          frecency = true,
        },
        toggles = {
          follow = "f",
          hidden = "h",
          ignored = "i",
          modified = "m",
          regex = { icon = "R", value = false },
        },
        win = {
          input = {
            keys = {
              -- to close the picker on ESC instead of going to normal mode,
              -- add the following keymap to your config
              ["<Esc>"] = { "close", mode = { "n" } },
              -- I'm used to scrolling like this in LazyGit
              ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
              ["L"] = { "preview_scroll_right", mode = { "i", "n" } },
            },
          },
        },
      },
    },
  },
}
