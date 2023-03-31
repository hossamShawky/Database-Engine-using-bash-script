#!/bin/bash

# change working directory to database directory
cd ./database/
# create new database if it`s not exist and vaild name
read -p "Enter database name : " dbname
# check input(dbname) syntax
while [[ -z $dbname || $dbname =~ ^[0-9] || $dbname == *['!''@#/$\"*{^})(+|,;:~`.%&/=-]>[<?']* ]]  
do
echo -e "$invalid Invaild Name $base"
read -p "Enter database name : " dbname
done

# convert every space to _
while [[ $dbname == *" "* ]] ; do
dbname="${dbname/ /_}"    
done


if [ -d $dbname ] ; then
echo "database already exists" 
else
mkdir $dbname
echo "Database created succssfully"
fi

# return back to main directory&menu
cd ..   
# source main_menu.sh