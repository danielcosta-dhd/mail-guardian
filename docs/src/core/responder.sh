#!/bin/bash

source /etc/mail-guardian/policy.conf

handle() {
    local ip=$1
    local user=$2
    local score=$3

    if (( score >= SCORE_BLOCK )); then
        echo "[BLOCK] $ip $user score=$score"

        ipset add blacklist "$ip" timeout 3600 2>/dev/null
        passwd -l "$user" 2>/dev/null

    elif (( score >= SCORE_ALERT )); then
        echo "[ALERT] $ip $user score=$score"
    fi
}

case "$1" in
    handle)
        handle "$2" "$3" "$4"
        ;;
esac
