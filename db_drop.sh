#!/bin/bash
# change working directory to database directory
 
read -p "Enter database name to drop : " dbname

if [[ -z $dbname || ! -d ./database/$dbname ]] ; then
echo -e "${invalid}  Database not Found ${base}"
else
rm -ir ./database/$dbname 
source main_menu.sh
fi
