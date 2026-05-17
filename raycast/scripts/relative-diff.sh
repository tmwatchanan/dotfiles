#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Relative diff
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Number1" }
# @raycast.argument2 { "type": "text", "placeholder": "Number2" }

# Documentation:
# @raycast.description +Y%
# @raycast.author watchanan_chantapakul
# @raycast.authorURL https://raycast.com/watchanan_chantapakul

old_value=$1
new_value=$2

rel_diff=$(awk "BEGIN { printf \"%.2f\", (($new_value - $old_value) / $old_value) * 100 }")

if awk "BEGIN { exit !($rel_diff > 0) }"; then
  rel_diff="+$rel_diff"
fi

echo "$rel_diff%"
