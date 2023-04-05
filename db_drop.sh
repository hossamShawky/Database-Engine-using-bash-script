#!/bin/bash
# get database name&check
read -p "Enter database name to drop : " dbname
# convert every space to _
while [[ $dbname == *" "* ]] ; do
    dbname="${dbname/ /_}"    
done

if [[ -z $dbname || ! -d $path"/"$dbname ]] ; then
    echo -e "${invalid}  Database ${dbname} not Found ${base}"
else
    echo -e "${invalid} Are you sure to delete ${dbname} [y/n] : ${base}  " 
    read ans
    if [ $ans == "y" -o $ans == "Y" ] ; then 
        rm -r $path"/"$dbname 
        echo -e "${note} Database ${dbname} deleted succssfully. ${base}"
    fi
fi
source main_menu.sh