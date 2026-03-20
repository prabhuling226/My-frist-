Show databases;
USE A2;
show tables;
-- Assignment 1

SELECT * FROM student;
SELECT SNAME, SBRANCH FROM student;
SELECT SNAME, SBRANCH, PER FROM student;
SELECT * FROM student;
SELECT SID, SNAME FROM student;
SELECT SNAME, SID, PER, SBRANCH FROM student;

-- Assignment 2

SELECT ename, sal*12 AS annual_salary FROM emp;
SELECT ename, job, sal*6 AS half_term_salary FROM emp;
SELECT *, sal+2000 AS salary_with_bonus FROM emp;
SELECT ename, sal, sal*1.10 AS hike_salary FROM emp;
SELECT ename, sal, sal*0.75 AS deducted_salary FROM emp;
SELECT ename, sal, sal+50 AS salary_after_hike FROM emp;
SELECT ename, sal*12*0.90 AS annual_salary_after_deduction FROM emp;
SELECT ename, sal + IFNULL(comm,0) AS total_salary FROM emp;
SELECT *, sal*12 AS annual_salary FROM emp;
SELECT ename, job, sal-100 AS salary_after_penalty FROM emp;
SELECT ename FROM emp WHERE deptno = 20;
SELECT ename FROM emp WHERE sal > 250;
SELECT ename, sal FROM emp WHERE sal = 250;
SELECT * FROM emp WHERE ename = 'SMITH';
SELECT * FROM emp WHERE hiredate = '1982-12-11';

-- Assignment 3

SELECT * FROM emp;
SELECT ename FROM emp;
SELECT ename, sal FROM emp;
SELECT ename, comm FROM emp;
SELECT empno, deptno FROM emp;
SELECT ename, hiredate FROM emp;
SELECT ename, job FROM emp;
SELECT ename, job, sal FROM emp;
SELECT dname FROM dept;
SELECT dname, loc FROM dept;
SELECT ename, sal FROM emp;
SELECT ename, sal*12 AS annual_salary FROM emp;
SELECT ename, sal*6 AS half_term_salary FROM emp;
SELECT *, sal*6 AS half_term_salary FROM emp;
SELECT empno, ename, sal, sal*6 AS half_term_salary FROM emp;
SELECT ename, sal*1.10 AS salary_after_hike FROM emp;
SELECT ename, sal*0.90 AS salary_after_deduction FROM emp;
SELECT ename, sal*0.68 AS salary_after_deduction FROM emp;

-- Assignment 4

SELECT ename, sal*12 AS annual_salary FROM emp;
SELECT ename, job, sal*6 AS half_term_salary FROM emp;
SELECT *, sal+2000 AS salary_with_bonus FROM emp;
SELECT ename, sal, sal*1.10 AS hike_salary FROM emp;
SELECT ename, sal, sal*0.75 AS deducted_salary FROM emp;
SELECT ename, sal, sal+50 AS salary_after_hike FROM emp;
SELECT ename, sal*12*0.90 AS annual_salary_after_deduction FROM emp;
SELECT ename, sal + IFNULL(comm,0) AS total_salary FROM emp;
SELECT *, sal*12 AS annual_salary FROM emp;
SELECT ename, job, sal-100 AS salary_after_penalty FROM emp;

-- Assignment 5

