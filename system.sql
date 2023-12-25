SELECT * 
FROM employees
NATURAL JOIN departments;

SELECT *
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

 SELECT department_id, department_name,
 location_id, city
 FROM  departments
 NATURAL JOIN locations ;
 
 
SELECT d.department_id, d.department_name, l.location_id, l.city
FROM  departments d
JOIN locations l ON l.location_id = d.location_id ;

SELECT department_id, department_name, location_id, city
FROM departments JOIN locations 
USING (location_id);

SELECT department_id, department_name, location_id, city
FROM departments  JOIN locations 
USING (location_id)
WHERE location_id = 1400;

SELECT d.department_id, d.department_name, l.location_id,  l.city
FROM departments d JOIN locations l
ON d.location_id = l.location_id;

SELECT location_id, street_address, city, 
state_province, country_name
FROM locations 
NATURAL JOIN countries;

SELECT last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id);

SELECT e.last_name, e.job_id, e.department_id, 
d.department_name
FROM employees e JOIN departments d
ON d.department_id = e.department_id
JOIN locations l
ON l.location_id = d.location_id
WHERE LOWER(l.city) = 'toronto';


SELECT e.last_name AS Employee, e.employee_id AS EMP#,
      m.last_name AS Manager, m.employee_id AS MGR#
FROM employees e JOIN employees m
ON m.employee_id = e.manager_id;


SELECT e.last_name, e.department_id, d.department_name
 FROM   employees e LEFT OUTER JOIN departments d
 ON   (e.department_id = d.department_id);
 
 SELECT e.last_name, e.department_id, d.department_name
 FROM   employees e RIGHT OUTER JOIN departments d
 ON    (e.department_id = d.department_id);


 SELECT e.last_name, d.department_id, d.department_name
 FROM   employees e FULL OUTER JOIN departments d
 ON   (e.department_id = d.department_id) ;
 
 
 SELECT e.last_name AS Employee, e.employee_id AS EMP#,
      m.last_name AS Manager, m.employee_id AS MGR#
FROM employees e 
LEFT OUTER JOIN employees m
ON m.employee_id = e.manager_id;
 
 DEFINE EnterName
 SELECT last_name, hire_date
 FROM employees 
 WHERE department_id = (SELECT department_id 
                        FROM employees
                        WHERE last_name = '&&EnterName')
AND last_name <> '&EnterName';

SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary)
                 FROM employees)
ORDER BY salary;


SELECT employee_id, last_name
FROM employees
WHERE department_id IN (SELECT department_id
                       FROM employees
                       WHERE last_name LIKE '%u%');
                       


SELECT department_id
FROM departments
MINUS
SELECT department_id
FROM employees
WHERE job_id = 'ST_CLERK';

SELECT job_id
FROM employees
WHERE department_id = 10
UNION
SELECT job_id
FROM employees
WHERE department_id = 50
UNION
SELECT job_id
FROM employees
WHERE department_id = 20;


SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM JOB_HISTORY;

SELECT last_name,department_id,TO_CHAR(null) 
FROM   employees 
UNION 
SELECT TO_CHAR(null),department_id,department_name 
FROM  departments;


SELECT department_id, manager_id FROM employees
UNION ALL
SELECT department_id, manager_id FROM departments;


SELECT department_id, manager_id FROM employees
UNION 
SELECT department_id, manager_id FROM departments;


SELECT last_name, job_id, SUM(salary)
FROM employees
GROUP BY ROLLUP(last_name, job_id);


SELECT last_name, job_id, SUM(salary)
FROM employees
GROUP BY CUBE(last_name, job_id);




SELECT last_name, department_id, salary
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, salary
                        FROM employees
                        WHERE commission_pct IS NOT NULL);
                        
SELECT e.last_name, d.department_name, e.salary
FROM employees e JOIN departments d
ON e.department_id = d.department_id
WHERE (e.salary , NVL(e.commission_pct,0)) IN (SELECT salary, NVL(commission_pct,0)
                                        FROM employees e JOIN departments d
                                        ON e.department_id = d.department_id
                                        WHERE location_id = 1700);





SELECT last_name, hire_date, salary
FROM employees
WHERE (salary, NVL(commission_pct, 0)) IN (SELECT salary, NVL(commission_pct, 0)
                  FROM employees 
                  WHERE last_name = 'Kochhar')

AND last_name <> 'Kochhar';





SELECT last_name, hire_date, salary, commission_pct
FROM employees
WHERE salary = 17000 AND COMMISSION_PCT IS NULL
AND last_name <> 'Kochhar';



SELECT last_name, hire_date, salary
FROM employees
WHERE (salary, commission_pct) IN
    (SELECT salary, commission_pct
     FROM employees
     WHERE last_name = 'Kochhar')
  AND last_name <> 'Kochhar';



SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT MAX(salary)
                FROM employees
                WHERE job_id = 'SA_MAN')
ORDER BY salary DESC;






SELECT employee_id, last_name, department_id
FROM employees
WHERE department_id IN (SELECT department_id 
                        FROM departments JOIN locations
                        USING (location_id)
                        WHERE city LIKE 'T%');
                        
                        
                        
                        
                        
                        
                      
                        
SELECT e.last_name, e.salary, e.department_id, ROUND(AVG(m.salary), 2) "Average department salary"
FROM employees e JOIN employees m ON(e.department_id = m.department_id)
GROUP BY e.last_name, e.salary, e.department_id
HAVING e.salary > AVG(m.salary)
ORDER BY AVG(m.salary);







SELECT *
FROM employees
WHERE NOT EXISTS (SELECT 1 
                  FROM employees
                  WHERE manager_id = employee_id);
                  
                  
   
                  
SELECT *
FROM employees
WHERE employee_id NOT IN (SELECT manager_id
                          FROM employees
                          WHERE manager_id IS NOT NULL);                  
                  
                  
                  





SELECT last_name
FROM employees e
WHERE salary < (SELECT AVG(salary)
                 FROM employees
                 WHERE department_id = e.department_id);
                 
                 
                 
                 
                 
                 


SELECT DISTINCT e1.last_name
FROM employees e1 JOIN employees e2 
ON e1.department_id = e2.department_id
WHERE e1.employee_id <> e2.employee_id
AND e1.hire_date < e2.hire_date
AND e1.salary < e2.salary;
  
  
  
  
  
  
  SELECT e.employee_id, e.last_name, (SELECT department_name AS department_name
                                      FROM departments
                                      WHERE department_id = e.department_id)
  FROM employees e;
  
  
  
  
  
  
WITH SUMMARY AS (
    SELECT e.department_id, d.department_name, SUM(e.salary) AS department_salary
    FROM employees e JOIN departments d 
    ON e.department_id = d.department_id
    GROUP BY
        e.department_id, d.department_name)
SELECT department_id, department_name
FROM SUMMARY
WHERE department_salary > (SELECT 1/8 * SUM(salary) FROM employees);








CREATE VIEW EMPLOYEES_VU AS
SELECT employee_id, first_name || ' ' || last_name AS employee, department_id
FROM employees;

SELECT * FROM EMPLOYEES_VU;




SELECT employee, department_id
FROM employees_vu;


CREATE VIEW DEPT50 AS
SELECT employee_id AS EMPNO, last_name || ', ' || first_name AS EMPLOYEE,
department_id AS DEPTNO
FROM employees
WHERE department_id = 50;


DROP table DEPT50;

DESCRIBE DEPT50;




SELECT * FROM DEPT50;





UPDATE DEPT50
SET DEPTNO = 80
WHERE EMPLOYEE LIKE 'Matos%';


  
  
  
DROP TABLE DEPT;
DROP SEQUENCE DEPT_ID_SEQ;

CREATE TABLE DEPT (
    DEPT_ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(50),
    LOCATION VARCHAR2(50)
);
CREATE SEQUENCE DEPT_ID_SEQ
START WITH 200
INCREMENT BY 10
MAXVALUE 1000
CYCLE;
 
INSERT INTO DEPT (DEPT_ID, DEPT_NAME, LOCATION)
VALUES (DEPT_ID_SEQ.NEXTVAL, 'HR Department', 'City A');








SELECT * 
FROM employees;
  
  
DESCRIBE employees;


CREATE TABLE employeer
 ( employee_id    NUMBER(6)  
 CONSTRAINT     emp_employee_id   PRIMARY KEY
, first_name     VARCHAR2(20)
 , last_name      VARCHAR2(25)
 CONSTRAINT emp_last_name_nn  NOT NULL
 , email   VARCHAR2(25) CONSTRAINT   emp_email_nn  NOT NULL
       CONSTRAINT emp_email_uk   UNIQUE
, phone_number   VARCHAR2(20)
 , hire_date      DATE
 CONSTRAINT     emp_hire_date_nn  NOT NULL
, job_id   VARCHAR2(10)
CONSTRAINT      emp_job_nn   NOT NULL
, salary  NUMBER(8,2)
CONSTRAINT emp_salary_ck  CHECK (salary>0)
 , commission_pct NUMBER(2,2)
 , manager_id     NUMBER(6)
 CONSTRAINT emp_manager_fk REFERENCES
 employeer (employee_id)
 , department_id  NUMBER(4) CONSTRAINT   emp_dept_fk   REFERENCES    
departments (department_id));



CREATE OR REPLACE VIEW empvu20
 AS SELECT *
 FROM    employees 
WHERE   department_id = 20
 WITH CHECK OPTION CONSTRAINT empvu20_ck ;
 
 DESCRIBE empvu20
 
 SELECT *
 FROM empvu20;