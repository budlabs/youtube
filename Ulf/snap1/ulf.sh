#!/usr/bin/env bash

f="$1"

[[ -f "$f" ]] || { echo "the file $f doesn't exist" && exit 1 ;}

url="$(curl -sF "file=@${f}" https://0x0.st)"

notify-send "$f successfully uploaded to $url"

echo -n "$url" | xsel --input
echo -n "$url" | xsel --input --clipboard

# argument is file
# test if file exist, exit if it doesn't
# upload file ("$1") to 0x0
# notification on success
# url in clipboard (xsel --input --clipboard)
# and primary (--output | xsel --input --primary)
# notification on failure...

