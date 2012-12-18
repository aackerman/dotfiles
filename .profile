# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Load Git BASH completion
source /usr/share/git-core/git-completion.bash

# Better disk usage stats
alias dus='du -Psckx * | sort -nr'
alias slt='open -a "Sublime Text 2" .'
