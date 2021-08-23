-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
  emp_no INT NOT NULL,
  title VARCHAR NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  PRIMARY KEY (emp_no, from_date)
);

CREATE TABLE dept_emp (
  emp_no INT NOT NULL,
  dept_no VARCHAR(4) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

-- abbr.

-- Deliverable 1
SELECT e.emp_no, e.first_name, e.last_name
FROM employees AS e;

SELECT tit.title, tit.from_date, tit.to_date
FROM titles AS tit;

SELECT e.emp_no, e.first_name, e.last_name, tit.title, tit.from_date, tit.to_date
INTO retirement
FROM employees AS e
LEFT JOIN titles AS tit
ON (e.emp_no = tit.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

SELECT * FROM retirement;

SELECT emp_no, first_name, last_name, title
FROM retirement;

SELECT DISTINCT ON (r.emp_no) r.emp_no,
r.first_name,
r.last_name,
r.title
INTO unique_titles
FROM retirement AS r
ORDER BY r.emp_no, r.to_date DESC;

SELECT * FROM unique_titles;

SELECT COUNT(u.title), u.title
INTO close_retirement
FROM unique_titles AS u 
GROUP BY u.title 
ORDER BY COUNT DESC;

SELECT * FROM close_retirement;

-- Deliverable 2
SELECT e.emp_no, e.first_name, e.last_name, e.birth_date
FROM employees AS e;

SELECT de.from_date, de.to_date
FROM dept_emp AS de;

SELECT tit.title
FROM titles AS tit;

SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, tit.title
INTO mentor_eligibility
FROM employees AS e
LEFT JOIN titles AS tit
ON (e.emp_no = tit.emp_no)
LEFT JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

SELECT * FROM mentor_eligibility;