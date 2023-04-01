#!/bin/bash
cd ./database/$dbname

read -p  "Enter Table Name To Update data : "  tablename
# check table exists
 
if [ -f $tablename ] ; then
    # check if contains record
    if [[ `cat $tablename | wc -l ` > 2 ]] ; then   
#   ------------------------------------------  #
# get Columns name from table
colNames=`cut -d ':' -f 2- $tablename`
IFS=':' read -ra colArray <<< $colNames
# echo "Names" ${colArray[@]}
# get Columns data types from table [second record]
typeArray=`head -2 $tablename | tail -1 | cut -d ':' -f 2- `
IFS=':' read -ra dataType <<< $typeArray

# echo "Types" ${typeArray[@]}
#   ------------------------------------------  #

read -p "Enter Record Id : " id

if [[  ! $id =~ ^[1-9][0-9]*$  ]] ; then
    echo -e "${invalid}  ID must be integer :) ${base}"
             cd ../.. ; source db_menu.sh;
else
# # search if first field is = id return entire record
echo ${colArray[@]}
echo ${dataType[@]}
current=`awk -v id=$id -F":" '{if(NR>2 && $1==id) print $0}' $tablename `
record=()
# loop for fileds&datatype
for (( i=0;i<${#colArray[@]};i++))
do

echo "Enter New Value Of " ${colArray[$i]} 
read value
# check data type
if [[ ${dataType[$i]} = "string" ]] ;  then
    if [[ ! $value == *[a-zA-z0-9]* ]] ; then      
        echo -e "${invalid}" ${colArray[$i]} " must be string :) ${base}"
        cd ../.. ; source db_menu.sh;
    else
    # convert every space to _
    while [[ $value == *" "* ]] ; do
    value="${value/ /_}"    
    done
    # end convert
            record[$i]=$value
    fi

# Integer
elif [[ ${dataType[$i]} = "integer" ]] ;  then
    if [[ ! $value =~ ^[0-9]*$ ]] ; then
        echo -e "${invalid}" ${colArray[$i]} " must be integer :) ${base}"
        cd ../.. ; source db_menu.sh;
    else
            record[$i]=$value
    fi    
fi
# end if => loop remaining names
done
# end loop
data=""
for item in ${record[@]} 
do
data+=$item":"
done
data=$id":"$data
updateRecord="${data%?}"
# echo $updateRecord
#  # sed -i '/^${id}/s/.*/${data}/' $tablename
# # sed '/^${id}/s//replacement1/g; /^specific_text/s/pattern2/replacement2/g' myfile.txt
sed -i "/^$id/s/$current/$updateRecord/" $tablename

fi

echo -e "${note} Update :  ${base}"


# sed -i 's/old_list/new_list/g' file.txt



    cd ../.. ; source db_menu.sh  
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