#!/bin/bash
EVENTS="data/events.log"
BASE="data/baseline.db"
INCIDENTS="data/incidents.log"
awk -F',' '{print $3}' "$EVENTS" | sort | uniq -c > "$BASE"
tail -n 500 "$EVENTS" | awk -F',' '{print $3}' | sort | uniq -c | while read count user; do
    base=$(grep " $user$" "$BASE" | awk '{print $1}')
    [ -z "$base" ] && base=5
    if (( count > base * 3 )); then
        echo "$(date),$user,$count,$base" >> "$INCIDENTS"
    fi
done
