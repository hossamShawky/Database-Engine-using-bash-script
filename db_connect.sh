#!/bin/bash
read -p "Enter database name to connect : " dbname
# convert every space to _
while [[ $dbname == *" "* ]] ; do
    dbname="${dbname/ /_}"    
done

if [[ -z $dbname || ! -d $path"/"$dbname ]] ; then
echo -e "${invalid}  Database not Found ${base}"
source main_menu.sh
else
export $dbname
source db_menu.sh
fi
