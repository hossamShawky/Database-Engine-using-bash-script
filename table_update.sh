#!/bin/bash
echo  -e "${note} Database ${dbname} Tables ==>"
         ls  ${path}/${dbname}
echo -e "${base}"         
read -p  "Enter Table Name To Update data : "  tablename
# check table exists
 if [ -f $path"/"$dbname"/"$tablename ] ; then
    # check if contains record
    count=`cat $path"/"$dbname"/"$tablename | wc -l `
    if [[ $count  > 2 ]] ; then   
#   ------------------------------------------  #
# get Columns name from table
colNames=`cut -d ':' -f 2- $path"/"$dbname"/"$tablename`
IFS=':' read -ra colArray <<< $colNames
# echo "Names" ${colArray[@]}
# get Columns data types from table [second record]
typeArray=`head -2 $path"/"$dbname"/"$tablename | tail -1 | cut -d ':' -f 2- `
IFS=':' read -ra dataType <<< $typeArray

# echo "Types" ${typeArray[@]}
#   ------------------------------------------  #

read -p "Enter Record Id : " id

if [[  ! $id =~ ^[1-9][0-9]*$  ]] ; then
    echo -e "${invalid}  ID must be integer :) ${base}"
    source db_menu.sh;
else
# # search if first field is = id return entire record
current=`awk -v id=$id -F":" '{if(NR>2 && $1==id) print $0}' $path"/"$dbname"/"$tablename `

        if [[ ! -z $current ]] ; then
        record=()
# loop for fileds&datatype
for (( i=0;i<${#colArray[@]};i++))
do
echo "Enter New Value Of " ${colArray[$i]}  "["${dataType[$i]}"]" 
read value
        # check data type
        if [[ ${dataType[$i]} = "string" ]] ;  then
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
        elif [[ ${dataType[$i]} = "integer" ]] ;  then
            if [[ ! $value =~ ^[0-9]*$ ]] ; then
                echo -e "${invalid}" ${colArray[$i]} " must be integer :) ${base}"
                source db_menu.sh;
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
    sed -i "/^$id/s/$current/$updateRecord/" $path"/"$dbname"/"$tablename
    else
     echo -e "${invalid} Record Not Found ${base}"
        source db_menu.sh
    fi
fi
    echo -e "${note} Record Update Succssfully.  ${base}"
    source db_menu.sh  
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