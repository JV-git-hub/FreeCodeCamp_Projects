#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

$PSQL "TRUNCATE TABLE games,teams;"
cat games.csv | while IFS="," read YEAR RND WIN OPP WING OPPG
do
  if [[ $YEAR != year ]]
  then
    #get team ids
    
    WIN_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WIN'")
    OPP_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPP'")
    
    #insert new team(s)
    if [[ -z $WIN_TEAM_ID ]]
    then
      INSERT_WIN_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WIN')")
      #get new winner team_id
      WIN_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WIN'")
    fi
    if [[ -z $OPP_TEAM_ID ]]
    then
      INSERT_OPP_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$OPP')" )
      #get new opponent team_id
      OPP_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPP'")
    fi

    #Insert game results into games
    INSERT_GM_RESULT=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$RND',$WIN_TEAM_ID,$OPP_TEAM_ID,$WING,$OPPG)")

  fi


done