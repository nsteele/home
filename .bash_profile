NEOVIM_DIR="/opt/nvim-linux-x86_64"
export PATH="/usr/local/sbin:$PATH:/opt/nvim-linux-x86_64/bin"

if [ -d "$NEOVIM_DIR"]; then
   export PATH = "$PATH:/opt/nvim-linux-x86_64/bin"
else
   echo "Neovim install directory $NEOVIM_DIR not found
   Installation instructions: https://github.com/neovim/neovim/blob/master/INSTALL.md"
fi

export VISUAL=vim
export EDITOR="$VISUAL"
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{.git,node_modules}/*" 2> /dev/null'

# If .bash_profile exists, bash doesn't read .profile
if [[ -f ~/.profile ]]; then
	. ~/.profile
fi

which difft > /dev/null
if [ $? -eq 0 ]; then
    export GIT_EXTERNAL_DIFF=difft
else
    echo "difft not found in PATH! Not setting GIT_EXTERNAL_DIFF...
    Find difft at: https://github.com/Wilfred/difftastic?tab=readme-ov-file"
fi
