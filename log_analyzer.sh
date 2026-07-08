#Function to count errors

count_errors(){
	echo "NO. of errors: " 
	grep -c "ERROR" server.log
}

#Function top display warning messages

show_warning(){
	echo "WARNING MESSAGES: "
	grep "WARNING" server.log
}

#Funtion to replace error to critical

replace_error(){
	echo "Replacing ERROR with CRITICAL..."
	sed 's/ERROR/CRITICAL/g' server.log
}

echo "=========================================="
echo "            Log File Analyzer             "
echo "=========================================="


count_errors
echo
show_warning
echo
replace_error 
