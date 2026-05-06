#!/bin/bash
source /etc/mail-guardian/main.conf
setup_firewall() {
    ipset create mail_guardian_block hash:ip timeout $BLOCK_TIME -exist
    iptables -C INPUT -m set --match-set mail_guardian_block src -j DROP 2>/dev/null || \
    iptables -I INPUT 1 -m set --match-set mail_guardian_block src -j DROP
}
block_ip() {
    local ip=$1
    local user=$2
    ipset add mail_guardian_block "$ip" -exist
    echo "[$(date)] BLOCK: $user ($ip)" >> "$LOG_FILE"
}
