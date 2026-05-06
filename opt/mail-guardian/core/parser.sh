#!/bin/bash
source /etc/mail-guardian/main.conf
source /opt/mail-guardian/core/db_manager.sh
source /opt/mail-guardian/core/responder.sh
setup_firewall
init_db
tail -F "$MAIL_LOG" | while read -r line; do
    user=$(echo "$line" | grep -oP 'from=<\K[^>]+')
    ip=$(echo "$line" | grep -oP 'client=.*

\[\K[0-9.]+')
    if [ ! -z "$user" ]; then
        increment_user "$user"
        count=$(get_count "$user")
        if [ "$count" -gt "$MAX_EMAILS" ] && [ ! -z "$ip" ]; then
            block_ip "$ip" "$user"
        fi
    fi
done
