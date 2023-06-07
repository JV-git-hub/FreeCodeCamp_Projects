#!/bin/bash
# Script for searching database fpr element by atomic number, symbol, or name
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    QUERY=$($PSQL "SELECT * FROM elements WHERE atomic_number=$1;")
  else
    QUERY=$($PSQL "SELECT * FROM elements WHERE symbol='$1' OR name='$1' ;")
  fi
  
  if [[ -z $QUERY ]]
  then
    echo I could not find that element in the database.
  else
    echo $QUERY | while IFS="|" read ANUM SYM NAME
    do 
      PROPERTIES=$($PSQL "SELECT atomic_mass, melting_point_celsius, boiling_point_celsius, type_id FROM properties WHERE atomic_number=$ANUM;")
      echo $PROPERTIES | while IFS="|" read AMU MP BP T_ID
      do
        TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$T_ID;")
        echo "The element with atomic number $ANUM is $NAME ($SYM). It's a $TYPE, with a mass of $AMU amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
      done 
    done 
  fi
fi