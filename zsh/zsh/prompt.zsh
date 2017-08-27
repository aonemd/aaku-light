function git_status {
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]]; then
    echo "%{$fg[red]%}"
  else
    echo "%{$fg[green]%}"
  fi
}

function git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ $(git_status)\1/"
}

PROMPT='%{$fg[blue]%}%1~$(git_branch) %{$fg_bold[white]%}➜ %{$reset_color%}'
