 use DUCAT;

--1.Find all active employees in the IT department who earn more than ₹75,000 and 
--have a performance score above 4.0.

SELECT * FROM Employees1
WHERE Department = 'IT'
AND salary > 75000
AND performance_score > 4.0 ;

--2.List employees whose last name starts with 'S' and work in Finance or Marketing.

SELECT * FROM employees1
where Last_name
like '%s' 
And Department in('Finance','Marketing') ;

--3.Retrieve employees who logged in between 9 AM and 12 PM.

SELECT * 
FROM employees1
WHERE CAST(Login_time AS Time)
Between '09:00:00' AND '12:00:00' ;


--4.Find employees who were hired in 2020 and have not been terminated.
 
 SELECT * FROM employees1
 WHERE year(Hire_date) = 2020
 AND Termination_date is null ;

 --5.Show employees whose email contains their last name.
  SELECT * FROM employees1
  WHERE  email like '%'+ last_name + '%';

--6. List employees from cities in Maharashtra or Gujarat.

SELECT first_name,city
FROM Employees1 
WHERE city in('Pune','Mumbai','Nagpur','Ahmedabad','Surat')

--7.Find employees with overtime hours greater than 10 or performance score less than 3.7.

SELECT * FROM Employees1
WHERE overtime_hours > 10 
AND performance_score < 3.7;

--8.Get the top 5 highest-paid employees in Operations who are active.

SELECT TOP 5 *
FROM employees1
WHERE is_active = 1
AND department = 'Operations'
ORDER BY salary DESC;

--9.Calculate the average salary per department.

SELECT Department,AVG(salary) AS AVG_salary 
FROM employees1
GROUP BY department 

--10.Count the number of active vs inactive employees in each department.

SELECT 
department,
is_active,
COUNT(*) AS total_employees  --row total 
FROM Employees1
GROUP BY department, is_active;

--11.Find the department with the highest average performance score.

SELECT Top 1 department, avg(performance_score) AS Avg_score
FROM employees1
group by department 
Order by Avg_score DESC

--12.Show the total number of employees, total salary cost, and average overtime per department.
SELECT Department,
Count(emp_id) As Total_emp ,
SUM(SALARY) As Total_salry,
AVG(overtime_hours) As Avg_overtime
FROM employees1
Group by department

--13.Which job title has the highest average salary?

SELECT  Top 1 Avg(Salary) AS Avg_Salary,department
FROM employees1
Group By department
Order By Avg_Salary desc

--14.Find departments where average salary is above ₹70,000.

SELECT AVG(Salary) AS avg_salary,
department
FROM employees1
Group By department
Having AVG(Salary) > 70000

--16.Count how many employees were hired each year

SELECT 
year(hire_date ) AS Hire_Year,
COUNT(*) AS Total_emp
FROM employees1
Group by year(hire_date )
Order by Hire_Year

--17.For each department, find the number of employees eligible for bonus.

 ALTER table employees1
 ADD  Bonus int;

update employees1
set bonus = salary*0.1;


SELECT 
COUNT(*) AS Total_emp,
department
FROM employees1
WHERE bonus is not null
Group by department

--18.Find the total overtime hours worked by IT employees in 2022.

SELECT SUM(overtime_hours) AS Total_overtime
FROM employees1
WHERE department = 'IT'
AND year(hire_date) = 2022

--19.Display each employee's name along with their manager’s full name.

SELECT e.first_name , m.manager_name
FROM employees1 e 
join
managers m
on e.manager_id = m.manager_id 

--20.Find employees who do not have a manager (top-level roles).

SELECT e.first_name,m.manager_name 
FROM employees1 e
LEFT JOIN
Managers m 
on e.manager_id = m.manager_id 
WHERE manager_name is null


--21.List all employees and their managers, including those without managers 
--(use LEFT JOIN).

SELECT e.first_name,m.manager_name 
FROM employees1 e
LEFT JOIN
Managers m 
on e.manager_id = m.manager_id 

--22.Find employees whose manager is in a different department.

SELECT e.first_name
FROM employees1 e
LEFT JOIN
Managers m 
on e.manager_id = m.manager_id 
WHERE m.department != e.department

--23.Show employees who report to a manager earning more than ₹90,000.

SELECT e.first_name , m.salary
FROM employees1 e
JOIN
Managers m 
on e.manager_id = m.manager_id 
WHERE m.salary > 90000


--24.Find pairs of employees working in the same department but different job titles.

ALTER TABLE employees1 
ADD Job_Titles varchar(50)

update employees1 
set Job_Titles = 
case 
when emp_id = 1 then 'Analyst'
when emp_id = 2 then 'Accountant' 
when emp_id = 3 then 'Executive'
when emp_id  = 4 then 'Analyst'
when emp_id  = 5 then 'TL'
when emp_id = 6 then 'Accountant'
when emp_id = 7 then 'Analyst'
when emp_id = 8 then 'Executive'
when emp_id = 9 then 'TL'
when emp_id = 10 then ' Engeener'
end;


select * from employees1

SELECT e1.first_name AS Same_Dep, e2.first_name AS Same_Title
FROM employees1 e1
JOIN employees1 e2
ON e1.department = e2.department
AND e1.emp_id < e2.emp_id
AND e1.Job_Titles != e2.Job_Titles;

