#!/bin/bash
echo "You connected to  : ${dbname}"

# while true
# do
 
select option in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Back To Menu"
do
case $option in
"Create Table" )
source table_create.sh;;
"List Tables" )
source table_list.sh;;
"Drop Table" )
echo "drop";;
"Insert into Table" )
echo "insert" ;;
"Select From Table" )
echo "select";;
"Delete From Table" )
echo "delete";;
 "Update Table" )
 echo "delete" ;;
 "Back To Menu" )
source main_menu.sh
;;
* ) echo -e "${invalid}invalid option${base}" ;; 



esac
done



# done