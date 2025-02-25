
# If .bash_profile exists, bash doesn't read .profile
if [[ -f ~/.profile ]]; then
	. ~/.profile
fi

export PATH="/usr/local/sbin:$PATH"
export VISUAL=vim
export EDITOR="$VISUAL"
export FZF_DEFAULT_COMMAND='ag -l --hidden --ignore \.git -g ""'

which difft > /dev/null
if [ $? -eq 0 ]; then
    export GIT_EXTERNAL_DIFF=difft
else
    echo "difft not found in PATH! Not setting GIT_EXTERNAL_DIFF...
    Find difft at: https://github.com/Wilfred/difftastic?tab=readme-ov-file"
fi
