-- QUESTION

-- 1. 'KING'  과 같은 해에 입사한 직원들의 모든 정보를 출력한다.
--       (단, 'KING'의 정보는 제외한다.)

--  EMPNO  ENAME   JOB           MGR   HIREDATE    SAL   COMM  DEPTNO 
-- -----------------------------------------------------------------------------
--  7499       ALLEN   SALESMAN    7698  1981-02-20  1600   300      30 
--  7521       WARD    SALESMAN    7698  1981-02-22  1250   200      30 
--  7566       JONES   MANAGER     7839  1981-04-02  2975    30      20 
--  7654       MARTIN  SALESMAN   7698  1981-09-28  1250   300      30 
--  7698       BLAKE   MANAGER     7839  1981-04-01  2850  NULL      30 
--  7782       CLARK   MANAGER     7839  1981-06-01  2450  NULL      10 
--  7844       TURNER  SALESMAN   7698  1981-09-08  1500     0      30 
--  7900       JAMES   CLERK           7698  1981-10-03   950  NULL      30 
--  7902       FORD    ANALYST       7566  1981-10-03  3000  NULL      20 

select * from emp where year(hiredate) = (select year(hiredate) from emp where ename = 'king') and ename <> 'king';

-- 2. 'KING'  과 같은 해에 입사하고 같은 부서에서 일하는 직원들의 모든 정보를 출력한다.
--       (단, 'KING'의 정보도 포함하여 출력한다.)

--  EMPNO  ENAME   JOB           MGR   HIREDATE    SAL   COMM  DEPTNO 
-- -------------------------------------------------------------------------------

--  7782       CLARK  MANAGER    7839    1981-06-01  2450  NULL      10 
--  7839        KING   PRESIDENT    NULL   1981-11-17  5000  3500      10 

select * from emp where year(hiredate) = (select year(hiredate) from emp where ename = 'king') and DEPTNO = (select DEPTNO from emp where ename = 'king') ;

-- 3. 'BLAKE'와 같은 부서에 있는 직원들의 이름과 입사일을 뽑는데 'BLAKE'는 빼고 출력하는 SQL  명령을 작성하시오.
-- ENAME      HIREDATE
-- ------------ ---------------
-- ALLEN       1981-02-20 
-- WARD        1981-02-22 
-- MARTIN    1981-09-28 
-- TURNER     1981-09-08 
-- JAMES        1981-10-03 

select ename, HIREDATE from emp where year(hiredate) = (select year(hiredate) from emp where ename = 'BLAKE') and DEPTNO = (select DEPTNO from emp where ename = 'BLAKE') and ename <> 'BLAKE';

-- 4. 이름에 'T'를 포함하고 있는 직원들과 같은 부서에서 근무하고
--   있는 직원의 직원번호와 이름을 출력하는 SQL 명령을 작성하시오.(출력 순서 무관)
-- EMPNO ENAME     
-- -------- ----------
-- 7902	FORD
-- 7566	JONES
-- 7369	SMITH
-- 7788	SCOTT
-- 7900	JAMES
-- 7844	TURNER
-- 7698	BLAKE
-- 7654	MARTIN
-- 7521	WARD
-- 7499	ALLEN  

select ename, EMPNO from emp where DEPTNO in (select deptno from emp WHERE ename LIKE '%T%');

-- 5. 평균급여보다 많은 급여를 받는 직원들의 직원번호, 이름, 월급을
-- 출력하되, 월급이 높은 사람 순으로 출력한다.
--  EMPNO ENAME    SAL
-- -------- ------ ----------
-- 7839	KING		5,000원
-- 7788	SCOTT	3,000원
-- 7902	FORD		3,000원
-- 7566	JONES	2,975원
-- 7698	BLAKE	2,850원
-- 7782	CLARK	2,450원

select EMPNO, ename, 
concat(format(sal, 0), '원') as sal from emp where sal>(select avg(sal) from emp) order by sal desc;

-- 6 급여가 평균급여보다 많고,이름에 S자가 들어가는 직원과 동일한
--  부서에서 근무하는 모든 직원의 직원번호,이름 및 급여를 출력하는 SQL 명령을 작성하시오.(출력 순서 무관)
-- EMPNO      ENAME      SAL
-- --------  --------  -------
-- 7902	     FORD	      3000
-- 7566	     JONES      2975
-- 7788	     SCOTT      3000
-- 7698	     BLAKE      2850

