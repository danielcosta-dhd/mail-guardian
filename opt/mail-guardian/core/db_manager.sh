#!/bin/bash
init_db() {
    sqlite3 "$STATE_DB" "CREATE TABLE IF NOT EXISTS stats (user TEXT PRIMARY KEY, sent_count INTEGER DEFAULT 0, last_seen TIMESTAMP DEFAULT CURRENT_TIMESTAMP);"
}
increment_user() {
    sqlite3 "$STATE_DB" "INSERT INTO stats (user, sent_count) VALUES ('$1', 1) ON CONFLICT(user) DO UPDATE SET sent_count = sent_count + 1, last_seen = CURRENT_TIMESTAMP;"
}
get_count() {
    sqlite3 "$STATE_DB" "SELECT sent_count FROM stats WHERE user='$1';"
}
