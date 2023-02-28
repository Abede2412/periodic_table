#!/bin/bash

PSQL="psql -X -U freecodecamp -d periodic_table --tuples-only -c"
NOT_FOUND="I could not find that element in the database."

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENTS=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where atomic_number = $1")
    if [[ -z $ELEMENTS ]]
    then
      echo $NOT_FOUND
    else
      echo "$ELEMENTS"
    fi
  fi
fi




