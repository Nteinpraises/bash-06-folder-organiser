#!/bin/bash

folder="${1:-.}"

if [[ ! -d "$folder" ]]; then
    echo "Error: folder '$folder' does not exist" >&2
    exit 1
fi

moved=0

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
    
    
    dest="$folder/$category/$name"
    n=1
    while [[ -e "$dest" ]]; do
        if [[ "$name" == *.* ]]; then
            dest="$folder/$category/${name%.*}($n).${name##*.}"
        else    
            dest="$folder/$category/${name}($n)"
        fi
        (( n++ ))
    done
    mv "$file" "$dest"

    (( moved++ ))

    echo " $name -> $category/"
done

echo "Done: $moved files moved"