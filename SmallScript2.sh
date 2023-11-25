#!/bin/bash

OPTION=0
GROUP="mateusz"
CATALOG="."

# FILENAME=$1
# CATALOG=$2
# GROUP=$3
# FILE_CONTENT=$4

function display_options {
    echo """
    All available options
        [0] -> display all available options in this script
        [1] -> chose the name for your file
        [2] -> chose the catalog where your file should be
        [3] -> chose the minimal size(kb) of your file
        [4] -> chose the maximal size(kb) of your file
        [5] -> chose the group that your file belongs to
        [6] -> chose the file content that should be inside your file
        [7] -> search for a file based on given options
        [8/anything else] -> quit the program
    """
}
# Display all available options also at the beginning
display_options


while [ $OPTION -ne 8 ]; do
    read OPTION
    if [ $OPTION -eq 0 ]; then
        display_options

    elif [ $OPTION -eq 1 ]; then
        echo "Enter filename = "
        read FILENAME
        echo "Chosen filename = $FILENAME"
    
    elif [ $OPTION -eq 2 ]; then
        echo "Enter catalog = "
        read CATALOG
        echo "Chosen catalog = $CATALOG"

    elif [ $OPTION -eq 3 ]; then
        echo "Enter minimum size in KB = "
        read MIN_SIZE
        echo "Chosen mininal size of the file(KB) = $MIN_SIZE kb"

    elif [ $OPTION -eq 4 ]; then
        echo "Enter maximum size in KB = "
        read MAX_SIZE
        echo "Chosen maximum size of the file(KB) = $MAX_SIZE kb"

    elif [ $OPTION -eq 5 ]; then
        echo "Enter a group that a file should belong to = "
        read GROUP
        echo "Chosen group that file belongs to = $GROUP"

    elif [ $OPTION -eq 6 ]; then
        echo "Enter file content that we will display if it will be found = "
        read FILE_CONTENT
        echo "Chosen file content = $FILE_CONTENT"

    elif [ $OPTION -eq 7 ]; then
        echo "Searching..."
        RESULT_DIRECTORY=$(find "$CATALOG" -name $FILENAME -size +$MIN_SIZE -a -size -$MAX_SIZE -group $GROUP)
        echo "Results = $RESULT_DIRECTORY"

        # Case where file exists
        if [ -n RESULT_DIRECTORY ]; then
            echo "$FILENAME in directory $CATALOG between gives sizes = [$MIN_SIZE kb - $MAX_SIZE kb] that belongs to $GROUP group exists."

            # Search for a specific pattern inside directory
            RESULT_GREP=$(grep -n -r $FILE_CONTENT $RESULT_DIRECTORY)
            echo """Grep results = 
            $RESULT_GREP"""

        # Case where file doesn't exist
        else
            echo "$FILENAME in directory $CATALOG between gives sizes = [$MIN_SIZE kb - $MAX_SIZE kb] that belongs to $GROUP group doesn't exist."
        fi

    else
        echo "BYE" 

    fi
done
