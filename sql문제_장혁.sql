select * from emp;
--  Q1 사원들이 근무하고 있는 근무 부서의 번호를 중복없이 가져오시오.  
select distinct(deptno) from emp;

-- Q2 사원들의 이름과 직무를 다음 양식으로 가져온다. 000 사원의 담당 직무는 XXX 입니다.  
select ename||' 사원의 담당 직무는 '||job||'입니다.' as 문제2
from emp;

-- Q3 각 사원들의 급여액과 급여액에서 1000을 더한 값, 200을 뺀 값, 2를 곱한 값, 2로 나눈 값을 가져오시오.  
select ename, sal, sal+1000, sal-200, sal*2, sal/2
from emp;

-- Q4 각 사원의 급여액, 커미션, 급여 + 커미션 액수를 가져오시오. 
select ename, sal, nvl(comm,0) as comm , sal+nvl(comm,0) as sal_comm
from emp;

-- Q5 사원의 이름과 사원 번호를 가져온다.
select ename, empno 
from emp;

-- Q6 사원의 이름과 사원 번호, 직무, 급여를 가져온다.
select ename, empno, job, sal
from emp;

-- Q7 부서 번호와 부서 이름을 가져온다.
select deptno, dname
from dept;

-- Q8 부서의 모든 정보를 가져온다.
select * from dept;

-- Q9 사원의 모든 정보를 가져온다.
select * from emp;

-- Q10 근무 부서가 10번인 사원들의 사원번호, 이름, 근무 부서를 가져온다. 
select empno, ename, deptno
from emp
where deptno = 10;

-- Q11 근무 부서 번호가 10번이 아닌 사원들의 사원번호, 이름, 근무 부서 번호를 가져온다.
select empno, ename, deptno
from emp
where deptno <> 10;

-- Q12 급여가 1500이상인 사원들의 사원번호, 이름, 급여를 가져온다.
select empno, ename, deptno
from emp
where sal > 1500;

-- Q13 이름이 SMITH 사원의 사원번호, 이름, 직무, 급여를 가져온다. 
select empno, ename, job, sal
from emp
where ename = 'SMITH';

-- Q14 직무가 SALESMAN인 사원의 사원번호, 이름, 직무를 가져온다. 
select empno, ename, job
from emp
where job = 'SALESMAN';

-- Q15 직무가 CLERK이 아닌 사원의 사원번호, 이름, 직무를 가져온다. 
select empno, ename, job
from emp
where job != 'CLERK';

-- Q16 1982년 1월 1일 이후에 입사한 사원의 사원번호, 이름, 입사일을 가져온다. 
select empno, ename, hiredate
from emp
where hiredate > '1982/01/01';

-- Q17 10번 부서에서 근무하고 있는 직무가 MANAGER인 사원의 사원번호, 이름, 근무부서, 직무를 가져온다.  
select empno, ename, deptno, job
from emp
where deptno = 10 and job = 'MANAGER';

-- Q18 입사년도가 1981년인 사원중에 급여가 1500 이상인 사원의 사원번호, 이름, 급여, 입사일을 가져온다.  
select empno, ename, sal, hiredate
from emp
where to_char(hiredate,'yyyy') = '1981' and sal > 1500;

-- Q19 20번 부서에 근무하고 있는 사원 중에 급여가 1500 이상인 사원의 사원번호, 이름, 부서번호, 급여를 가져온다.
select empno, ename, deptno, sal
from emp
where deptno = 20 and sal > 1500;

-- Q20 상관 사원 번호가 7698번인 사원중에 직무가 CLERK인 사원의 사원번호, 이름, 직속상관번호, 직무를 가져온다.
select empno, ename, mgr, job
from emp
where mgr = 7698 and job = 'CLERK';

-- Q21 급여가 2000보다 크거나 1000보다 작은 사원의 사원번호, 이름, 급여를 가져온다.
select empno, ename, sal
from emp
where sal > 2000 or sal < 1000;

-- Q22 부서번호가 20이거나 30인 사원의 사원번호, 이름, 부서번호를 가져온다.
select empno, ename, deptno
from emp
where deptno in (20,30);

-- Q23 직무가 CLERK, SALESMAN, ANALYST인 사원의 사원번호, 이름, 직무를 가져온다.
select empno, ename, job
from emp
where job in ('CLERK','SALESMAN','ANALYST');

