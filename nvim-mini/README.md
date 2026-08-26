# nvim-mini

This is a minimal config for when I'm ssh'd into a machine for long enough to want a better flavor of default vim.

# Installation

```
# Download latest neovim release from GitHub releases and pipe it to tar to extract it to /usr
curl -sL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
| sudo tar -xzf - --strip-components=1 --overwrite -C /usr
mv nvim-linux-x86_64 ~/.local/nvim
ln -s ~/.local/nvim/bin/nvim ~/.local/bin/nvim
# make sure ~/.local/bin is on your PATH
```

# or this ? https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

# config linking

```
sudo apt install git -y
git clone https://github.com/diegotyner/dotfiles # this repo has multiple configs. we want the config in ./nvim-mini
git clone https://github.com/diegotyner/dotfiles ~/dotfiles
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/nvim-mini/init.lua ~/.config/nvim/init.lua
ln -s ~/dotfiles/nvim-mini/lua ~/.config/nvim/lua
```
