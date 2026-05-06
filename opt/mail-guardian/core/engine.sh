#!/bin/bash
source /etc/mail-guardian/main.conf
evaluate() {
    local ip=$1
    local user=$2
    local rcpt=$3
    local score=0
    [[ $user =~ spam ]] && ((score+=3))
    [[ $rcpt =~ "@" ]] || ((score+=2))
    echo "$score"
}
case "$1" in
    evaluate) evaluate "$2" "$3" "$4" ;;
esac
