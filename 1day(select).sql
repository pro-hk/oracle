-- 주석
SELECT * FROM emp;
-- desc emp;
select empno,ename,job,mgr from emp;
-- distinct : 중복제거
select distinct deptno from emp;
-- all : 굳이 안써도 됨
select all deptno from emp;

select distinct deptno,job from emp;

-- 급여 정보가 궁금하다  컬럼명 바꿀 때 : as 사용
select ename as 이름, sal, comm, sal*12+comm as annualincome from emp;

-- 돈 많이 받는 사람 찾기 asc : 오름차순, desc : 내림차순
select * from emp
order by deptno asc, sal desc;

select * from emp 
where empno = 7369;

--부서 번호가 30번인 직원이면서 job = clerk 뽑기 -- 문자는 ''만 가능
select * from emp
where deptno = 30 
and job = 'CLERK'
order by ename;

-- 부서 번호가 20이거나 직업이 salesman 뽑기
select * from emp
where deptno = 20
or job = 'SALESMAN';

-- sal가 3,000 이상인 사람
select * from emp
where sal >= 3000;

-- 이름 F 이상인 사람
select * from emp
where ename >= 'F';

-- 월급이 3000이 아닌 사람 뽑기
select * from emp
where sal <> 3000;

-- job : manager 또는 saleman 또는 clerk
select * from emp
where job = 'MANAGER' or
      job = 'SALESMAN' or
      job = 'CLERK'
order by job;

-- job : manager 또는 saleman 또는 clerk 아닌 사람
select * from emp
where job not in ('MANAGER', 'SALESMAN','CLERK')
order by job;

-- 부서 번호가 10, 20번 사람 뽑기
select * from emp
where deptno in (10,20);

-- 월급이 2000보다 작거나 3000 보다 큰 사람
select * from emp
where sal <= 2000 or
      sal >= 3000;
-- where sal not between 2000 and 3000;

-- 월급이 2000~3000 사이에 있는 사람
select * from emp
where sal between 2000 and 3000;

-- M으로 시작하는 이름 찾기 -- %: 길이와 상관없는 모든 글자
select * from emp
where ename like 'M%';

-- 두번째 글자가 L인 이름 찾기 -- _: 1글자(3번째 글자 : __'L')
select * from emp
where ename like '_L%';

-- 이름에 A가 들어가는 이름 찾기
select * from emp
where ename like '%A%';

-- null 조회하기( =로 조회 안됨, is로 조회)
select * from emp
where comm is null;
-- where comm is not null;

-- 합집합 union(union all : 중복 허용)
select empno, ename, sal, deptno from emp
where deptno = 20
union
select empno, ename, sal, deptno from emp
where deptno = 30;

-- 차집합 minus
select empno, ename, sal, deptno from emp
minus
select empno, ename, sal, deptno from emp
where deptno = 30;

-- 교집합 intersect
select empno, ename, sal, deptno from emp
intersect
select empno, ename, sal, deptno from emp
where deptno = 30;

-- Q1
select * from emp
where ename like '%S';

-- Q2
select empno,ename, job, sal, deptno from emp
where deptno = 30 and
      job = 'SALESMAN';
      
-- Q3 (1)
select empno, ename, job, sal, deptno from emp
where deptno in (20,30) and
      sal > 2000;
      
-- Q3 (2)
select empno, ename, job, sal, deptno from emp
where deptno = 20 
union
select empno, ename, job, sal, deptno from emp
where deptno = 30
intersect
select empno, ename, job, sal, deptno from emp
where sal > 2000;

-- Q4
select * from emp
where sal < 2000 or
      sal > 3000;
      
-- Q5
select ename, empno, sal, deptno from emp
where ename like '%E%' and
      deptno = 30 and
      sal not between 1000 and 2000;
      
-- Q6
select * from emp
where comm is null and
      mgr is not null and
      job in ('MANAGER','CLERK') and
      ename not like '_L%';