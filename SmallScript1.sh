#!/bin/bash
cat cdlinux.ftp.log | cut -d '"' -f2,4 | sort | uniq | cut -d '"' -f2 | sed 's#.*/##' | sort | uniq -c | sort -n -r > ftp.txt
cat cdlinux.www.log | grep " 200 " | cut -d ' ' -f1,7 | sort | uniq | sed 's#.*/##' | sort | uniq -c | sort -n -r > www.txt

# Sort the files based on the second column
touch result.txt | echo "Result from ftp file" > result.txt | cat ftp.txt >> result.txt 
echo "Results from www file" >> result.txt | cat www.txt >> result.txt
