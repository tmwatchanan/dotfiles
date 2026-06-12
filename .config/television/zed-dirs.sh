#!/bin/sh
# Source for the `dirs` television channel: Zed's recent projects
# (recency-ordered) followed by ~/dev directories, deduplicated,
# with deleted paths filtered out.
{
  sqlite3 -readonly "$HOME/Library/Application Support/Zed/db/0-stable/db.sqlite" \
    "SELECT paths FROM workspaces WHERE remote_connection_id IS NULL AND paths IS NOT NULL AND paths != '' ORDER BY timestamp DESC"
  fd --type d --max-depth 1 . "$HOME/dev"
} | sed 's:/*$::' | awk '!seen[$0]++' | while read -r d; do
  [ -d "$d" ] && echo "$d"
done
