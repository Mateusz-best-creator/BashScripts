#!/bin/bash

USER_SYMBOL="X"
AI_SYMBOL="O"

BOARD_SYMBOLS=("1" "2" "3" "4" "5" "6" "7" "8" "9")

# This function draw the board for tic tac toe game
function draw_board() {
    # I use echo -e beacuse "normal" echo doesn't support tabs and new lines
    echo -e "You: ${USER_SYMBOL}, AI: $AI_SYMBOL"
    echo -e "\n\t${BOARD_SYMBOLS[0]} | ${BOARD_SYMBOLS[1]} | ${BOARD_SYMBOLS[2]}"
    echo -e "\t---+---+---"
    echo -e "\t${BOARD_SYMBOLS[3]} | ${BOARD_SYMBOLS[4]} | ${BOARD_SYMBOLS[5]}"
    echo -e "\t---+---+---"
    echo -e "\t${BOARD_SYMBOLS[6]} | ${BOARD_SYMBOLS[7]} | ${BOARD_SYMBOLS[8]}\n"
}

draw_board

function user_place_symbol() {
    echo "Enter your symbol: "
    read USER_INPUT
    
    # Check if input is valid
    if [[ USER_INPUT -gt 9 || USER_INPUT -lt 1 ]]; then
        echo "Invalid input, it should be between 1-9"

    # Check if player is able to place his pawn here
    elif [[ %{BOARD_SYMBOLS[USER_INPUT]} == $USER_SYMBOL ]]; then
        echo "This place is arleady occupied by you pawn ($USER_SYMBOL)"
    elif [[ ${BOARD_SYMBOLS[USER_INPUT]} == $AI_SYMBOL ]]; then
        echo "This place is arleady occupied by AI pawn ($AI_SYMBOL)"

    # Otherwise we can insert the pawn
    else
        BOARD_SYMBOLS[$((USER_INPUT - 1))]=$USER_SYMBOL
    fi
}

function AI_place_symbol() {
    # Generate a random index between 1 and 9
    RANDOM_INDEX=$((1 + RANDOM % 9))

    while [[ %{BOARD_SYMBOLS[RANDOM_INDEX]} == $USER_SYMBOL || %{BOARD_SYMBOLS[RANDOM_INDEX]} == $AI_SYMBOL ]]; do
        RANDOM_INDEX=$((1 + RANDOM % 9))
    done

    # Once we have valid index, we can insert AI symbol there
    BOARD_SYMBOLS[$((RANDOM_INDEX - 1))]=$AI_SYMBOL
}

PLAYER_WON="0"
function player_won() {

}

AI_WON="0"
function AI_won() {

}

while [[ true ]]; do
    
    # Check if player won the game
    if [[ PLAYER_WON == "1" ]]; then
        echo "Player win"
        break

    # Check if AI won the game
    if [[ AI_WON == "1" ]];then
        echo "AI win"
        break
    
done

user_place_symbol
draw_board
AI_place_symbol
draw_board