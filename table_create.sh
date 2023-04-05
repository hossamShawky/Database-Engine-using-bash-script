#!/bin/bash
# get table name&check
read -p "Enter table name : " tablename
while [[ -z $tablename || $tablename =~ ^[0-9] || $tablename == *['!''@#/$\"*{^})(+|,;:~`.%&/=-]>[<?']* ]]  
do
echo -e "$invalid Invaild Name $base"
read -p "Enter table name : " tablename
done
# convert every space to _
while [[ $tablename == *" "* ]] ; do
tablename="${tablename/ /_}"    
done

if [ -f $path"/"$dbname"/"$tablename ] ; then
echo -e "${invalid} Table ${tablename} already exists ${base}" 
else
touch $path"/"$dbname"/"$tablename
echo -e "${note} Table ${tablename} created succssfully ${base}"
# create metadata of table
read -p "Enter Num.Of Columns For Table ${tablename} : " numCols
# check if input is valid [number]
#try convert input to integer

while ! [[ $numCols =~ ^[1-9][0-9]*$  ]]
do
echo -e "$invalid Invaild Number $base"
read -p "Enter Num.Of Columns For Table ${tablename} : " numCols
done
# convert numCols to intger [enable us to operate]
let numCols=$numCols
# by default first field name:id & constraint:PK
# loop until numCols to get table columns name&type [string&int]
echo -e "${note}Note that first column name is id and it is PK ${base}"
record_name=''
record_type=''
for ((i=2;i<=$numCols;i++))
 do
    read -p "Enter Column ${i} Name : " colName
# start check col name
    while [[ -z $colName || $colName =~ ^[0-9] || $colName == *['!''@#/$\"*{^})(+|,;:~`.%&/=-]>[<?']* ]]  
    do
            echo -e "${invalid} Invaild colName ${base}"
            read -p "Enter Column Name : " colName
    done
# end check col name
# convert every space to _
    while [[ $colName == *" "* ]] ; do
    colName="${colName/ /_}"    
    done
# end convert
# check if colName found or not 
    while [[ $record_name  == *"${colName}"* ]] ; do
    echo -e "${invalid} Filed ${colName} FOUND ${base}"
    read -p "Enter Column ${i} Name : " colName
    done
 # set 1st col=> id:primary key => if this first loop iteration
# not ? append new column name
    if [ $i -eq 2 ] ; then   #check
            record_name+="id:"$colName
    else
            record_name+=":"$colName
    fi
    # end append col name to record
done
# write columns name in table file
    echo $record_name >> $path"/"$dbname"/"$tablename
#  Get Columns Name Data Types
echo -e "${note} Enter Data Types [string|integer] ${base}"
# get Columns name from table
colNames=`cut -d ':' -f 2-$numCols $path"/"$dbname"/"$tablename`
IFS=':' read -ra colArray <<< $colNames
let c=0
for ((i=2;i<=$numCols;i++))
do
echo "*** Enter data type for [" ${colArray[$c]} "] filed : "
c+=1
# only support string and integer
select choice in "string" "integer"
do
case $choice in
"string" ) 
			if [ $i -eq 2 ]
			then 
			record_type=integer:string
            else
			record_type+=:string
	    	fi
		break;;
"integer" )
if [ $i -eq 2 ] ; then
	record_type=integer:integer
	else 
	record_type+=:integer
fi
break ;;		
* )
		echo -e " ${invalid} Invaild data type ${base}"
		continue;;
esac
# end select
done
# end for
done
echo $record_type >> $path"/"$dbname"/"$tablename
echo -e "${note} Your table meta data is : \n $record_name \n $record_type ${base}"
fi
source db_menu.sh