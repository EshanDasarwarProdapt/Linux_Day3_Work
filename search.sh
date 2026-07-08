search_word(){
file=$1
word=$2

if grep -qi "$word" "$file"
then 
	echo " '$word' found in '$file' "
else
	echo " '$word' not found in '$file' "
fi
}

search_word searchfile.txt EshaN

count_word(){

file=$1
word=$2

count=$(grep -o "$word" "$file" | wc -l)

echo "Occurence of $word: $count"
}

count_word searchfile.txt linux


#Print line no. of the word present

show_line(){
file=$1
word=$2

grep -n "$word" "$file"
}

show_line searchfile.txt linux
