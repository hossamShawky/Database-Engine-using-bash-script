#!/bin/bash
# check if there databases
count=`ls ${path} | wc -l`
if [[ $count >   0 ]] ; then
echo  -e "${note} **** Your Databases [${count}] ****${base}"
ls -F ${path}
else
echo -e "${invalid} No Databases Found ${base}"
fi
# return back to main menu
source main_menu.sh   