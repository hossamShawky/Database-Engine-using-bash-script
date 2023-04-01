#!/bin/bash
cd ./database/$dbname

read -p  "Enter Table Name To Drop : "  tablename

if [ -f $tablename ] ; then
echo -e "${invalid}Are you sure to delete ${tablename} [y/n] : ${base}  " 
read ans
if [ $ans == "y" -o $ans == "Y" ] ; then 
rm $tablename
echo -e "${note} Table ${tablename} deleted succssfully. ${base}"
fi


cd ../..
source db_menu.sh
else

echo -e "${invalid} Table Not Found ${base}"
cd ../..
source db_menu.sh 
fi

