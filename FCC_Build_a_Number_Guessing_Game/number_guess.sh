#!/bin/bash
#Number guessing game
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"


echo Enter your username:
read USERNAME

until [[ $UN_LENGTH -le 22 ]]
do
  echo Your username should be 22 characters or less.
  echo Enter your username:
  read USERNAME
  UN_LENGTH=${#USERNAME}
done

QUERY=$($PSQL "SELECT * FROM users WHERE username='$USERNAME';")

TOTAL_GAMES=0
BEST_GAME=10000000
if [[ -z $QUERY ]]
then  
  NEW_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME');")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  IFS="|" read -r -a QUERY_ARRAY <<< "${QUERY}"
  
  TOTAL_GAMES=${QUERY_ARRAY[2]}
  BEST_GAME=${QUERY_ARRAY[3]}
  echo "Welcome back, $USERNAME! You have played $TOTAL_GAMES games, and your best game took $BEST_GAME guesses." 
fi

RANDOM_NUMBER=$(( RANDOM%1000 + 1 ))
GUESS_STATUS=false
TURNS=0


echo Guess the secret number between 1 and 1000:
read GUESS

until [[ $GUESS_STATUS == "true" ]]
do
  
  if [[ $GUESS =~ ^[0-9]+$ ]]
  then
    (( TURNS++ ))
    if [[ $GUESS -eq $RANDOM_NUMBER ]]
    then
      GUESS_STATUS=true
    elif [[ $GUESS -lt $RANDOM_NUMBER ]]
    then
      echo "It's higher than that, guess again:"
      read GUESS
    else
      echo "It's lower than that, guess again:"
      read GUESS
    fi
  else
    echo That is not an integer, guess again:
    read GUESS
  fi
done

(( TOTAL_GAMES++ ))
if [[ $TURNS -lt $BEST_GAME ]]
then
  UPDATE_BOTH=$($PSQL "UPDATE users SET best_game=$TURNS, total_games=$TOTAL_GAMES WHERE username='$USERNAME';")
  
else
  
  UPDATE_TOTAL_GAMES=$($PSQL "UPDATE users SET total_games=$TOTAL_GAMES WHERE username='$USERNAME';")
fi

echo "You guessed it in $TURNS tries. The secret number was $RANDOM_NUMBER. Nice job!"
