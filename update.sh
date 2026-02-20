#!/usr/bin/env bash

set -eux

zip_path=$(
  find ~/Downloads/ -regextype posix-extended -regex '.*/twitter-[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9a-f]{64}\.zip' |
  LANG=C sort |
  tail -n1
)

[ -e "$zip_path" ]

zip_date=$(basename "$zip_path" | sed -E 's/twitter-([0-9]{4}-[0-9]{2}-[0-9]{2})-[0-9a-f]{64}\.zip/\1/')

git rm -rf assets/ data/ index.html || true
rm -rf assets/ data/ index.html || true

unzip "$zip_path"

mv "Your archive.html" index.html

git add assets/ data/ index.html

git commit -m "update $zip_date"

echo "todo:"
echo "  rm $zip_path"