-- Q24 사원 번호가 7499, 7566, 7839가 아닌 사원들의 사원번호, 이름을 가져온다
select empno, ename
from emp
where empno not in (7499, 7566, 7839);

-- Q25 이름이 F로 시작하는 사원의 이름과 사원 번호를 가져온다.
select ename, empno
from emp
where ename like ('F%');

-- Q26 이름이 S로 끝나는 사원의 이름과 사원 번호를 가져온다.
select ename, empno
from emp
where ename like ('%S');

-- Q27 이름에 A가 포함되어 있는 사원의 이름과 사원 번호를 가져온다.
select ename, empno
from emp
where ename like ('%A%');

-- Q28 이름의 두번째 글자가 A인 사원의 사원 이름, 사원 번호를 가져온다.
select ename, empno
from emp
where ename like ('_A%');

-- Q29 이름이 4글자인 사원의 사원 이름, 사원 번호를 가져온다.
select ename, empno
from emp
where length(ename) = 4;

-- Q30 사원중에 커미션을 받지 않는 사원의 사원번호, 이름, 커미션을 가져온다.
select empno, ename, comm
from emp
where comm is null;

-- Q31 회사 대표(직속상관이 없는 사람)의 이름과 사원번호를 가져온다.
select ename, empno
from emp
where mgr is null;

-- Q32 사원의 사원번호, 이름, 급여를 가져온다. 급여를 기준으로 오름차순 정렬을 한다.
select empno, ename, sal
from emp
order by sal;

-- Q33 사원의 사원번호, 이름, 급여를 가져온다. 사원번호를 기준으로 내림차순 정렬을 한다.
select empno, ename, sal
from emp
order by empno desc;

-- Q34 사원의 사원번호, 이름을 가져온다, 사원의 이름을 기준으로 오름차순 정렬을 한다.
select empno, ename
from emp
order by ename;

-- Q35 사원의 사원번호, 이름, 입사일을 가져온다. 입사일을 기준으로 내림차순 정렬을 한다.
select empno, ename, hiredate
from emp
order by hiredate desc;

-- Q36 직무가 SALESMAN인 사원의 사원이름, 사원번호, 급여를 가져온다. 급여를 기준으로 오름차순 정렬을 한다.
select ename, empno, sal
from emp
where job = 'SALESMAN'
order by sal;

-- Q37 1981년에 입사한 사원들의 사원번호, 사원 이름, 입사일을 가져온다. 사원 번호를 기준으로 내림차순 정렬을 한다.
select empno, ename, hiredate
from emp
where to_char(hiredate,'yyyy') = '1981'
order by empno desc;

-- Q38 사원의 이름, 급여, 커미션을 가져온다. 커미션을 기준으로 오름차순 정렬을 한다.
select ename, sal, comm
from emp
order by comm;

-- Q39 사원의 이름, 급여, 커미션을 가져온다. 커미션을 기준으로 내림차순 정렬을 한다.
select ename, sal, comm
from emp
order by comm desc;

-- Q40 전직원의 급여를 2000 삭감하고 삭감한 급여액의 절대값을 구한다.
select ABS(sal-2000) as sal
from emp;

-- Q41 급여가 1500 이상인 사원의 급여를 15% 삭감한다. 단 소수점 이하는 버린다.
select trunc(sal*0.85) as sal
from emp
where sal >= 1500;

-- Q42 급여가 2천 이하인 사원들의 급여를 20%씩 인상한다. 단 10의 자리를 기준으로 반올림한다.
select ROUND(sal*1.2, -2) as sal
from emp
where sal <= 2000;

-- Q43 전 직원의 급여를 10자리 이하를 삭감한다
select trunc(sal,-2) as sal
from emp;

-- Q44. 각 사원의 부서 이름을 가져온다. ex) 10 : 인사과, 20 : 개발부, 30 : 경원지원팀,    40 : 생산부
select deptno, 
    case deptno
        when 10 then '인사과'
        when 20 then '개발부'
        when 30 then '경영지원팀'
        when 40 then '생산부'
    end as deptno_kor
from dept;

