export PATH="/usr/local/bin:$PATH:/usr/local/sbin:$HOME/go-dev/bin:$HOME/bin"
export GOPATH="$HOME/go-dev"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && source "$file"
done
unset file

HISTSIZE=5000
HISTFILESIZE=5000

# Load Git BASH completion
if [ -f /usr/share/git-core/git-completion.bash ]; then
  source /usr/share/git-core/git-completion.bash
fi

if [ -f ~/.private ]; then
  source ~/.private
fi

# source system install of RVM
[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"

# source home install of RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
