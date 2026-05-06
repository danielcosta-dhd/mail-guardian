#!/bin/bash

source /opt/mail-guardian/core/state.sh
source /etc/mail-guardian/policy.conf

rule_high_volume() {
    local user=$1

    line=$(get_user_state "$user")
    sent=$(echo "$line" | grep -oP 'sent=\K[0-9]+')

    [ -z "$sent" ] && sent=0

    (( sent > MAX_REPEAT_HUMAN ))
}