SELECT * FROM emp 
WHERE job='CLERK' AND sal < 1500;
SELECT ename, hiredate FROM emp 
WHERE job='MANAGER' AND deptno=30;
SELECT *, sal*12 AS annual_salary FROM emp 
WHERE deptno=30 AND job='SALESMAN' AND sal*12 > 14000;
SELECT * FROM emp 
WHERE deptno=30 OR job='ANALYST';
SELECT ename FROM emp 
WHERE sal < 1100 AND job='CLERK';
SELECT ename, sal, sal*12 AS annual_sal, deptno FROM emp 
WHERE deptno=20 AND sal > 1100 AND sal*12 > 12000;
SELECT empno, ename FROM emp 
WHERE job='MANAGER' AND deptno=20;
SELECT * FROM emp 
WHERE deptno IN (20,30);
SELECT * FROM emp 
WHERE job='ANALYST' AND deptno=10;
SELECT * FROM emp 
WHERE job='PRESIDENT' AND sal=4000;
SELECT ename, deptno, job FROM emp 
WHERE job='CLERK' AND deptno IN (10,20);
SELECT * FROM emp 
WHERE (job='CLERK' OR job='MANAGER') AND deptno=10;
SELECT ename FROM emp 
WHERE deptno IN (10,20,30,40);
SELECT * FROM emp 
WHERE empno IN (7902,7839);
SELECT * FROM emp 
WHERE job IN ('MANAGER','SALESMAN','CLERK');
SELECT ename FROM emp 
WHERE hiredate > '1981-12-31' AND job='MANAGER' AND deptno=10;
SELECT ename FROM emp 
WHERE hiredate BETWEEN '1982-01-01' AND '1986-12-31';
SELECT * FROM emp 
WHERE sal BETWEEN 1250 AND 3000;
SELECT ename FROM emp 
WHERE hiredate > '1981-12-31' AND deptno IN (10,30);
SELECT ename, sal*12 AS annual_salary FROM emp 
WHERE job IN ('MANAGER','CLERK') AND deptno IN (10,30);
SELECT *, sal*12 AS annual_salary FROM emp 
WHERE sal BETWEEN 1000 AND 4000 AND sal*12 > 15000;

-- Assignment 6

SELECT * FROM emp WHERE comm IS NULL;

SELECT * FROM emp WHERE mgr IS NULL;

SELECT * FROM emp WHERE job='SALESMAN' AND deptno=30;

SELECT * FROM emp WHERE job='SALESMAN' AND deptno=30 AND sal > 1500;

SELECT * FROM emp WHERE ename LIKE 'S%' OR ename LIKE 'A%';

SELECT * FROM emp WHERE deptno NOT IN (10,20);

SELECT * FROM emp WHERE ename NOT LIKE 'S%';

SELECT * FROM emp 
WHERE mgr IS NOT NULL AND deptno=10;

SELECT * FROM emp 
WHERE comm IS NULL AND job='CLERK';

SELECT * FROM emp 
WHERE mgr IS NULL AND deptno IN (10,30);

SELECT * FROM emp 
WHERE job='SALESMAN' AND deptno=30 AND sal > 2450;

SELECT * FROM emp 
WHERE job='ANALYST' AND deptno=20 AND sal > 2500;

SELECT * FROM emp 
WHERE ename LIKE 'M%' OR ename LIKE 'J%';

SELECT ename, sal*12 AS annual_salary FROM emp 
WHERE deptno <> 30;

SELECT * FROM emp 
WHERE ename NOT LIKE '%ES' AND ename NOT LIKE '%R';

SELECT ename, sal, sal*1.10 AS hike_salary FROM emp 
WHERE mgr IS NOT NULL AND deptno=10;

SELECT * FROM emp 
WHERE job='SALESMAN' 
AND ename LIKE '%E_' 
AND sal LIKE '____';

SELECT * FROM emp 
WHERE hiredate > '1981-12-31';

SELECT * FROM emp 
WHERE MONTH(hiredate)=2;

SELECT * FROM emp 
WHERE job NOT IN ('MANAGER','CLERK') 
AND deptno IN (10,20) 
AND sal BETWEEN 1000 AND 3000;

SELECT * FROM emp 
WHERE sal NOT BETWEEN 1000 AND 2000 
AND deptno IN (10,20,30) 
AND job <> 'SALESMAN';

SELECT dname FROM dept 
WHERE loc LIKE '%O%' AND dname LIKE '%O%';

SELECT * FROM emp 
WHERE job LIKE '%MAN%';

SELECT * FROM emp 
WHERE hiredate BETWEEN '1983-01-01' AND '1986-12-31';

SELECT * FROM emp 
WHERE MONTH(hiredate) IN (11,12);

SELECT ename, comm FROM emp 
WHERE comm > sal;

SELECT ename, job FROM emp 
WHERE mgr IS NOT NULL AND ename LIKE 'S%';

SELECT ename, sal FROM emp 
WHERE (sal*12) LIKE '%0';

SELECT ename FROM emp 
WHERE ename LIKE '%L%L%';

SELECT ename FROM emp 
WHERE ename LIKE 'A%' 
OR ename LIKE 'E%' 
OR ename LIKE 'I%' 
OR ename LIKE 'O%' 
OR ename LIKE 'U%';

commit;