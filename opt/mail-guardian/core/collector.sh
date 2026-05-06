#!/bin/bash
LOG_MAIL="/var/log/mail.log"
OUTPUT="data/events.log"
grep "sasl_username" "$LOG_MAIL" | while read line; do
    ip=$(echo "$line" | grep -oP '

\[[0-9.]+\]

' | tr -d '[]')
    user=$(echo "$line" | grep -oP 'sasl_username=\K[^,]+')
    [ -n "$ip" ] && [ -n "$user" ] && echo "$(date +%s),$ip,$user" >> "$OUTPUT"
done
