#!/bin/bash

BASE="/opt/mail-guardian"
DATA="/var/lib/mail-guardian"
LOG="/var/log/mail-guardian/mail-guardian.log"

EVENTS="$DATA/events.log"
OFFSET="$DATA/offset.state"

mkdir -p "$DATA" "$(dirname $LOG)"

last=0
[ -f "$OFFSET" ] && last=$(cat "$OFFSET")

current=$(wc -l < "$EVENTS" 2>/dev/null)
[ -z "$current" ] && current=0

sed -n "$((last+1)),$current p" "$EVENTS" | \
while IFS=',' read ts ip user rcpt; do

    $BASE/core/parser.sh process "$ts" "$ip" "$user" "$rcpt"

    score=$($BASE/core/engine.sh evaluate "$ip" "$user")

    $BASE/core/responder.sh handle "$ip" "$user" "$score" >> "$LOG"

done

echo "$current" > "$OFFSET"
