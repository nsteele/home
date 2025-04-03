## Installation

In your `$HOME` directory, run

```
git init
git remote add origin <clone url>
git fetch
git checkout -b master origin/master
git submodule update --init --recursive
```

the submodule(s) are necessary, else you will be missing `.tmux.conf` and `tmux` will not work.

## Install `nvim`

Install `nvim` according to its [installation manual on github](https://github.com/neovim/neovim/blob/master/INSTALL.md).
For Linux, I recommend following the "Pre-built archives" section.
Instructions for macOS and Windows are also available in the manual.

# Install Dependencies

* Install `ripgrep`

  * `sudo apt install ripgrep`

* Optional: [fzf](https://github.com/junegunn/fzf) (command-line tool `fzf` - this is optional because nvim uses a standalone `fzf` plugin)

## OUTDATED Install `vim`

Install `vim` according to one of the OS-specific instruction sets below.

### macOS

For `vi` on macOS, I recommend doing the following:

```
brew install vim --with-override-system-vi
```

then restart your terminal. Running `vi --version` should show an updated `vim`. You can check that you have the latest available from Homebrew by referencing the version shown by `brew info vim`.

### Ubuntu 20.04

Use a `vim` installation with python support. My preferred is

```
sudo apt install vim-athena
```

### Ubuntu 16.04

Use a `vim` installation with python support. My preferred is

```
sudo apt-get install vim-gnome
sudo update-alternatives --config vim # Opens window where you can specify default vim
sudo update-alternatives --config vi  # Opens window where you can specify default vi as vim
sudo update-alternatives --config editor  # Opens window where you can specify vim as default editor
```

### Ubuntu 14.04

For `vi` on Ubuntu 14.04 x86_64, here are the steps I used to install:

```
sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git
sudo apt-get purge vim-common vim-runtime vim-tiny
git clone https://github.com/vim/vim.git
cd ./vim
git checkout v8.0.0000
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim80 -j2
sudo apt-get install checkinstall
sudo checkinstall
```

Update alternatives as appropriate:

```
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
```

In the case you wish to uninstall `vim`, run

```
dpkg -r vim
```

## Tips

Use `.gitignore_global` to specify files for git to ignore in EVERY repository. This should be a short list. For it to take effect, run

```
git config --global core.excludesfile ~/.gitignore_global
```


