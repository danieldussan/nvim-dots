# 🚀 Neovim Configuration

> A custom Neovim configuration based on **LazyVim**, designed to maximize productivity and optimize software development.

## 📑 Table of Contents

- [Preview](#preview)
- [Key Features](#key-features)
- [Main Plugins](#main-plugins)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Customization](#customization)
- [References and Acknowledgments](#references-and-acknowledgments)
- [License](#license)

## Preview

### Dashboard

A modern and clean dashboard with quick access to recent files and custom actions.

<div align="center">
  <img src="images/dashboard.png" alt="Dashboard View" width="800"/>
</div>

<details>
<summary><strong>Snacks Plugin Integration</strong></summary>

Powerful file navigation and search capabilities:

- Tree-style file explorer for project navigation
- Quick file search by name across the project
- Full-text search across all project files
- Integrated with fuzzy finder for fast results
  <img src="images/snacks.png" alt="Snacks Plugin"/>

</details>

<details>
<summary><strong>Oil, Blink-cmp and Avante Integration</strong></summary>

Seamless file management with Oil, intelligent code completion with Blink-cmp, and AI assistance with Avante.
<img src="images/oil-blink-avante.png" alt="Oil, Blink-cmp and Avante"/>

</details>

## Key Features

<details>
<summary> UI and User Experience</summary>

- **Custom Theme**: Color configuration with support for transparency and themes like `onedark` and `tokyonight`.
- **Modern Dashboard**: Quick access to recent files, projects, and custom actions.
- **Advanced Status Bar**: Integration with `lualine.nvim` to display contextual information such as the current mode, progress, and more.
- **Tab Management**: Support for `bufferline.nvim` for smooth navigation between buffers.
- **Visual Indicators**: Use of custom icons to enhance the visual experience (see `lib/icons.lua`).

</details>

<details>
<summary> Navigation and Search</summary>

- **Snacks.nvim**: Tree-style file explorer, quick text and file search, and support for recent projects.
- **Flash.nvim**: Fast and efficient navigation within files.
- **Oil.nvim**: Integrated directory management directly in Neovim.

</details>

<details>
<summary> Development</summary>

- **LSP (Language Server Protocol)**: Full configuration for multiple languages such as TypeScript, Python, Rust, Lua, and more.
- **Intelligent Autocompletion**: Integration with `blink.cmp` for contextual suggestions, snippets (`LuaSnip`), and LSP support.
- **Debugging**: Support for `nvim-dap` with a graphical interface (`nvim-dap-ui`) and virtual text (`nvim-dap-virtual-text`).
- **Custom Snippets**: Snippets for languages like Astro and support for global snippets.

</details>

<details>
<summary> AI Assistants</summary>

- **Avante.nvim**: Integration with AI for real-time assistance, code generation, and conflict resolution.
- **CodeCompanion.nvim**: Advanced tool for generating commits, documentation, refactoring, and code review.
- **Copilot.nvim**: Automatic suggestions powered by AI.
- **Mcphub Integration**: Seamless integration with mcphub for enhanced AI-driven workflows.

</details>

<details>
<summary> Markdown and Documentation</summary>

- **Markdown Rendering**: Enhanced support for Markdown editing with `render-markdown.nvim`.
- **Documentation View**: Integration with `nvim-docs-view` to view documentation directly in Neovim.

</details>

<details>
<summary> Design Tools</summary>

- **Color Picker**: Integrated color selector with `minty` and `volt`.
- **Tailwind Tools**: Tools to sort Tailwind CSS classes.

</details>

<details>
<summary> Testing and Debugging</summary>

- **Testing Support**: Unit test generation with `CodeCompanion`.
- **Advanced Debugging**: Configuration for debugging with support for multiple languages.

</details>

<details>
<summary> Productivity</summary>

- **Session Management**: Quickly restore previous sessions.
- **Custom Shortcuts**: Optimized keymap configuration for fast navigation and editing.
- **Notifications**: Visual notification system for tasks in progress.

</details>

---

## Main Plugins

#### UI and User Experience

- **[folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)**: Highlights and searches for comments like TODO, FIX, HACK.
- **[folke/noice.nvim](https://github.com/folke/noice.nvim)**: Enhances the command-line interface.
- **[b0o/incline.nvim](https://github.com/b0o/incline.nvim)**: Displays the current file name in a floating window.

#### Development

- **[neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)**: LSP server configuration.
- **[mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)**: Debug Adapter Protocol client.
- **[L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)**: Extensible snippet system.

#### Productivity

- **[stevearc/oil.nvim](https://github.com/stevearc/oil.nvim)**: Directory management.
- **[folke/which-key.nvim](https://github.com/folke/which-key.nvim)**: Popup to display available keybindings.

#### AI Assistants

- **[yetone/avante.nvim](https://github.com/yetone/avante.nvim)**: AI assistance for code generation and conflict resolution.
- **[olimorris/codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim)**: Advanced tool for code-related tasks.
- **[ravitemer/mcphub.nvim](https://github.com/ravitemer/mcphub.nvim)**: Integration with mcphub for enhanced AI-driven workflows.

---

## Prerequisites

#### Essential Tools

```bash
# Using apt
sudo apt install neovim lazygit fzf

# Using brew
brew install neovim lazygit fzf
```

#### System Packages

```bash
sudo apt install git ripgrep fd-find nodejs npm
```

#### Language Servers and Formatters

```bash
# Install global npm packages
npm install -g prettier typescript typescript-language-server
```

---

## Setup

1. Clone this repository:

```bash
git clone https://github.com/danieldussan/nvim-dots.git ~/.config/nvim
```

2. Start Neovim and wait for plugins to install:

```bash
nvim
```

The first startup might take a few minutes as it installs all plugins and language servers.

---

## Customization

You can customize the configuration by editing the files in `lua/plugins/`. Each plugin has its own modular configuration.

---

## References and Acknowledgments

- [LazyVim](https://github.com/LazyVim/LazyVim)
- [Neovim](https://neovim.io/)
- [Gentleman-Dots](https://github.com/Gentleman-Programming/Gentleman.Dots/tree/main)
- [Linkarsu](https://github.com/linkarzu/dotfiles-latest)

---

## License

This project is under the Apache 2.0 license. See the [LICENSE](LICENSE) file for more details.
