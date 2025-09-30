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
<summary> AI & Automation (Expanded)</summary>

- **Avante.nvim**: Advanced AI integration (disabled by default), Copilot support, file selection via Snacks, floating window management, and autocmds to prevent duplicate sessions.
- **Blink.cmp**: Smart autocompletion with AI sources and custom behaviors.
- **CodeCompanion.nvim**: Deep integration with MCPHub and Copilot, commit/documentation generation, refactoring, code review, custom prompts, and slash commands. Prompts are modular and can be customized in `lua/lib/code-companion-prompts.lua`.
- **Copilot.nvim**: Automated suggestions, custom keymaps for accepting, navigating, and dismissing completions.
- **MCPHub.nvim**: Auto-approval for MCP tools, slash commands, and variable injection in prompts.
- **Opencode.nvim**: Embedded terminal, Snacks integration, keymaps for asking, explaining, selecting, and managing chat sessions. Session management and chat manipulation are highly customizable.
- **Notifications & Icons**: Animated notification system for AI and productivity tasks, with a large set of custom icons for diagnostics, files, git, and UI (`lua/lib/icons.lua`).

</details>

<details>
<summary> UI and User Experience</summary>

- **Custom Theme**: Color configuration with support for transparency and themes such as `onedark` and `tokyonight`.
- **Modern Dashboard**: Snacks.nvim provides a visual dashboard, quick access to recent files, projects, and custom actions.
- **Advanced Status Bar**: Lualine.nvim displays contextual information, integrates with CodeCompanion and Oil, features dynamic icons, and extensions for special buffers.
- **Visual Indicators**: Large collection of custom icons for diagnostics, files, git, and UI (`lib/icons.lua`).
- **Visual Notifications**: Animated notification system for AI and productivity tasks.

</details>

<details>
<summary> Navigation and Search</summary>

- **Snacks.nvim**: Tree-style file explorer, fast text and file search, session management, scratchpad, and custom layouts.
- **Oil.nvim**: Advanced directory management, custom keymaps for quick actions, integration with devicons.
- **Flash.nvim**: Efficient navigation within files.

</details>

<details>
<summary> Development & Productivity</summary>

- **LSP (Language Server Protocol)**: Full configuration for TypeScript, Python, Rust, Lua, and more.
- **Smart Autocompletion**: Blink.cmp with LSP, snippets, buffer, path, and Avante; highly customizable keymaps and snippet behavior.
- **Debugging**: nvim-dap with graphical interface and virtual text.
- **Overseer.nvim**: Task management and command execution, custom templates for Maven and Python.
- **Custom Snippets**: Ready-to-use structure for adding language-specific snippets in `snippets/`, compatible with LuaSnip and easy to extend.
- **Optimized Keymaps**: Extensive custom mappings for navigation, buffers, integration with Snacks, Oil, CodeCompanion, Overseer, and AI. Review and customize in `lua/config/keymaps.lua`.

</details>

<details>
<summary> AI & Automation</summary>

- **Avante.nvim**: Integración avanzada (deshabilitada por defecto), soporte para Copilot, selección de archivos con Snacks, manejo de ventanas flotantes y autocmds para evitar duplicados.
- **Blink.cmp**: Autocompletado inteligente con integración AI y fuentes personalizadas.
- **CodeCompanion.nvim**: Integración con MCPHub y Copilot, generación de commits, documentación, refactorización y revisión de código, prompts y slash commands personalizados.
- **Copilot.nvim**: Sugerencias automáticas, keymaps personalizados para aceptar, navegar y descartar.
- **MCPHub.nvim**: Autoaprobación de herramientas MCP, slash commands y variables MCP en prompts.
- **Opencode.nvim**: Terminal embebida, integración con Snacks, keymaps para preguntar, explicar, seleccionar y manipular sesiones de chat.

</details>

<details>
<summary> Markdown and Documentation</summary>

- **Markdown Rendering**: Enhanced support for Markdown editing with render-markdown.nvim.
- **Documentation View**: nvim-docs-view for viewing documentation directly within Neovim.

</details>

