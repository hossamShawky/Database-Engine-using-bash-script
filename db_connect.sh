#!/bin/bash
# change working directory to database directory
 
read -p "Enter database name to connect : " dbname

if [[ -z $dbname || ! -d ./database/$dbname ]] ; then
echo -e "${invalid}  Database not Found ${base}"
else
export $dbname
source db_menu.sh
fi
