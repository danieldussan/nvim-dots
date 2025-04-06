-- This file contains custom key mappings for Neovim.
local wk = require("which-key")
local code_companion_key_prefix = "<leader>z"
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Position cursor at the middle of the screen after scrolling half page
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Scroll down half a page and center the cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Scroll up half a page and center the cursor

-- Map Ctrl+b in insert mode to delete to the end of the word without leaving insert mode
vim.keymap.set("i", "<C-b>", "<C-o>de")

-- Map Ctrl+c to escape from other modes
vim.keymap.set({ "i", "n", "v" }, "<C-c>", [[<C-\><C-n>]])

----- Tmux Navigation ------
-- local nvim_tmux_nav = require("nvim-tmux-navigation")
--
-- vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft) -- Navigate to the left pane
-- vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown) -- Navigate to the bottom pane
-- vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp) -- Navigate to the top pane
-- vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight) -- Navigate to the right pane
-- vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive) -- Navigate to the last active pane
-- vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext) -- Navigate to the next pane

----- OIL -----
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Delete all buffers but the current one
vim.keymap.set(
  "n",
  "<leader>bq",
  '<Esc>:%bdelete|edit #|normal`"<Return>',
  { desc = "Delete other buffers but the current one" }
)

-- Disable key mappings in insert mode
vim.api.nvim_set_keymap("i", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-k>", "<Nop>", { noremap = true, silent = true })

-- Disable key mappings in normal mode
vim.api.nvim_set_keymap("n", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", "<Nop>", { noremap = true, silent = true })

-- Disable key mappings in visual block mode
vim.api.nvim_set_keymap("x", "<A-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-k>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "J", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "K", "<Nop>", { noremap = true, silent = true })

-- Redefine Ctrl+s to save with the custom function
vim.api.nvim_set_keymap("n", "<C-s>", ":lua SaveFile()<CR>", { noremap = true, silent = true })

-- Custom save function
function SaveFile()
  -- Check if a buffer with a file is open
  -- if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
  --   vim.notify("No file to save", vim.log.levels.WARN)
  --   return
  -- end
  local bufname = vim.api.nvim_buf_get_name(0) -- Obtiene el nombre del buffer actual
  local filename = vim.fn.expand("%:t") -- Obtiene solo el nombre del archivo
  local success, err = pcall(function()
    vim.cmd("silent! write") -- Intenta guardar sin mostrar mensajes por defecto
  end)

  if bufname:match("^oil://") then
    return
  end
  if success then
    vim.notify(filename .. " Saved!", vim.log.levels.INFO) -- Show only the custom message if successful
  else
    vim.notify("Error: " .. err, vim.log.levels.ERROR) -- Show the error message if it fails
  end
end

-- Custom keymaps

wk.add({
  { "<leader>t", desc = "Custom", icon = " " },
  { "<leader>a", desc = "ai" },
  {
    "<leader>tc",
    ":Huefy<CR>",
    desc = "Color Picker",
    icon = " ",
  },
  {
    "<leader>ts",
    ":TailwindSort<CR>",
    desc = "Tailwind Sort",
    icon = "󱏿 ",
  },
  {
    "<leader>tm",
    ":MCPHub<CR>",
    desc = "MCP Hub",
    icon = " ",
  },
  {
    "<leader>?",
    function()
      require("which-key").show({ global = false }) -- Show the which-key popup for local keybindings
    end,
    desc = "Show Which Key",
    icon = " ",
  },
  {
    "<leader>,",
    function()
      Snacks.picker.buffers({
        -- I always want my buffers picker to start in normal mode
        on_show = function()
          vim.cmd.stopinsert()
        end,
        finder = "buffers",
        format = "buffer",
        hidden = false,
        unloaded = true,
        current = true,
        sort_lastused = true,
        win = {
          input = {
            keys = {
              ["d"] = "bufdelete",
            },
          },
          list = { keys = { ["d"] = "bufdelete" } },
        },
        -- In case you want to override the layout for this keymap
        -- layout = "ivy",
      })
    end,
    desc = "Snacks picker buffers",
  },
  {
    "<M-k>",
    function()
      Snacks.picker.keymaps({
        layout = "vertical",
      })
    end,
    desc = "Keymaps",
  },
})

-- CodeCompanion Keybindings

wk.add({
  { "ga", "<cmd>CodeCompanionChat Add<CR>", mode = { "v" }, desc = "AI Add to Chat" },
  { code_companion_key_prefix, desc = "Code Companion", icon = "" },
  {
    code_companion_key_prefix .. "a",
    ":CodeCompanionActions<CR>",
    desc = "Actions",
    icon = "⚡",
    mode = { "n", "v" },
  },
  {
    code_companion_key_prefix .. "c",
    ":CodeCompanionChat Toggle<CR>",
    desc = "Toggle Chat",
    icon = "💬",
  },
  {
    code_companion_key_prefix .. "e",
    ":CodeCompanion /explain<CR>",
    desc = "Explain Code",
    icon = "📖",
    mode = "v",
  },
  {
    code_companion_key_prefix .. "f",
    ":CodeCompanion /fix<CR>",
    desc = "Fix Code",
    icon = "🛠",
    mode = "v",
  },
  {
    code_companion_key_prefix .. "l",
    ":CodeCompanion /lsp<CR>",
    desc = "Explain LSP",
    icon = "🔍",
    mode = { "n", "v" },
  },
  {
    code_companion_key_prefix .. "t",
    ":CodeCompanion /tests<CR>",
    desc = "Generate Unit Test",
    icon = "🧪",
    mode = "v",
  },
  {
    code_companion_key_prefix .. "m",
    ":CodeCompanion /commit<CR>",
    desc = "Git Commit Message",
    icon = "📜",
  },
  {
    code_companion_key_prefix .. "M",
    ":CodeCompanion /staged-commit<CR>",
    desc = "Git Commit (Staged)",
    icon = "📜",
  },
  {
    code_companion_key_prefix .. "d",
    ":CodeCompanion /inline-doc<CR>",
    desc = "Inline Documentation",
    icon = "📝",
    mode = "v",
  },
  {
    code_companion_key_prefix .. "D",
    ":CodeCompanion /doc<CR>",
    desc = "Document Code",
    icon = "📄",
    mode = "v",
  },
  {
    code_companion_key_prefix .. "r",
    ":CodeCompanion /refactor<CR>",
    desc = "Refactor Code",
    icon = "♻️",
    mode = "v",
  },
  {
    code_companion_key_prefix .. "R",
    ":CodeCompanion /review<CR>",
    desc = "Review Code",
    icon = "🔍",
    mode = "v",
  },
  {
    code_companion_key_prefix .. "n",
    ":CodeCompanion /naming<CR>",
    desc = "Better Naming",
    icon = "🏷",
    mode = "v",
  },
  {
    code_companion_key_prefix .. "q",
    function()
      local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then
        vim.cmd("CodeCompanion " .. input)
      end
    end,
    desc = "Quick Chat",
    icon = "💡",
  },
})

-- Delete word with ctrl+backspace at insert mode
vim.api.nvim_set_keymap("i", "<C-BS>", "<C-w>", { noremap = true, silent = true, desc = "Delete word" })
