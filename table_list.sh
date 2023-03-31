#!/bin/bash
# change working directory to database directory
cd ./database/$dbname

if [[ `ls  | wc -l` >   0 ]] ; then
echo  "**** Your Tables ****"
ls -F
else
echo -e "${invalid} No Tables Found ${base}"
fi

# return back to main directory&menu
cd ../..
sleep .25
source db_menu.sh   
 