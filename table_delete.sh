#!/bin/bash
cd ./database/$dbname
echo "Database ${dbname} Tables ==> " `ls ` 

read -p  "Enter Table Name To Delete data : "  tablename
# check table exists
 
if [ -f $tablename ] ; then
    # check if contains record
    if [[ `cat $tablename | wc -l ` > 2 ]] ; then
    # Ask to delete all or by specific id
echo -e "${invalid} Delete : ${base}"
select type in "All" "By Id" "Exit"
do
case $type in 
"All" ) 
echo -e "${invalid}Are you sure to delete  all records ${tablename} [y/n] : ${base}  " 
read ans
if [ $ans == "y" -o $ans == "Y" ] ; then 

sed -i '3,$d' $tablename

echo -e "${note} ${tablename} records deleted succssfully. ${base}"

cd ../.. ; source db_menu.sh;

fi

;;
"By Id" )
read -p "Enter Record id : " id

if [[  ! $id =~ ^[1-9][0-9]*$  ]] ; then
    echo -e "${invalid}  ID must be integer :) ${base}"
             cd ../.. ; source db_menu.sh;
else
# delete now

row=`awk -F":" -v id=$id '{if($1==id) print $0}' $tablename`

        if [[ -z $row ]] ; then
            echo -e "${invaild} Record Not Found ${base}"
            cd ../.. ; db_menu.sh;
        else

        echo -e "${invalid}Are you sure to delete Record ${row} [y/n] : ${base}  " 
        read ans
        if [ $ans == "y" -o $ans == "Y" ] ; then 
 
        sed -i '/'${row}'/d' $tablename
        cd ../.. ; source db_menu.sh;
        echo -e "${note} Table ${tablename} deleted succssfully. ${base}"
        cd ../.. ; source db_menu.sh;
        else echo "";
            cd ../.. ; source db_menu.sh;
        fi



fi

fi
;;
"Exit" ) break 
 cd ../.. ; source db_menu.sh ;;
* ) 
echo -e "${invalid} Invalid Option ${base} "
 cd ../.. ; source db_menu.sh;
;;

esac
done
    # table is empty
    else
    echo -e "${invalid} Table ${tablename} dose not contain any records ${base}"
    cd ../.. ; source db_menu.sh
fi
# table not exit
else
echo -e "${invalid} Table  ${tablename} Not Found ${base}"
 cd ../.. ; source db_menu.sh 
fi
