# dotfiles

This is a repo to back up my dotfiles.

Included:

- alacritty conig
- .bashrc
- A minimal neovim config for ssh sessions (nvim-mini)
- neovim config
- personal sh-utils
- .tmux.config
- starship theme
- zed settings + keymaps

The following are not live, and are snapshots from 4/25/2025

- .obsidian setup
- vscode

---

Setting up config symlinks: `/path/to/dotfiles ; $ stow nvim -t ~/.config/nvim`

- From dotfiles, stowing all files in directory nvim
- `-t` flag denotes target, and not just placing everything in root
- Target is the existing nvim dir in config

> Doing it with stow allows for all your configs to live in one place, but be referenced from elsewhere on your machine, like the .config folder or from root
