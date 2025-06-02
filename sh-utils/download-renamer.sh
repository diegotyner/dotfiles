#!/usr/bin/env bash

# Usage: rn-dl <replacement_char> | Defaults to _
replacement="$1"
[[ -z "$replacement" ]] && replacement="_"

for file in "$HOME/Downloads/"*; do
    [ -e "$file" ] || continue

    base_name="$(basename "$file")"
    dir_name="$(dirname "$file")"

    # Detect if file has an extension
    if [[ "$base_name" == *.* ]]; then
        name_no_ext="${base_name%.*}"
        extension=".${base_name##*.}"
    else
        name_no_ext="$base_name"
        extension=""
    fi

    # Clean only the base (leave the dot in extension untouched)
    clean_name="${name_no_ext//[ ._-]/$replacement}"

    clean_name="$(echo "$clean_name" | sed -E "s/${replacement}{2,}/${replacement}/g")"

    new_name="${clean_name}${extension}"
    new_file="${dir_name}/${new_name}"
    echo "----"
    echo "Original:  $base_name"
    echo "To rename: ${new_file}"
    if [[ "$file" != "$new_file" ]]; then
        mv -n "$file" "$new_file"
    fi
done
