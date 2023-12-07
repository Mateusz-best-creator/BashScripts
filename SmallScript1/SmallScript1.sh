#!/bin/bash
cat cdlinux.ftp.log | cut -d '"' -f2,4 | sort | uniq | cut -d '"' -f2 | sed 's#.*/##' | sort | uniq -c | sort -n -r > ftp.txt
cat cdlinux.www.log | grep " 200 " | cut -d ' ' -f1,7 | sort | uniq | sed 's#.*/##' | sort | uniq -c | sort -n -r > www.txt

# Initialize an associative array
declare -A records

# Read data from the first file and populate the array
while read -r number name; do
    if [ -n "$name" ]; then
        records["$name"]=$number
    fi
# "<" symbol means that we will read data from ftp.txt file
done < ftp.txt

# Read data from the second file and update the array
while read -r number name; do
    # For non empty names
    if [ -n "$name" ]; then
        if [ -n "${records[$name]}" ]; then
            # Name already exists, add the numbers
            records["$name"]=$((records["$name"] + number))
        else
            # Name doesn't exist, add a new entry and corresponding number
            records["$name"]=$number
        fi
    fi
# "<" symbol means that we will read data from www.txt file
done < www.txt


# Print the updated array
for key in "${!records[@]}"; do
    echo "[$key] = ${records[$key]}"
done
