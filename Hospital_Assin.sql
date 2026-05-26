Create Database Hospital;
Use Hospital;
Select * from Hospital_Data

--Total Number of  patients across all hospitals. 
Select Sum(patients_Count) As Patients_total
From Hospital_Data;

--average count of doctors available in each hospital. 
Select Avg(Doctors_Count) As Avg_Doc_count
From Hospital_Data;

--Find the top 3 hospital departments that have the highest number of patients. 

SELECT TOP 3 department, patients_Count
FROM hospital_data
ORDER BY patients_Count DESC;

--Identify the hospital that recorded the highest medical expenses.

SELECT TOP 1 hospital_name, medical_expenses
FROM hospital_data
ORDER BY medical_expenses DESC;

--Calculate the average medical expenses per day for each hospital. 

SELECT 
	AVG(Medical_Expenses*1.0
	/(DATEDIFF(DAY,Admission_Date,Discharge_Date)+1))
	AS Medical_Ex_pd
FROM Hospital_Data
group by Hospital_Name
---OR
SELECT *,
       AVG(medical_expenses * 1.0 / 
           (DATEDIFF(DAY, Admission_Date, discharge_date) + 1)
       ) OVER (PARTITION BY hospital_name) AS avg_daily_expense
FROM hospital_data;

--Find the patient with the longest stay by calculating the difference between 
--Discharge Date and Admission Date.
SELECT TOP 1 *,
	DATEDIFF(DAY,Admission_Date,Discharge_date)+1
	AS stay_days
FROM Hospital_Data
ORDER BY stay_days DESC;

--Count the total number of patients treated in each city.

SELECT SUM(Patients_Count) 
AS TOTAL_PATIENTS,Location
FROM Hospital_Data
GROUP BY Location

--Calculate the average number of days patients spend in each department.
Select * from Hospital_Data

SELECT DEPARTMENT,
AVG(DATEDIFF(Day,Admission_Date,Discharge_Date)+1)
AS Avg_Sty_Date
FROM Hospital_Data
GROUP By Department

--Find the department with the least number of patients.

SELECT Top 1 Department,
Sum(Patients_Count) as Total_Count
FROM Hospital_Data
Group by Department
Order By Total_Count asc;

--Group the data by month and calculate the total medical expenses for each month.

SELECT 
MONTH(admission_date) AS Month_Name ,
Sum(Medical_Expenses) as Toatal_Exp
From Hospital_Data
Group by MONTH(admission_date)
