#!/bin/bash
echo -e "${note} **** You connected to database : ${dbname} ***${base}" 

select option in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Back To Menu"
do
case $option in
"Create Table" )
    source table_create.sh;;
"List Tables" )
    source table_list.sh;; 
"Drop Table" )
    source table_drop.sh;;
"Insert into Table" )
    source table_insert.sh ;;
"Select From Table" )
    source table_select.sh ;;
"Delete From Table" )
    source table_delete.sh;;
 "Update Table" )
    source table_update.sh;;
 "Back To Menu" )
    source main_menu.sh;;
* ) 
    echo -e "${invalid} Invalid option ${base}" ;; 
esac
done