-- Q45 직급에 따라 인상된 급여액을 가져온다. ex) CLERK : 10% / SALESMAN : 15% / PRESIDENT : 200% / MANAGER : 5% / ANALYST : 20%
select job, sal, case job
    when 'CLERK'     then sal * 1.1
    when 'SALESMAN'  then sal * 1.15
    when 'PRESIDENT' then sal * 1.2
    when 'MANAGER'   then sal * 1.05
    when 'ANALYST'    then sal * 1.2
    end as increase_sal
from emp;

-- Q46 급여액 별 등급을 가져온다.  ex) 1000 미만 : C등급 / 1000 이상 2000미만 : B등급 / 2000 이상 : A등급
select sal, case 
    when sal < 1000 then 'C등급'
    when sal between 1000 and 2000 then 'B등급'
    when sal > 2000 then 'A등급' 
    end as grade
from emp;

-- Q47 직원들의 급여를 다음과 같이 인상한다.  ex) 1000 이하 : 100% / 1000 초과 2000미만 : 50% / 2000 이상 : 200%
select sal, case
    when sal <= 1000 then sal * 2
    when sal > 1000 and sal < 2000 then sal * 1.5
    when sal >= 2000 then sal * 3 
    end as increase_sal
from emp;

-- Q48 사원들의 커미션 총합을 구한다.
select sum(comm)
from emp;

-- Q49 급여가 1500 이상인 사원들의 급여 총합을 구한다.
select sum(sal)
from emp
where sal >= 1500;

-- Q50 20번 부서에 근부하고 있는 사원들의 급여 총합을 구한다.
select sum(sal)
from emp
where deptno = 20;

-- Q51 직무가 SALESMAN인 사원들의 급여 총합을 구한다.
select sum(sal)
from emp
where job = 'SALESMAN';

-- Q52 직무가 SALESMAN인 사원들의 이름과 급여총합을 가져온다.
select ename, sal
from emp
where job = 'SALESMAN';
--group by job;

-- Q53 전 사원의 급여 평균을 구한다.
select trunc(avg(sal))
from emp;

-- Q54 커미션을 받는 사원들의 커미션 평균을 구한다.
select trunc(avg(comm))
from emp
where comm is not null;

-- Q55 전 사원의 커미션의 평균을 구한다.
select trunc(avg(nvl(comm,0)))
from emp;

-- Q56 커미션을 받는 사원들의 급여 평균을 구한다.
select trunc(avg(sal))
from emp
where comm is not null;

-- Q57 30번 부서에 근무하고 있는 사원들의 급여 평균을 구한다.
select trunc(avg(sal))
from emp
where deptno = 30;

-- Q58 직무가 SALESMAN인 사원들의 급여 + 커미션 평균을 구한다.
select trunc(avg(sal + nvl(comm,0)))
from emp
where job = 'SALESMAN';

-- Q59 사원들의 총 수를 가져온다.
select count(*)
from emp;

-- Q60 커미션을 받는 사원들의 총 수를 가져온다.
select count(comm)
from emp;

-- Q61 사원들의 급여 최대, 최소값을 가져온다.
select max(sal), min(sal)
from emp;

-- Q62 각 부서별 사원들의 급여 평균을 구한다.
select deptno, trunc(avg(sal))
from emp
group by deptno;

-- Q63 각 직무별 사원들의 급여 총합을 구한다.
select job, sum(sal)
from emp
group by job;

-- Q64 1500 이상 급여를 받는 사원들의 부서별 급여 평균을 구한다.
select deptno, trunc(avg(sal))
from emp
where sal >= 1500
group by deptno;

-- Q65 부서별 평균 급여가 2000이상은 부서의 급여 평균을 가져온다.
select deptno, trunc(avg(sal))
from emp
group by deptno
having avg(sal) >= 2000;

-- Q66 부서별 최대 급여액이 3000이하인 부서의 급여 총합을 가져온다.
select deptno, max(sal), sum(sal)
from emp
group by deptno
having max(sal) <= 3000;

-- Q67 부서별 최소 급여액이 1000 이하인 부서에서 직무가 CLERK인 사원들의 급여 총합을 구한다
select deptno, job, min(sal), sum(sal)
from emp
where job = 'CLERK'
group by deptno, job
having min(sal) < 1000;

