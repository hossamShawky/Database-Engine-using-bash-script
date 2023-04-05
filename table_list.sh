#!/bin/bash
# check if there tables
let count=`ls  $path"/"$dbname | wc -l`
if [[ $count  >   0 ]] ; then
echo  -e "${note}**** Your Tables [${count}] ****${base}"
ls -F $path"/"$dbname 
else
echo -e "${invalid} No Tables Found ${base}"
fi
source db_menu.sh   