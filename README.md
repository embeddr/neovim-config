# Ethan's Neovim Configuration

## Requirements
Recommend using the latest stable Neovim version available. Some plugins may not function correctly with older versions.

###  Prerequisites
- `lemonade` must be installed to allow yanking to and pasting from a host's clipboad over SSH
    - Install on remote machine - Neovim will detect and use it automatically
    - Install on local machine and run `lemonade server` to connect host clipboard
        - Must forward a port! By default, `2489`
        - See [lemonade README](RemoteForward 2489 127.0.0.1:2489) for info on configuration
- `ripgrep` must be installed for `vim-ripgrep` (i.e. `:Rg`) to work
    - This can be installed via `cargo` (if you have Rust set up on your machine) or your distro's package manager. See the [installation instructions](https://github.com/BurntSushi/ripgrep#installation) for more details.
- For icons to render, the terminal emulator used to run Neovim (whether local or on a remote machine) must be using a patched font (see [nerd fonts](https://www.nerdfonts.com/))
    - Recommend the patched `JetBrainsMonoNL Nerd Font`
        - Regular format
        - Non-mono format (still mono, but allows for larger icons)
    - Nerd fonts broke compatibility with v3.0, so make sure you have a recent version

### Setup
You will need to use Mason to install LSP servers. Recommendations:
- `jsonls`
- `lua_ls`
- `clangd`
- `pyright`


### Maintenance
If encountering errors while using Telescope, try running `TSUpdate` from within Neovim.
