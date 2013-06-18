export PATH="$HOME/bin:$PATH:$HOME/go-dev/bin"
export GOPATH="$HOME/go-dev"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Load Git BASH completion
if [ -f /usr/share/git-core/git-completion.bash ]; then
  source /usr/share/git-core/git-completion.bash
fi

if [ -f ~/.private_bash ]; then
  source ~/.private_bash
fi

HISTSIZE=5000
HISTFILESIZE=5000

