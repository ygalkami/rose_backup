export EDITOR="joe"
export DISPLAY=":0.0"

autoload -Uz promptinit compinit
promptinit
compinit
colors
export PS1=%{${fg_bold[blue]}%}\[%i\]\ %{${fg[green]}%}\[%{${fg[yellow]}%}%n%{${fg[green]}%}@%{${fg[red]}%}%m\ %~%{${fg[green]}%}\]\ %#\ %{${fg[default]}%}

#zmodload pcre

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' max-errors 1
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*:default' list-prompt '

HISTFILE=~/.zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt correct
setopt appendhistory sharehistory incappendhistory histsavenodups
setopt nobeep
setopt extendedglob
setopt autocd autopushd pushdignoredups

alias c="clear"
alias ls="ls --color=auto -h"
alias ll="ls -l"
alias off="sudo shutdown -h now"
alias rbt="sudo shutdown -r now"
alias ssh="ssh -X"
alias sx="screen -x"
alias joe="joe -nonotice -autoindent -lightoff -tab 4"
alias hw="joe ~/.homework"
alias st="startx"
alias pandora="firefox www.pandora.com &"
alias d="dirs -v"
alias sl="ls --color=auto -h"
alias wt="weather | grep 'Temp\|Wind\|Wea' | cowsay -f turtle"
alias -s pdf=evince
alias eagle="~/eagle/bin/eagle"
alias lynx="lynx -accept_all_cookies -homepage=www.google.com"

alias -s odt=oowriter
alias -s doc=oowriter
alias -s docx=oowriter
alias -s rtf=oowriter
alias -s ods=oocalc
alias -s xls=oocalc
alias -s xlsx=oocalc
alias -s odp=ooimpress
alias -s ppt=ooimpress

alias -s pptx=ooimpress

alias -s htm=firefox
alias -s html=firefox

alias -s png=eog
alias -s jpg=eog
alias -s gif=eog

alias -s avi=mplayer
alias -s mpg=mplayer
alias -s wmv=mplayer

alias -s tar=file-roller
alias -s gz=file-roller
alias -s bz2=file-roller
alias -s rar=file-roller
alias -s zip=file-roller

alias -s py=python
alias -s pl=perl
