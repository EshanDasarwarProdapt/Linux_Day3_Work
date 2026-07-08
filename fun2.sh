add_num(){
sum=$(( $1 + $2 ))
echo "Sum is : $sum"
}

echo "Enter First no."
read a
echo "Enter Second no."
read b
add_num $a $b
