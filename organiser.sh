#!/bin/bash

folder="${1;-.}"

if [[ ! -d "$folder" ]]; then
    echo "Error: folder '$folder' does not exist" >&2
    exit 1
fi

for file in "$folder"/*; do
    [[ -f "$file" ]] || continue

    name=$(basename "$file")

    if [[ "$name" == *.* ]]; then
        ext="${name##*.}"
        ext="${ext,,}"
    else
        ext=""
    fi

    case "$ext" in
        jpg|jpeg|png|gif|webp) category="Images" ;;
        pdf|doc|docx|txt|xlsx|pptx) category="Documents" ;;
        mp3|wav|m4a) category="Audio" ;;
        mp4|mkv|mov) category="Video" ;;
        zip|rar|tar|gz) category="Archives" ;;
        *) category="Other" ;;
    esac

    mkdir -p "$folder/$category"
    mv "$file" "$folder/$category/"
    echo " $name -> $category/"
done