#!/bin/bash
echo  -e "${note} Database ${dbname} Tables ==>"
         ls  ${path}/${dbname}
echo -e "${base}"         

read -p  "Enter Table Name To Delete data : "  tablename
# check table exists 
if [ -f $path"/"$dbname"/"$tablename ] ; then
    # check if contains record
    count=`cat $path"/"$dbname"/"$tablename | wc -l ` 
    if [[ $count> 2 ]] ; then
    # Ask to delete all or by specific id
echo -e "${invalid} Delete : ${base}"
select type in "All" "By Id" "Exit"
do
case $type in 
"All" ) 
echo -e "${invalid}Are you sure to delete  all records ${tablename} [y/n] : ${base}  " 
read ans
if [ $ans == "y" -o $ans == "Y" ] ; then 
    sed -i '3,$d' $path"/"$dbname"/"$tablename 
    echo -e "${note} ${tablename} Records deleted succssfully. ${base}"
    source db_menu.sh;
fi
;;
"By Id" )
    read -p "Enter Record id : " id
if [[  ! $id =~ ^[1-9][0-9]*$  ]] ; then
    echo -e "${invalid}  ID must be integer :) ${base}"
    source db_menu.sh;
else
# delete now
row=`awk -F":" -v id=$id '{if($1==id) print $0}' $path"/"$dbname"/"$tablename`
        if [[ -z $row ]] ; then
            echo -e "${invaild} Record Not Found ${base}"
            source db_menu.sh;
        else
        echo -e "${invalid}Are you sure to delete Record ${row} [y/n] : ${base}  " 
        read ans
        if [ $ans == "y" -o $ans == "Y" ] ; then 
            sed -i '/'${row}'/d' $path"/"$dbname"/"$tablename
            echo -e "${note} Record deleted from ${tablename}  succssfully. ${base}"
        fi
          source db_menu.sh;
        fi

fi
;;
"Exit" ) break 
    source db_menu.sh ;;
* ) 
echo -e "${invalid} Invalid Option ${base} "
source db_menu.sh;
;;
esac
done
    # table is empty
    else
    echo -e "${invalid} Table ${tablename} dose not contain any records ${base}"
    source db_menu.sh
fi
# table not exit
else
    echo -e "${invalid} Table  ${tablename} Not Found ${base}"
    source db_menu.sh 
fi