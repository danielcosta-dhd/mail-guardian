#!/bin/bash

STATE="/var/lib/mail-guardian/state.db"

get_user_state() {
    grep "^user=$1|" "$STATE" 2>/dev/null
}

increment_field() {
    local user=$1
    local field=$2

    line=$(get_user_state "$user")
    val=$(echo "$line" | grep -oP "$field=\K[0-9]+")

    [ -z "$val" ] && val=0
    ((val++))

    if [ -z "$line" ]; then
        echo "user=$user|$field=$val" >> "$STATE"
    else
        new=$(echo "$line" | sed "s/$field=[^|]*/$field=$val/")
        sed -i "s|$line|$new|" "$STATE"
    fi
}