<details>
<summary> Design Tools</summary>

- **Color Picker**: Utilities for color conversion (hex, rgb, hsl) and buffer replacement (`gentleman/utils.lua`).
- **Tailwind Tools**: Tools for sorting Tailwind CSS classes.

</details>

<details>
<summary> Testing and Debugging</summary>

- **Testing Support**: Unit test generation with CodeCompanion and custom templates in Overseer.
- **Advanced Debugging**: Debugging configuration with support for multiple languages.

</details>

<details>
<summary> Utilities & Custom Functions</summary>

- **Custom Utilities**: Functions for retrieving user configuration, project root, filetype, and Telescope selection (`lib/util.lua`). Includes utilities for color conversion, buffer manipulation, and plugin helpers.
- **Custom Prompts**: AI prompts focused on frontend, architecture, and productivity (`lib/code-companion-prompts.lua`). You can add, modify, or extend prompts for personalized workflows.

</details>

---

## Main Plugins

> For a full list and configuration details, see the `lua/plugins/` directory. Each plugin is modular and can be enabled, disabled, or customized as needed.

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

#### AI & Automation

- **[yetone/avante.nvim](https://github.com/yetone/avante.nvim)**: Advanced AI integration, file selection, and Copilot support.
- **[olimorris/codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim)**: Commit generation, documentation, refactoring, code review, integration with MCPHub and Copilot.
- **[ravitemer/mcphub.nvim](https://github.com/ravitemer/mcphub.nvim)**: Integration with MCPHub for AI workflows and automation.
- **[NickvanDyke/opencode.nvim](https://github.com/NickvanDyke/opencode.nvim)**: Embedded terminal, AI prompts, and advanced chat session management.
- **[saghen/blink.cmp](https://github.com/saghen/blink.cmp)**: Smart autocompletion with AI integration and custom sources.
- **[zbirenbaum/copilot.lua](https://github.com/zbirenbaum/copilot.lua)**: Automated suggestions and custom keymaps for accepting, navigating, and dismissing completions.

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

You can extend and personalize your workflow with modular configuration files and utilities:

- **Keymaps:** Customize shortcuts in `lua/config/keymaps.lua`.
- **Options:** Adjust global options in `lua/config/options.lua`.
- **Plugins:** Modify or add plugins in `lua/plugins/`.
- **Utilities:** Add your own functions in `lua/lib/` and `lua/config/gentleman/` (e.g., color conversion, project root detection, filetype helpers).
- **Snippets:** Add custom snippets in the `snippets/` folder (compatible with LuaSnip, organized by language).
- **AI Prompts:** Customize prompts in `lua/lib/code-companion-prompts.lua` (frontend, architecture, productivity, etc.).
- **Icons & Notifications:** Customize icons in `lua/lib/icons.lua` and notification behaviors in `lua/lib/codecompanion-notifier.lua`.

For advanced features, see plugin configs in `lua/plugins/` and utility scripts in `lua/lib/` and `lua/config/gentleman/`.

You can customize the configuration by editing the files in `lua/plugins/`, `lua/config/`, and `lua/lib/`. Each plugin and utility has its own modular configuration. 

- **Keymaps:** Customize shortcuts in `lua/config/keymaps.lua`.
- **Options:** Adjust global options in `lua/config/options.lua`.
- **Plugins:** Modify or add plugins in `lua/plugins/`.
- **Utilities:** Add your own functions in `lua/lib/` and `lua/config/gentleman/`.
- **Snippets:** Add custom snippets in the `snippets/` folder.
- **AI Prompts:** Customize prompts in `lua/lib/code-companion-prompts.lua`.

---

## References and Acknowledgments

- [LazyVim](https://github.com/LazyVim/LazyVim)
- [Neovim](https://neovim.io/)
- [Gentleman-Dots](https://github.com/Gentleman-Programming/Gentleman.Dots/tree/main)
- [Linkarsu](https://github.com/linkarzu/dotfiles-latest)

---

## License

This project is under the Apache 2.0 license. See the [LICENSE](LICENSE) file for more details.
