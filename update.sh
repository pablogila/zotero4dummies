# This script copies my current Obsidian notes as the README.md file, and pushes to GitHub.
#!/bin/bash

original="/home/pablo/Documents/obsidian/Work ⚛️/Instruments/Zotero.md"
final="README.md"
title="zotero4dummies update"
date=$(date +"%Y-%m-%d %H:%M")

if diff -q "$original" "$final" >/dev/null; then
    zenity --warning --text="No changes detected." --timeout=1 --no-wrap --title="$title"
    exit 0
fi

cp "$original" "$final"

(zenity --info --text="README.md updated. \nPushing to GitHub..." --timeout=1 --no-wrap --title="$title") &

# Check if the repo is updated
git fetch

if [ $(git rev-list HEAD...origin/master --count) -ne 0 ]; then
    (zenity --error --text="Changes detected in the remote repository. \nCheck it manually..." --no-wrap --title="$title") &
    exit 0
fi

git status
git add .
git commit -m "Automatic update from Obsidian on $date"

if [ $? -ne 0 ]; then
    (zenity --error --text="Git commit failed. \nCheck it manually..." --no-wrap --title="$title") &
    exit 0
fi

git push

# Check if the push was successful
if [ $? -ne 0 ]; then
    (zenity --error --text="Git push failed. \nCheck it manually..." --no-wrap --title="$title") &
    exit 0
fi

(zenity --info --text="✅ Done!" --timeout=1 --no-wrap --title="$title") &

