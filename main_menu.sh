#!/bin/bash
# exports red color for invalid operation and base for main color
export  invalid='\033[1;31m'
export  base='\033[0m' 
export  note='\033[0;34m' 
# main menu of engine.echo "drop"
# check if this is first time run script (create database dir)
if [ ! -d database ] 
then
mkdir database
fi

 # select menu
 

select option in "Create Database" "List Database" "Connect Database" "Drop Database" "Exit"
do
case $option in 

"Create Database" ) 
        source db_create.sh   ;;
"List Database" ) 
        source db_list.sh     ;;
"Drop Database" ) 
        source db_drop.sh     ;;
"Connect Database" )
        source db_connect.sh  ;;
"Exit" ) 
        break;;
* )
echo -e "$invalid Invalid Option $base";;
esac
done

 