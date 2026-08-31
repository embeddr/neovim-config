# Ethan's Neovim Configuration

## Requirements
Requires Neovim 0.12 or newer for the built-in `vim.pack` plugin manager. Some plugins may not function correctly with older versions.

###  Prerequisites
- `ripgrep` must be installed for `vim-ripgrep` (i.e. `:Rg`) to work
    - This can be installed via `cargo` (if you have Rust set up on your machine) or your distro's package manager. See the [installation instructions](https://github.com/BurntSushi/ripgrep#installation) for more details.
- `tree-sitter-cli` must be required for `nvim-treesitter`.
- For icons to render, the terminal emulator used to run Neovim (whether local or on a remote machine) must be using a patched font (see [nerd fonts](https://www.nerdfonts.com/))
    - Recommend the patched `JetBrainsMonoNL Nerd Font`
        - Regular format
        - Non-mono format (still mono, but allows for larger icons)
    - Nerd fonts broke compatibility with v3.0, so make sure you have a recent version

### Setup
You will need to use Mason to install LSP servers. Recommendations:
- `jsonls`
- `lua_ls` (`lua-language-server`)
- `clangd`
- `pyright`
