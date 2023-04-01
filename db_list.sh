#!/bin/bash
# change working directory to database directory
cd ./database/

if [[ `ls  | wc -l` >   0 ]] ; then
echo  -e "${note} ****Your Databases****${base}"
ls -F   
else
echo -e "${invalid} No Databases Found ${base}"
fi

# return back to main directory&menu
cd ..
source main_menu.sh   
 