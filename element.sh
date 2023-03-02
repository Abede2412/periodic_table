#!/bin/bash
PSQL="psql -X -U freecodecamp -d periodic_table --tuples-only -c"
NOT_FOUND="I could not find that element in the database."

PRINT_ELEMENT(){
  if [[ -z $ELEMENTS ]]
  then
    echo $NOT_FOUND
  else
    echo "$ELEMENTS" | while read ATOMIC_NUM BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
    do
      echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    done
  fi
}


if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENTS=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where atomic_number = $1")
  elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
  then
    ELEMENTS=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where symbol = '$1'")
  else
    ELEMENTS=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where name = '$1'")
  fi
  PRINT_ELEMENT
fi




