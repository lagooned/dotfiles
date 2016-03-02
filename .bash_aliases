# some ls aliases
alias ll='ls -alF'
alias lh='ls -lh'
alias lls='ls -lhSr'
alias llh='ls -lh'
alias la='ls -A'
alias l='ls -CF'

# produce some dazzling colors on the terminal. you'll probably want to run `reset` afterward.
alias dazzle='while :;do printf "\e[%d;%dH\e[48;5;%dm \e[0m" $(($RANDOM%$LINES)) $(($RANDOM%$COLUMNS)) $(($RANDOM%216 )); done'

# brownnoise
alias brownnoise='play -c 2 --null synth brownnoise reverb bass 6 treble -3 echos 0.8 0.9 1000 0.3 1800 0.25'

# up multiple directories
cd() { if [[ "$1" =~ ^\.\.+$ ]];then local a dir;a=${#1};while [ $a -ne 1 ];do dir=${dir}"../";((a--));done;builtin cd $dir;else builtin cd "$@";fi ;}

# clear
alias c='clear'
