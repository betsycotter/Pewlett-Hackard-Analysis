-- Deliverable 1 retirement_titles
SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	t.title, 
	t.from_date, 
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t 
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Retiring titles count query
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

-- Mentorship Eligibility query 
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
e.first_name, 
e.last_name, 
e.birth_date, 
de.from_date, 
de.to_date, 
t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de 
ON de.emp_no = e.emp_no
INNER JOIN titles as t 
ON t.emp_no = e.emp_no
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- Additional queries
-- Retiring employees with department information 
SELECT DISTINCT ON (ut.emp_no) ut.emp_no, ut.first_name, ut.last_name, ut.title, de.dept_no, d.dept_name
FROM unique_titles as ut
INNER JOIN dept_emp as de
ON de.emp_no = ut.emp_no
INNER JOIN departments as d 
ON d.dept_no = de.dept_no;

-- Mentorship Eligibility with department information 
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