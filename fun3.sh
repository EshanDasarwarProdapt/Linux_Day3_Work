check_odd_even(){
	if [[ $(( $1 %2)) -eq 0 ]]; then
		echo "$1 is Even"
	else
		echo "$1 is ODD"
fi
}
echo "Enter a NO."
read a
check_odd_even $a
