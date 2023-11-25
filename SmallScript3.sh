#!/bin/bash

application_name="SmallScript2"

# Function for getting text informations
function get_text_info() {
    message="$1"
    object_name="$2"
    object=$(zenity --entry --title "$application_name" --text "$message" --height 120)
    if [ -z "$object" ]; then
        zenity --error --text "Empty filename was not accepted."
        exit
    fi
    eval "$object_name=\"$object\""
}

FILENAME=""
get_text_info "Give the filename:" FILENAME

CATALOG=""
get_text_info "Give the catalog name:" CATALOG

GROUP=""
get_text_info "Give the group name" GROUP

FILE_CONTENT=""
get_text_info "Give the file content:" FILE_CONTENT

# Functions for getting numerical informations
function get_numerical_info() {
    message="$1"
    object_name="$2"
    object=$(zenity --entry --title $application_name --text "$message")
    printf "%d" "$object" &> /dev/null
    if [[ $? -ne 0 ]] ; then
        echo "$object is not a number."
        zenity --error --text "Non numerical value is not accepted."
        exit
    fi
    if [[ $object -lt 0 || $object -gt 1000000 ]];
    then
        zenity --error --text "Wrong value"
        exit
    fi
    eval "$object_name=\"$object\""
}

MAX_SIZE=""
get_numerical_info "Give the maximum size of file in Kb" MAX_SIZE

MIN_SIZE=""
get_numerical_info "Give the minimum size of file in Kb" MIN_SIZE

# Print things which were selected
echo "Selected filename: $FILENAME"
echo "Selected catalog: $CATALOG"
echo "Selected group: $GROUP"
echo "Selected file content: $FILE_CONTENT"
echo "Selected maximum size of a file in Kb: $MAX_SIZE"
echo "Seleected minimum size of a file in Kb: $MIN_SIZE"

# Use selected options for searching
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



