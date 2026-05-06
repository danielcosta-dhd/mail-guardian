#!/bin/bash
EVENTS="data/events.log"
STATE="data/offset.state"
last_line=0
[ -f "$STATE" ] && last_line=$(cat "$STATE")
current_line=$(wc -l < "$EVENTS")
start=$((last_line + 1))
sed -n "${start},${current_line}p" "$EVENTS" | while IFS=',' read ts ip user rcpt; do
    score=$(./engine.sh evaluate "$ip" "$user" "$rcpt")
    ./responder.sh handle "$ip" "$user" "$score"
done
echo "$current_line" > "$STATE"
