# Pewlett Hackard Analysis

## Overview

Pewlett Hackard is a large, well established company, with many employees. The HR department is looking to find more information about the possibility of a “silver tsunami” as their workforce has a number of employees approaching retirement age. As a result, we have been tasked to research the employee data to plan for expected vacancies. 

The main questions are: 
1. Who will be retiring soon? 
2. What is their current title? 
3. How many vacancies will each position have? 
4. Which employees are eligible for the mentorship program? 

## Results

As a result of our analysis, we have found the following: 
- A list of current employees who are approaching retirement age: 72,458 employees in [retirement titles file](Data/retirement_titles.csv)
- From the list above, the current title by employee number and employee name in [unique titles file](Data/unique_titles.csv)
- Summary of the count of employees by title, see below for summary: 

<img width="255" alt="retiring_titles" src="https://user-images.githubusercontent.com/116031639/206327496-334295df-c321-42b2-b5fc-fb401d1842cf.png">

- A list of employees eligible for the mentorship program: 1,549 employees in [mentorship eligibilty file](Data/mentorship_eligibilty.csv) 

## Summary

Pewlett Hackard has taken an important step in determining the number of vacancies they can expect to see in the next few years. As of now, there are over 72,000 employees that will be retiring soon and it is important to plan for these departures. Additionally, identifying employees who are eligible for the mentorship program will help to ensure that the information transfers for future retirees. 

With the 72,000+  departures, we have added a step to include the department names for each individual. The query is as follows: 

```
SELECT DISTINCT ON (ut.emp_no) ut.emp_no, ut.first_name, ut.last_name, ut.title, de.dept_no, d.dept_name
FROM unique_titles as ut
INNER JOIN dept_emp as de
ON de.emp_no = ut.emp_no
INNER JOIN departments as d 
ON d.dept_no = de.dept_no;
```

Additionally, for the mentorship eligibility group, we have identified over 1,500 employees. For this group, we have also added the department information to the list, using the following query: 

```
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
e.first_name, 
e.last_name, 
e.birth_date, 
de.from_date, 
de.to_date, 
de.dept_no, 
t.title 
FROM employees as e
INNER JOIN dept_emp as de 
ON de.emp_no = e.emp_no
INNER JOIN titles as t 
ON t.emp_no = e.emp_no
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;
```

As a result of having this additional information, we can determine the best candidates per department for the mentorship program. 
