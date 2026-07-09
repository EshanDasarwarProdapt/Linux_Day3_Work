#Patients Task
PATIENT_FILE="./patients.txt"
REPORT_DIR="./reports"
ALERT_FILE="./reports/critical_patients.txt"
 
mkdir -p "$REPORT_DIR"
 
#Logging func
write_log() {
level=$1
message=$2
 
timestamp=$(date +"%Y-%m-%d %H:%M:%S")
echo "[$timestamp] [$level] $message" >> "$REPORT_DIR/system.log"
}
 
#Task 3 - Validate inp file
validate_file(){
if [[ ! -f "$PATIENT_FILE" ]]; then
write_log "ERROR" "Patient file not found"
echo "Patient file missing."
exit 1
fi
}
 
#TASK 04
display_patients(){
echo "=============== Patient Records =================="
cat "$PATIENT_FILE"
}
 
#TASK 05
count_patients(){
total=$(tail -n +2 "$PATIENT_FILE" |wc -l)
echo "Total Patients: $total"
 
}
 
#TASK 06
critical_patients(){
echo "Critical Patients"
awk -F',' '
NR>1{
	if ($5=="Critical")
	print
}
' "$PATIENT_FILE"
}
 
#TASK 07
generate_alert(){
grep "Critical" "$PATIENT_FILE" > "$ALERT_FILE"
echo "Alert File Generated"
}
 
#TASK 08
highest_bill(){
awk -F',' '
BEGIN{
max=0
}
NR>1{
if($6>max)
{
max=$6
patient=$2
}
}
 
END{
print "Highest Medical Bill"
print "Patient :", patient
print "Bill :", max
}
' "$PATIENT_FILE"
}
 
#TASK 09
department_summary(){
awk -F',' '
NR>1{
dept[$3]++
}
END{
for(i in dept)
print i,dept[i]
}
' "$PATIENT_FILE"
 
}
 
#TASK 10
 
update_status(){
sed -i.bak 's/Pending/Under Observation/g' "$PATIENT_FILE"
 
echo "STATUS UPDATED"
}
 
#TASK 11
 
search_patient(){
read -p "Enter name: " patient
grep -i "$patient" "$PATIENT_FILE"
}
 
#TASK 12
validate_file
while true
do
echo
echo "========= Hospital Monitoring ========="
echo "1.Display Patients"
echo "2.Count Patients"
echo "3.Show Critical Patients"
echo "4.Generate Alert"
echo "5.Highest Medical Bill"
echo "6.Department Summary"
echo "7.Update Status"
echo "8.Search Patient"
echo "9.Exit"
read -p "Enter Choice : " choice
case $choice in
1) display_patients;;
2) count_patients;;
3) critical_patients;;
4) generate_alert;;
5) highest_bill;;
6) department_summary;;
7) update_status;;
8) search_patient;;
9) write_log "INFO" "Application Closed"
   exit;;
*) echo "Invalid Choice"
esac
done
