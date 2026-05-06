#!/bin/bash

source /opt/mail-guardian/core/rules.sh
source /etc/mail-guardian/policy.conf

evaluate() {
    local ip=$1
    local user=$2

    score=0

    rule_high_volume "$user" && ((score+=3))

    echo "$score"
}

case "$1" in
    evaluate)
        evaluate "$2" "$3"
        ;;
esac
