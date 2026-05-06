#!/bin/bash

STATE="/opt/mail-guardian/data/state.db"
OUT="/opt/mail-guardian/dashboard/data.json"

echo "[" > $OUT

first=1

while IFS='|' read -r user data; do

    sent=$(echo "$data" | grep -oP 'sent=\K[0-9]+')
    repeat=$(echo "$data" | grep -oP 'repeat=\K[0-9]+')
    age=$(echo "$data" | grep -oP 'age=\K[0-9]+')

    score=$(/opt/mail-guardian/core/engine.sh evaluate "0.0.0.0" "$user")

    [ $first -eq 0 ] && echo "," >> $OUT
    first=0

    echo "{
        \"user\":\"$user\",
        \"sent\":$sent,
        \"repeat\":$repeat,
        \"age\":$age,
        \"score\":$score
    }" >> $OUT

done < $STATE

echo "]" >> $OUT