-- Q68 각 부서의 급여 최소가 900이상 최대가 10000이하인 부서의 사원들 중1500이상의 급여를 받는 사원들의 평균 급여액을 가져온다.
select deptno, min(sal), max(sal), trunc(avg(sal))
from emp
where sal >= 1500
group by deptno
having min(sal) >= 900 and max(sal) <= 10000;

-- Q69 사원의 사원번호, 이름, 근무부서 이름을 가져온다.
select empno, ename, d.deptno,dname
from emp e join dept d on (e.deptno = d.deptno);

-- Q70 사원의 사원번호, 이름, 근무지역을 가져온다.
select empno, ename, d.deptno, loc
from emp e join dept d on (e.deptno = d.deptno);

-- Q71 DALLAS에 근무하고 있는 사원들의 사원번호, 이름, 직무를 가져온다.
select empno, ename, job
from emp e join dept d on (e.deptno = d.deptno)
where d.loc = 'DALLAS';

-- Q72 SALES 부서에 근무하고 있는 사원들의 급여 평균을 가져온다.
select trunc(avg(sal))
from emp e join dept d on (e.deptno = d.deptno)
where d.dname = 'SALES';

-- Q73 1982년에 입사한 사원들의 사원번호, 이름, 입사일, 근무부서이름을 가져온다.
select empno, ename, hiredate, dname
from emp e join dept d on (e.deptno = d.deptno)
where to_char(hiredate,'yyyy') = '1982';

-- Q74 각 사원들의 사원번호, 이름, 급여, 급여등급을 가져온다.
select empno, ename, sal, grade
from emp join salgrade on (sal between losal and hisal);

-- Q75 SALES 부서에 근무하고 있는 사원의 사원번호, 이름, 급여등급을 가져온다.
select empno, ename, grade, d.deptno
from dept d ,emp e ,salgrade s 
where sal between losal and hisal
and d.deptno = e.deptno
and d.dname = 'SALES';

-- Q76 각 급여 등급별 급여의 총합과 평균, 사원의수, 최대급여, 최소급여를 가져온다.
select grade, sum(sal), trunc(avg(sal)), count(*), max(sal), min(sal)
from emp e join salgrade s on (sal between losal and hisal)
group by grade
order by grade;

-- 77. 급여 등급이 4등급인 사원들의 사원번호, 이름, 급여, 근무부서이름, 근무지역을 가져온다.

--(hint) self join 이용
--78. SMITH 사원의 사원번호, 이름, 직속상관 이름을 가져온다.
--79. FORD 사원 밑에서 일하는 사원들의 사원번호, 이름, 직무를 가져온다.
--80. SMITH 사원의 직속상관과 동일한 직무를 가지고 있는 사원들의 사원번호, 이름, 직무를 가져온다.
--
--(hint) outer join 이용
--81. 각 사원의 이름, 사원번호, 직장상사 이름을 가져온다. 단 직속상관이 없는 사원도 가져온다.
--82. 모든 부서의 소속 사원의 근무부서명, 사원번호, 사원이름, 급여를 가져온다
--
--
--(hint) subquery
--83. SMITH사원이 근무하고 있는 부서의 이름을 가져온다.
--84. SMITH와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 급여액, 부서이름을 가져온다.
--85. MARTIN과 같은 직무를 가지고 있는 사원들의 사원번호, 이름, 직무를 가져온다.
--86. ALLEN과 같은 직속상관을 가진 사원들의 사원번호, 이름, 직속상관이름을 가져온다.
--87. WARD와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 부서번호를 가져온다.
--88. SALESMAN의 평균 급여보다 많이 받는 사원들의 사원번호, 이름, 급여를 가져온다.
--89. DALLAS 지역에 근무하는 사원들의 평균 급여를 가져온다.
--90. SALES 부서에 근무하는 사원들의 사원번호, 이름, 근무지역을 가져온다
--91. CHICAGO 지역에 근무하는 사원들 중 BLAKE이 직속상관인 사원들의 사원번호, 이름, 직무를 가져온다.	
--
--
--(hint) 결과가 하나 이상인 subquery는 in,some,any , all  을 이용한다.
--92. 3000 이상의 급여를 받는 사원들과 같은 부서에 근무하고 있는 사원의 사원번호, 이름, 급여를 가져온다
--93. 직무가 CLERK인 사원과 동일한 부서에 근무하고 있는 사원들의 사원번호, 이름, 입사일 가져온다.

