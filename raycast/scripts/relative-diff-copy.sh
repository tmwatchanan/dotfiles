#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Relative diff & copy
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Number1" }
# @raycast.argument2 { "type": "text", "placeholder": "Number2" }

# Documentation:
# @raycast.description +Y%, copied to clipboard
# @raycast.author watchanan_chantapakul
# @raycast.authorURL https://raycast.com/watchanan_chantapakul

# Sanitize: strip thousands separators and whitespace (e.g. "10,300.20" -> 10300.20)
old_value=$(printf '%s' "$1" | tr -d ', ')
new_value=$(printf '%s' "$2" | tr -d ', ')

result=$(awk "BEGIN {
  rel = ($old_value == 0) ? 0 : (($new_value - $old_value) / $old_value) * 100
  printf \"%+.2f%%\", rel
}")

printf '%s' "$result" | pbcopy
echo "$result"
