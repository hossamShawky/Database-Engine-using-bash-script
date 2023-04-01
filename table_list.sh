#!/bin/bash
# change working directory to database directory
cd ./database/$dbname
let count=`ls  | wc -l`
if [[ $count  >   0 ]] ; then
echo  -e "${note}**** Your Tables ${count} ****${base}"
ls -F
else
echo -e "${invalid} No Tables Found ${base}"
fi

# return back to main directory&menu
cd ../..
sleep .25
source db_menu.sh   
 