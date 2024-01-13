#!/bin/bash

for input_dir in in/*; do
    if [ -d "$input_dir" ]; then
        output_dir="out/$(basename "$input_dir")"
        mkdir -p "$output_dir"

        for input_file in "$input_dir"/*; do
            if [ -f "$input_file" ]; then
                filename=$(basename "$input_file")
                filename_without_extension="${filename%.*}"
                output_file="$output_dir/list.txt"

                while IFS= read -r line; do
                    lowercase_line="${line,,}"
                    lowercase_filename="${filename_without_extension,,}"
                    echo "${lowercase_filename}-${lowercase_line}" >> "$output_file"
                done < "$input_file"
            fi
        done
    fi
done

