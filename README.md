## Installation

In your `$HOME` directory, run

```
git init
git add remote origin <clone url>
git pull origin master
git submodule init
git submodule update --recursive
```

the submodule(s) are necessary, else you will be missing `Vundle` and `vi` will throw errors.

## Setup

To install `Vundle`-managed plugins, open `vi`, then run `:PluginInstall`.
`YouCompleteMe` requires additional installation; see [here](https://github.com/Valloric/YouCompleteMe). Note the minimum required `vim` version, and how to install a newer `vim`, in the preceding link.

For `vi` on macOS, I recommend doing the following:

```
brew install vim --with-override-system-vi
```

then restart your terminal. Running `vi --version` should show an updated `vim`. You can check that you have the latest available from Homebrew by referencing the version shown by `brew info vim`.



## Tips

Use `.gitignore_global` to specify files for git to ignore in EVERY repository. This should be a short list. For it to take effect, run

```
git config --global core.excludesfile ~/.gitignore_global
```


