#!/bin/bash
cd ./database/$dbname
echo "Database ${dbname} Tables ==> " `ls` 

read -p  "Enter Table Name To Select data : "  tablename
# check table exists
if [ -f $tablename ] ; then


    # check if contains record
    if [[ `cat $tablename | wc -l ` > 2 ]] ; then

    # Ask to select all or by specific id
echo -e "${note} Select : ${base}"
select type in "All" "By Id" "Exit"
do
case $type in 

"All" ) 
awk -F: '{ if(NR==1) print $0  } {if(NR>2) print $0  }  ' $tablename 

# source ../../db_menu.sh
;;
"By Id" )
read -p "Enter Record id : " id

if [[  ! $id =~ ^[1-9][0-9]*$  ]] ; then
    echo -e "${invalid}  ID must be integer :) ${base}"
             cd ../.. ; source db_menu.sh;
else
# # search if first field is = id return entire record
awk -v id=$id -F":" '{if(NR>2 && $1==id) print $0}' $tablename 
fi

;;
"Exit" ) break ;;
* ) echo -e "${invalid} Invalid Option ${base} ";;


esac
done
# if table hasnot data
    else
    echo -e "${invalid} Table ${tablename} dose not contain any records ${base}"
    fi
cd ../..
source db_menu.sh
else
echo -e "${invalid} Table  ${tablename} Not Found ${base}"
cd ../..
source db_menu.sh 

fi



# awk -F: '{ if(NR==1) print $0  } {if(NR>2) print $0  }  ' $tablename 
