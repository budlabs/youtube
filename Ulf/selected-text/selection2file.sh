#!/usr/bin/env bash

f="${1:-/tmp/selectedtext}"

xsel --output > "$f"

echo "$f"

# use xsel --output to get selection
# redirect to $file ($1)
# print path to file to stdout
