#!/bin/bash
# get table name&check
read -p  "Enter Table Name To Drop : "  tablename
if [ -f $path"/"$dbname"/"$tablename -a ! -z $tablename ] ; then
echo -e "${invalid}Are you sure to delete ${tablename} [y/n] : ${base}  " 
read ans
    if [ $ans == "y" -o $ans == "Y" ] ; then 
    rm $path"/"$dbname"/"$tablename
    echo -e "${note} Table ${tablename} deleted succssfully. ${base}"
    fi
source db_menu.sh
elif [[ -z $tablename || ! -f $path"/"$dbname"/"$tablename  ]] ; then
    echo -e "${invalid} Table Not Found ${base}"
    source db_menu.sh 
fi