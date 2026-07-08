#!/bin/bash

FILE="books.txt"

###########################################
# Display All Books
###########################################
view_books() {

    echo "=========== Book Records ==========="

    cat "$FILE"

}

###########################################
# Search Book
###########################################
search_book() {

    echo "Enter Book Name:"
    read book

    if grep -i "$book" "$FILE"
    then
        echo "Book Found"
    else
        echo "Book Not Found"
    fi

}

###########################################
# Count Out Of Stock Books
###########################################
count_outofstock() {

    count=$(grep -c "OutOfStock" "$FILE")

    echo "Out Of Stock Books : $count"

}

###########################################
# Update Stock Status
###########################################

update_stock() {

    echo "Enter Book ID:"
    read id

    book=$(awk -F',' -v id="$id" '$1==id {print $2}' "$FILE")
    status=$(awk -F',' -v id="$id" '$1==id {print $4}' "$FILE")

    if [ -z "$book" ]
    then
        echo "Book ID Not Found"
        return
    fi

    echo "=============================="
    echo "Book Name     : $book"
    echo "Current Status: $status"
    echo "=============================="

    echo "Do you want to change the status? (y/n)"
    read choice

    if [ "$choice" = "y" ] || [ "$choice" = "Y" ]
    then

        echo "Enter New Status (Available/OutOfStock):"
        read new_status

        if [ "$new_status" = "Available" ] || [ "$new_status" = "OutOfStock" ]
        then

            sed -i "/^$id,/ s/$status/$new_status/" "$FILE"

            echo "Stock Status Updated Successfully"

        else
            echo "Invalid Status Entered"
        fi

    else
        echo "No Changes Made"
    fi

}

###########################################
# Calculate Total Inventory Value
###########################################
total_inventory() {

    total=$(awk -F',' '{sum+=$5} END {print sum}' "$FILE")

    echo "Total Inventory Value : Rs.$total"

}

###########################################
# Display Books by Category
###########################################
category_books() {

    echo "Enter Category:"
    read category

    awk -F',' -v cat="$category" '

    BEGIN{
        print "Books in Category :",cat
    }

    $3==cat{
        print $0
    }

    ' "$FILE"

}

###########################################
# Costliest Book
###########################################
costliest_book() {

    awk -F',' '

    BEGIN{
        max=0
    }

    {
        if($5>max)
        {
            max=$5
            book=$2
        }
    }

    END{
        print "Costliest Book :",book
        print "Price : Rs.",max
    }

    ' "$FILE"

}

###########################################
# Menu
###########################################

while true
do

echo
echo "====================================="
echo "      Book Management System"
echo "====================================="
echo "1. View All Books"
echo "2. Search Book"
echo "3. Count Out Of Stock Books"
echo "4. Update Stock Status"
echo "5. Calculate Total Inventory Value"
echo "6. Display Books By Category"
echo "7. Find Costliest Book"
echo "8. Exit"

echo "Enter Choice:"
read choice

case $choice in

1)
    view_books
    ;;

2)
    search_book
    ;;

3)
    count_outofstock
    ;;

4)
    update_stock
    ;;

5)
    total_inventory
    ;;

6)
    category_books
    ;;

7)
    costliest_book
    ;;

8)
    echo "Thank You"
    break
    ;;

*)
    echo "Invalid Choice"
    ;;

esac

done
