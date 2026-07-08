tax=0
bonus=0
net_salary=0
 
# Function to calculate payroll
calculate_payroll() {
emp_id=$1
name=$2
salary=$3
 
salary=$(echo "$salary" | tr -d '\r')
 
if [[ $salary -le 30000 ]]
then
        tax=$((salary * 5 / 100))
elif [[ $salary -le 60000 ]]
then
        tax=$((salary * 10 / 100))
else
        tax=$((salary * 15 / 100))
fi
 
if [[ $salary -le 50000 ]]
then
        bonus=2000
else
        bonus=5000
fi
 
net_salary=$((salary - tax + bonus))
 
{
echo "Employee ID : $emp_id"
echo "Name        : $name"
echo "Salary      : $salary"
echo "Tax         : $tax"
echo "Bonus       : $bonus"
echo "Net Salary  : $net_salary"
echo "-----------------------------------"
} >> payroll_report.txt
}
 
echo "Enter the employee file name: "
read empfile
 
if [[ ! -f "$empfile" ]]
then
        echo "File nhi hai bhai"
        exit
fi
 
{
echo "Employee Payroll Report"
echo "======================="
echo
} > payroll_report.txt
 
while read emp_id name salary
do
calculate_payroll "$emp_id" "$name" "$salary"
done < "$empfile"
 
echo "Report Generated: payroll_report.txt"
