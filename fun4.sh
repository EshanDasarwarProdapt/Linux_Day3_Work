reverse_string() {
    str="$1"
    rev_str=""

    for (( i=${#str}-1; i>=0; i-- ))
    do
        rev_str="$rev_str${str:$i:1}"
    done

    echo "Reversed String: $rev_str"
}

echo "Enter a String:"
read a

reverse_string "$a"
