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

function user_place_symbol() {    
    while [[ true ]]; do
    
        echo "Enter your symbol: "
        read USER_INPUT

        # Check if input is valid
        if [[ USER_INPUT -gt 9 || USER_INPUT -lt 1 ]]; then
            echo "Invalid input, it should be between 1-9"
            continue
    
        # Check if player is able to place his pawn here
        elif [[ ${BOARD_SYMBOLS[$((USER_INPUT - 1))]} == $USER_SYMBOL ]]; then
            echo "This place is arleady occupied by your pawn ($USER_SYMBOL)"
            continue
        elif [[ ${BOARD_SYMBOLS[$((USER_INPUT - 1))]} == $AI_SYMBOL ]]; then
            echo "This place is arleady occupied by AI pawn ($AI_SYMBOL)"
            continue

        # Otherwise we can insert the pawn
        else
            BOARD_SYMBOLS[$((USER_INPUT - 1))]=$USER_SYMBOL
            break
        fi
    done
}

function AI_place_symbol() {
    # Generate a random index between 1 and 9
    RANDOM_INDEX=$((1 + RANDOM % 9))

    while [[ ${BOARD_SYMBOLS[$((RANDOM_INDEX - 1))]} == $USER_SYMBOL || ${BOARD_SYMBOLS[$((RANDOM_INDEX - 1))]} == $AI_SYMBOL ]]; do
        RANDOM_INDEX=$((1 + RANDOM % 9))
    done

    # Once we have valid index, we can insert AI symbol there
    BOARD_SYMBOLS[$((RANDOM_INDEX - 1))]=$AI_SYMBOL
}

PLAYER_WON="0"
AI_WON="0"
function check_if_won() {
    SYMBOL=$1
    if [[ (${BOARD_SYMBOLS[0]} == $SYMBOL && ${BOARD_SYMBOLS[1]} == $SYMBOL && ${BOARD_SYMBOLS[2]} == $SYMBOL) ||
          (${BOARD_SYMBOLS[3]} == $SYMBOL && ${BOARD_SYMBOLS[4]} == $SYMBOL && ${BOARD_SYMBOLS[5]} == $SYMBOL) || 
          (${BOARD_SYMBOLS[6]} == $SYMBOL && ${BOARD_SYMBOLS[7]} == $SYMBOL && ${BOARD_SYMBOLS[8]} == $SYMBOL) || 
          (${BOARD_SYMBOLS[0]} == $SYMBOL && ${BOARD_SYMBOLS[3]} == $SYMBOL && ${BOARD_SYMBOLS[6]} == $SYMBOL) || 
          (${BOARD_SYMBOLS[1]} == $SYMBOL && ${BOARD_SYMBOLS[4]} == $SYMBOL && ${BOARD_SYMBOLS[7]} == $SYMBOL) ||
          (${BOARD_SYMBOLS[2]} == $SYMBOL && ${BOARD_SYMBOLS[5]} == $SYMBOL && ${BOARD_SYMBOLS[8]} == $SYMBOL) ||
          (${BOARD_SYMBOLS[0]} == $SYMBOL && ${BOARD_SYMBOLS[4]} == $SYMBOL && ${BOARD_SYMBOLS[8]} == $SYMBOL) || 
          (${BOARD_SYMBOLS[2]} == $SYMBOL && ${BOARD_SYMBOLS[4]} == $SYMBOL && ${BOARD_SYMBOLS[6]} == $SYMBOL) ]]; then
        echo "1"
    else
        echo "0"
    fi
}

INDEX_WHO_START=0
function who_start() {
    RANDOM_PLAYER_INDEX=$((RANDOM % 2))
    if [[ RANDOM_PLAYER_INDEX -eq 0 ]]; then
        INDEX_WHO_START=0
    else
        INDEX_WHO_START=1
    fi
}

# First run this function to randomly chose who begins
who_start

if [[ INDEX_WHO_START -eq 0 ]]; then
    echo "Player starts the game"
elif [[ INDEX_WHO_START -eq 1 ]]; then
    echo "AI starts the game"
fi

PAWNS_ON_BOARD=0

while [[ true ]]; do

    draw_board
    if [[ INDEX_WHO_START -eq 0 ]]; then

        # Check if player won the game
        if [[ $PLAYER_WON == "1" ]]; then
            echo "Player win"
            break
        # Check if AI won the game
        elif [[ $AI_WON == "1" ]];then
            echo "AI win"
            break
        fi

    else
        # Check if AI won the game
        if [[ $AI_WON == "1" ]];then
            echo "AI win"
            break
        # Check if player won the game
        elif [[ $PLAYER_WON == "1" ]]; then
            echo "Player win"
            break
        fi
    fi

    # Based on who starts the game we make moves
    if [[ $INDEX_WHO_START -eq 0 ]]; then

        user_place_symbol
        PAWNS_ON_BOARD=$((PAWNS_ON_BOARD + 1))

        draw_board
        PLAYER_WON=$(check_if_won "X")
        # Check if AI won the game
        if [[ $PLAYER_WON == "1" ]];then
            echo "Player win"
            break
        fi
        # Check for draw
        if [[ $PAWNS_ON_BOARD -eq 9 ]]; then
            echo "Draw"
            draw_board
            break
        fi
        AI_place_symbol
        PAWNS_ON_BOARD=$((PAWNS_ON_BOARD + 1))
    else
        AI_place_symbol
        PAWNS_ON_BOARD=$((PAWNS_ON_BOARD + 1))

        draw_board
        AI_WON=$(check_if_won "O")
        
        # Check if AI won the game
        if [[ $AI_WON == "1" ]];then
            echo "AI win"
            break
        fi
        if [[ $PAWNS_ON_BOARD -eq 9 ]]; then
            echo "Draw"
            break
        fi
        user_place_symbol
        PAWNS_ON_BOARD=$((PAWNS_ON_BOARD + 1))
    fi

    PLAYER_WON=$(check_if_won "X")
    AI_WON=$(check_if_won "O")

done