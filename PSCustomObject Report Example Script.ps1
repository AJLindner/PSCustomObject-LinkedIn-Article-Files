$employeeData = import-csv C:\files\EmployeeData.csv
$departmentData = import-csv C:\files\DepartmentData.csv
$jobdata = import-csv C:\files\JobData.csv

$outputReport = foreach ($employee in $employeeData) {

    $ID = $employee.ID
    $department = $departmentData | where DepartmentCode -eq $employee.DepartmentCode | select -expand DepartmentName
    $jobTitle = $jobdata | where JobCode -eq $employee.JobCode | select -expand JobTitle
    $weeklyPay = $employee.salary / 52

    [pscustomobject][ordered]@{
        ID = $ID
        'Job Title' = $jobTitle
        Department = $department
        'Weekly Pay' = $weeklyPay
    }
}

$outputReport

$outputReport | export-csv c:\files\OutputReport.csv -NoTypeInformation