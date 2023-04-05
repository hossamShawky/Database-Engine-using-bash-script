#!/bin/bash
echo  -e "${note} Database ${dbname} Tables ==>"
         ls  ${path}/${dbname}
echo -e "${base}"         
 read -p  "Enter Table Name To Insert data : "  tablename
# check table exists
if [ -f $path"/"$dbname"/"$tablename ] ; then
# echo -e "${note} Insert Into ${dbname}/${tablename} ${base} " 
# get Columns name from table
 colNames=`cut -d ':' -f 1- $path"/"$dbname"/"$tablename`
 IFS=':' read -ra colArray <<< $colNames
# echo "Names" ${colArray[@]}
# get Columns data types from table [second record]
# colTypes=`head -2 $tablename | tail -1 | cut -d ':' -f 1- `
# using awk
types=`awk -F":" '{if(NR==2) print $0}'  $path"/"$dbname"/"$tablename `
IFS=':' read -ra typeArray <<< $types
echo "Types" ${typeArray[@]}
# echo "Types" ${typeArray[@]}
# Note that first field [id => integer => PK]
# get All Pks in table
pks=(`awk -F":" '{if(NR>2) print $1}' $path"/"$dbname"/"$tablename `)
# echo ${pks[@]}
# define record to store inputs
record=() 
for (( i=0;i<${#colArray[@]};i++))
do
# check PK
if [[ ${colArray[$i]} == "id" ]] ; then
    echo "Enter " ${colArray[$i]} "["${typeArray[$i]}"&Unique] Value "  
    read value
        if [[  ${pks[@]} =~  $value  ]] ; then
        echo -e "${invalid}  ID must be unique :) ${base}"
        source db_menu.sh;
        elif [[  $value -le 0 || ! $value =~ ^[1-9][0-9]*$  ]] ; then
        echo -e "${invalid}  ID must be integer :) ${base}"
        source db_menu.sh;
        else
        record[$i]=$value
        fi
# remaining fields
else
    echo "Enter " ${colArray[$i]} "["${typeArray[$i]}"] Value "  
    read value
# check datatype
# string datatype
if [[ ${typeArray[$i]} = "string" ]] ;  then
    if [[ ! $value == *[a-zA-z0-9]* ]] ; then      
        echo -e "${invalid}" ${colArray[$i]} " must be string :) ${base}"
        source db_menu.sh;
    else
    # convert every space to _
    while [[ $value == *" "* ]] ; do
    value="${value/ /_}"    
    done
    # end convert
            record[$i]=$value
    fi
# Integer
elif [[ ${typeArray[$i]} = "integer" ]] ;  then
    if [[ ! $value =~ ^[0-9]*$ ]] ; then
        echo -e "${invalid}" ${colArray[$i]} " must be integer :) ${base}"
        source db_menu.sh;
    else
            record[$i]=$value
    fi    
fi
# end if => loop remaining names
fi
done
# echo "Your record => " ${record[@]}
echo "---------------------"
data=""
for item in ${record[@]} 
do
data+=$item":"
done
# remove last :
    data="${data%?}"
    echo $data >>  $path"/"$dbname"/"$tablename
    echo -e "${note} Inserted Succsfully" $data "${base}" 
source db_menu.sh 
# Table not found
else
echo -e "${invalid} Table  ${tablename} Not Found ${base}"
source db_menu.sh 
fi