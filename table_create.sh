#!/bin/bash
cd ./database/$dbname
# change directory to exported tablename

 read -p "Enter table name : " tablename

# check input(tablename) syntax
while [[ -z $tablename || $tablename =~ ^[0-9] || $tablename == *['!''@#/$\"*{^})(+|,;:~`.%&/=-]>[<?']* ]]  
do
echo -e "$invalid Invaild Name $base"
read -p "Enter table name : " tablename
done

# convert every space to _
while [[ $tablename == *" "* ]] ; do
tablename="${tablename/ /_}"    
done


if [ -f $tablename ] ; then
echo "Table already exists" 
else
touch $tablename
echo "Table created succssfully"
fi



# back to database menu
cd ../..
 