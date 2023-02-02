
# If .bash_profile exists, bash doesn't read .profile
if [[ -f ~/.profile ]]; then
	. ~/.profile
fi

export PATH="/usr/local/sbin:$PATH"
export VISUAL=vim
export EDITOR="$VISUAL"