-- 25.List all managers and how many employees report to them.

SELECT m.manager_name,
COUNT(e.emp_id) as total_emp
FROM employees1 e
right join Managers m
on e.manager_id = m.manager_id
Group by m.manager_name; 



--26.Find employees who have the same job title as their manager.

SELECT e1.first_name AS employee,
e2.first_name AS manager,
e1.Job_Titles
FROM employees1 e1
join employees1 e2
on e1.manager_id = e2.emp_id
where e1.Job_Titles = e2.Job_Titles;

--27.Find employees earning more than the average salary in their department.
 with  Avg_sal as (
SELECT  AVG(salary) AS Avg_salary,department
FROM employees1
GROUP BY department)
SELECT e.salary,a.Avg_salary,e.department
FROM employees1 e
join Avg_sal a
on a.department = e. department
where e.Salary>a.Avg_salary
 select* from employees1

 --28.List employees whose salary is above the company-wide average.

 SELECT first_name, salary 
 FROM employees1
 WHERE salary >(
 SELECT AVG(salary) 
 FROM employees1);

--29.Find the employee with the highest salary in each department.
 
SELECT salary , department 
FROM employees1 
WHERE salary in(
SELECT max(salary) 
FROM employees1
group by department
)   

--30.Get employees who were hired after the most recently hired employee in IT.

SELECT first_name, hire_date, department
FROM employees1
WHERE hire_date > (
	SELECT MAX(hire_date)
	FROM employees1
	WHERE department = 'IT');
---31.Find employees with performance score above the department average.

SELECT performance_score , department
FROM employees1 e
WHERE performance_score > (
SELECT AVG(performance_score)
FROM employees1
WHERE department = e.department);

--32.Use a CTE to rank employees by salary within each department.

WITH emp_rank AS (
	SELECT first_name ,salary,department,
	RANK() over (partition by department ORDER BY salary DESC) AS rankDept
	FROM employees1)
	select * from emp_rank

 --33. Using a CTE, find departments where the top earner makes more than ₹85,000.

 WITH maxsalary AS (
	SELECT department, max(salary) AS Topsalary
	FROM employees1
	GROUP BY department 
	)
SELECT *
FROM maxsalary 
WHERE Topsalary > 85000;

--34. Find employees who have never logged in (last_login is NULL).
 
 WITH login1 AS (
	SELECT first_name,login_time
	FROM employees1
	WHERE login_time IS NULL
	)
SELECT * FROM login1

--35. List employees who earn more than every employee in IT.

SELECT first_name,department , salary
FROM employees1 
WHERE salary >(
SELECT max(salary)
FROM employees1
WHERE department = 'IT');

--36.Rank employees by salary within each department (use RANK).

SELECT *,
RANK() OVER (PARTITION BY department ORDER BY salary DESC) 
AS salary_rank
FROM employees1

--37.Assign row numbers to employees ordered by hire date (oldest first).
 SELECT * ,
Row_number() OVER (ORDER BY hire_date )
 AS HireRank
 FROM employees1

--38.Show the cumulative salary sum ordered by hire date.

SELECT first_name, hire_date,salary,
SUM(salary) OVER(ORDER BY hire_date)
AS cumulative_salary
from employees1

--39.For each department, show the difference between each employee’s salary and 
--the department average.

SELECT  first_name,salary,Department,
Avg(salary) over (PARTITION BY department)
AS Avg_salary,
salary - Avg(salary) over (PARTITION BY department)
AS Salary_diffrence
FROM employees1;

--40.Use LAG() to show the previous employee's salary when ordered by hire_date.

SELECT salary,hire_date,
LAG(salary) OVER (ORDER BY hire_date) AS Privous_salary
FROM employees1

--41.Find the salary difference between each employee and the next-hired employee.

SELECT FIRST_NAME,salary,hire_date,
LEAD(salary) OVER (ORDER BY hire_date) AS Next_salary,
LEAD(salary) OVER (ORDER BY hire_date) 
- salary AS salary_diff
FROM employees1

--42.Partition by department and show the running total of overtime hours.
select first_name,department,overtime_hours,
sum(overtime_hours) OVER(PARTITION BY department ORDER BY first_name)
AS runing_total
from employees1

--43.Use NTILE(4) to divide IT employees into quartiles by salary.

select first_name,department,salary,
NTILE(4) OVER( ORDER BY salary DESC)
AS Qurter_salary
from employees1
WHERE department = 'IT'

--44.Find the top 3 earners in each department using window functions.

select top 3 max(salary),department,

--45.Categorize employees as 'High', 'Medium', or 'Low' performer based on performance_score 
--(≥4.5, 3.5–4.49, <3.5).

SELECT 
    first_name,
    performance_score,
CASE 
	WHEN performance_score >= 4.5 THEN 'High'
	WHEN performance_score >= 3.5 AND performance_score < 4.49 THEN 'Medium'
	WHEN performance_score < 3.5 THEN 'Low'
END AS  performance_cat
FROM employees1

--46.Create a report showing: department, total employees, high performers 
--(score ≥4.5), and their percentage.

SELECT first_name , performance_score ,department
	CASE
		WHEN score >= 4.5 THEN 

FROM employees1