select ename, EMPNO, concat(format(sal, 0), '원') as sal from emp where DEPTNO in (select deptno from emp WHERE ename LIKE '%s%') and sal > (select AVG(SAL) from EMP) Order by sal desc;

-- 7. 30번 부서에 있는 직원들 중에서 가장 많은 월급을 받는 직원보다
--   많은 월급을 받는 직원들의 이름, 부서번호, 월급을 출력하는 SQL 명령을 작성하시오.
--   (단, ALL 또는 ANY 연산자를 사용할 것)
--  이름    부서번호   월급
-- ------------------------------
-- JONES	20	2975
-- SCOTT	20	3000
-- FORD	20	3000
-- KING	10	5000

select ename as '이름', DEPTNO as '부서 번호' , sal as '월급' from emp where sal> all (select sal from emp where deptno = 30) and deptno <> '30';

-- 8. SALES 부서에서 일하는 직원들의 부서번호, 이름, 직업을 출력하는 SQL 명령을 작성하시오.
-- 부서 정보    직원명       직무      
-- -------- ---------- ---------
-- 30번 부서  ALLEN	       SALESMAN
-- 30번 부서  WARD	       SALESMAN
-- 30번 부서  MARTIN      SALESMAN
-- 30번 부서  BLAKE	       MANAGER
-- 30번 부서  TURNER      SALESMAN
-- 30번 부서  JAMES	       CLERK
 
SELECT E.DEPTNO, E.ENAME, E.JOB
FROM EMP E
JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE D.DNAME = 'SALES';

-- 9. 'KING'에게 보고하는 모든 직원의 이름과 입사날짜를 출력하는 SQL 명령을 작성하시오. 
--     (KING에게 보고하는 직원이란 mgr이 KING의 사번인 직원을 의미함) 
-- 이름         입사날짜
-- -------- --------------------
-- JONES	   1981년 04월 02일
-- BLAKE	   1981년 04월 01일
-- CLARK   1981년 06월 01일

select ename, date_format(hiredate, "%Y년 %m월 %d일") as 입사날짜 from emp where mgr = (select EMPNO from emp where ename = 'king');

-- 10. 2월에 입사한 직원들이 받는 최대 급여보다 많은 급여를 받는 직원들의 모든 정보를 출력한다.
--     (문제해결시 집계함수를 사용하지 않고 해결한다.)  

--  EMPNO  ENAME   JOB           MGR   HIREDATE    SAL   COMM  DEPTNO 
-- -------------------------------------------------------------------------------
--  7566  JONES  MANAGER    7839  1981-04-02  2975    30      20 
--  7698  BLAKE  MANAGER    7839  1981-04-01  2850  NULL      30 
--  7782  CLARK  MANAGER    7839  1981-06-01  2450  NULL      10 
--  7788  SCOTT  ANALYST    7566  1982-10-09  3000  NULL      20 
--  7839  KING   PRESIDENT  NULL  1981-11-17  5000  3500      10 
--  7902  FORD   ANALYST    7566  1981-10-03  3000  NULL      20 

select * from emp where sal > all( select sal from emp where month(hiredate)=2);

-- 11. 2월에 입사한 직원들이 받는 최소 급여보다 많은 급여를 받는 직원들중에서 직무가 ANALYST 인
--      직원들의 모든 정보를 출력한다.
--     (문제해결시 집계함수를 사용하지 않고 해결하며 2월 입사 직원은 제외한다.) 

--  EMPNO  ENAME   JOB           MGR   HIREDATE    SAL   COMM  DEPTNO 
-- -------------------------------------------------------------------------------
--  7788  SCOTT  ANALYST  7566  1982-10-09  3000  NULL      20 
--  7902  FORD   ANALYST  7566  1981-10-03  3000  NULL      20 

select * from emp where sal > any( select sal from emp where month(hiredate)=2) and job = 'ANALYST' ;

-- 12. 급여가 3000이상인 직원들과 같은 부서에서 근무하며 커미션이 정해져 있는 
-- 직원들의 정보를 출력하는 SQL 명령을 작성하시오.

--  EMPNO ENAME  JOB      MGR  HIREDATE   SAL  COMM DEPTNO 
-- ----------------------------------------------------------------------
--  7566  JONES  MANAGER    7839  1981-04-02  2975    30      20 
--  7839  KING   PRESIDENT  NULL  1981-11-17  5000  3500      10 

select * from emp where deptno in(select deptno from emp where sal >= 3000)and comm is not null;
