#!/bin/bash
echo  -e "${note} Database ${dbname} Tables ==>"
         ls  ${path}/${dbname}
echo -e "${base}"        
read -p  "Enter Table Name To Select data : "  tablename
# check table exists
if [ -f $path"/"$dbname"/"$tablename ] ; then
    # check if contains record
    count=`cat $path"/"$dbname"/"$tablename | wc -l `
    if [[ $count > 2 ]] ; then
    # Ask to select all or by specific id
echo -e "${note} Select Record[s] : ${base}"
select type in "All" "By Id" "Exit"
do
case $type in 
"All" ) 
awk -F: '{ if(NR==1) print $0  } {if(NR>2) print $0  }  ' $path"/"$dbname"/"$tablename 
;;
"By Id" )
read -p "Enter Record id : " id
if [[  ! $id =~ ^[1-9][0-9]*$  ]] ; then
    echo -e "${invalid}  ID must be integer :) ${base}"
    source db_menu.sh;

else
# # search if first field is = id return entire record
row=`awk -F":" -v id=$id '{if($1==id) print $0}' $path"/"$dbname"/"$tablename`
    if [[ -z $row ]] ; then
            echo -e "${invalid} Record Not Found ${base}"
            source db_menu.sh;
    else
        awk -v id=$id -F":" '{if(NR>2 && $1==id) print $0}' $path"/"$dbname"/"$tablename 
    fi    
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
source db_menu.sh
else
    echo -e "${invalid} Table  ${tablename} Not Found ${base}"
    source db_menu.sh 
fi