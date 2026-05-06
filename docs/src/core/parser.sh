#!/bin/bash

source /opt/mail-guardian/core/state.sh

process_event() {
    local ts=$1
    local ip=$2
    local user=$3
    local rcpt=$4

    increment_field "$user" "sent"
}

case "$1" in
    process)
        process_event "$2" "$3" "$4" "$5"
        ;;
esac
