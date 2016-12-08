#!/usr/bin/env bash
# if [ -t 1 ]; then
# exec zsh
# fi

# Path to the bash it configuration
export BASH_IT="/home/Feng/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
# export BASH_IT_THEME='bobby'
export BASH_IT_THEME='dasea'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true
export SCM_GIT_SHOW_DETAILS=false
export SCM_GIT_SHOW_REMOTE_INFO=false
export SCM_GIT_IGNORE_UNTRACKED=true
export SCM_GIT_SHOW_CURRENT_USER="DaSea"

export THEME_SHOW_CLOCK_CHAR=false
export THEME_SHOW_CLOCK=false

unset BASH_IT_LEGACY_PASS

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load Bash It
source $BASH_IT/bash_it.sh

# source autojump
source /usr/share/autojump/autojump.sh
# source ~/.oh-my-bash/rg.bash-completion

# 字符画
# echo "H     H  E E E E  L        L        O O O O"
# echo "H     H  E        L        L        O     O"
# echo "H     H  E        L        L        O     O"
# echo "H H H H  E E E E  L        L        O     O"
# echo "H     H  E        L        L        O     O"
# echo "H     H  E        L        L        O     O"
# echo "H     H  E E E E  L L L L  L L L L  O O O O"
echo "-----------------------------------------------------------"
echo "|                                                         |"
echo "|   'hello world' o  ^--^                                 |"
echo "|                  o (oo)\=======                         |"
echo "|                    (__)\       )\/\                     |"
echo "|                        ||----w |                        |"
echo "|                        ||     ||                        |"
echo "|                                                         |"
echo "|                                                         |"
echo "-----------------------------------------------------------"

