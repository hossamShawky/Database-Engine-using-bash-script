#!/bin/bash
# get dbname and check syntax
read -p "Enter database name : " dbname
while [[ -z $dbname || $dbname =~ ^[0-9] || $dbname == *['!''@#/$\"*{^})(+|,;:~`.%&/=-]>[<?']* ]]  
do
    echo -e "${invalid} Invaild Name  ${base}"
    read -p "Enter database name : " dbname
done
# convert every space to _
while [[ $dbname == *" "* ]] ; do
    dbname="${dbname/ /_}"    
done
# check if db exists
if [ -d $path"/"$dbname ] ; then
    echo -e "${invalid} Database ${dbname} already exists ${base}" 
else
mkdir $path"/"$dbname
echo  -e "${note} Database ${dbname} created succssfully ${base}"
fi

source main_menu.sh