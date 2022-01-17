-- 다중행 함수 / 전체 갯수 / 급여..

select sum(sal) as total,   -- 다중행 합
       trunc(avg(sal)) as avg   -- 다중행 평균
from emp;

select max(sal) as max,   -- 최대값
       min(sal) as min    -- 최소값
from emp;

-- 게시판에서 가장 많이 함
select count(sal) as count,  -- 갯수(null 미포함)
       count(*) as countall  -- 가장 많은 갯수 표시
from emp;

select sum(sal) as sum_total,
       trunc(avg(sal)) as avg,
       max(sal) as max,
       min(sal) as min,
       count(*) as total
from emp;

select count(*)
from emp
where deptno = 30;

-- 30 부서 중 월급 제일 많이 받는 사람과 제일 적게 받는 사람
select max(sal) as max,
       min(sal) as min 
from emp
where deptno = 30;

-- 제일 최근에 입사한 사람..
select max(hiredate) as 최근입사자, min(hiredate) as 첫입사자
from emp;

-- group by
select '10' as deptno , sum(sal) as sum, trunc(avg(sal)) as avg from emp where deptno = 10
union all
select '20', sum(sal), trunc(avg(sal)) from emp where deptno = 20
union all
select '30', sum(sal), trunc(avg(sal)) from emp where deptno = 30;

select deptno ,
       sum(sal) as sum,
       trunc(avg(sal)) as avg       
from emp
group by deptno
order by deptno;   -- order by는 마지막에 적어야함

select deptno,
       job,
       trunc(avg(sal)) as avg,
       count(*) as count
from emp
group by deptno, job
order by deptno, avg;

-- having절  group을 써야 가능(조건 적용)
select deptno,
       job,
       trunc(avg(sal)) as avg
from emp
-- where
group by deptno, job
having avg(sal) >= 2000
order by avg DESC;

select deptno,
       job,
       trunc(avg(sal)) as avg
from emp
where sal <= 3000
group by deptno, job
having avg(sal) >= 2000
order by avg DESC;

-- 부서별 직책평균 급여가 1000 이상인 사람들
select deptno,
       job,
       trunc(avg(sal)) as avg
from emp
group by deptno, job
having avg(sal) >= 1000
order by deptno, avg;

-- rollup : 부분합
select job, sum(sal) as sal_total
from emp
group by rollup(job);

select deptno, job, sum(sal)
from emp
group by rollup(job,deptno);

select deptno, 
       job, 
       count(*) as count, 
       max(sal) as high, 
       sum(sal) as sum_total, 
       trunc(avg(sal)) as avg
from emp
group by rollup(deptno, job)
order by deptno, job;

-- grouping sets
select deptno,
       job,
       count(*) as count
from emp
group by grouping sets(deptno,job)

order by deptno,job;

select deptno,
       job,
       count(*) as count
from emp
group by grouping sets((deptno,job),null)  -- null, () 가능
order by deptno,job;

select decode(grouping(deptno),1,'dept_all',deptno) as deptno,
       decode(grouping(job),1,'job_all',job) as job,
--       deptno,
--       job,
       count(*),
       max(sal) as high,
       sum(sal) as sum_total,
       trunc(avg(sal)) as avg
--grouping(deptno),
--grouping(job)
from emp
group by rollup(deptno, job)
order by deptno, job;

-- listagg  묶어서 옆으로 출력
select deptno,
       listagg(ename,', ')
       within group(order by sal desc) as enames
from emp
group by deptno;

select 
       listagg(ename,'/')
       within group(order by ename) as enames 
from emp
where job in('MANAGER', 'SALESMAN');

-------------------------------------------------------- table 만들기  ----------------------------------
-- insert(create) select(read) update delete   CRUD
create table month_sales (
-- column, 속성
    product_id varchar2(10),  
    month varchar2(10),
    company varchar2(20),
    money number(10)
);

insert into month_sales values('P001','2021/12','SAMSUNG',10000);
insert into month_sales values('P001','2021/11','SAMSUNG',12000);
insert into month_sales values('P001','2021/10','SAMSUNG',15000);
insert into month_sales values('P001','2021/09','SAMSUNG',18000);
insert into month_sales values('P001','2021/08','SAMSUNG',9000);
insert into month_sales values('P002','2021/12','APPLE',30000);
insert into month_sales values('P002','2021/11','APPLE',19000);
insert into month_sales values('P002','2021/10','APPLE',12000);
insert into month_sales values('P002','2021/09','APPLE',13000);
insert into month_sales values('P002','2021/08','APPLE',10000);
insert into month_sales values('P003','2021/12','LG',8000);
insert into month_sales values('P003','2021/11','LG',13000);
insert into month_sales values('P003','2021/10','LG',20000);
insert into month_sales values('P003','2021/09','LG',7000);
insert into month_sales values('P003','2021/08','LG',10000);

delete from month_sales;  -- table 내 content 전체 삭제
drop table month_sales;  -- table 삭제
rollback; -- 실수 했을 때, 되돌리기
commit;   -- 완료

select * from month_sales;

select month,
       product_id, 
       sum(money) as total
from month_sales
group by rollup(month, product_id);

select month,
       product_id, 
       sum(money) as total
from month_sales
group by cube(month, product_id);   -- 경우의 수에 따라...

select product_id, month, company, sum(money) as total
from month_sales
group by grouping sets((product_id,month),company);

select case grouping(product_id) when 1 then '모든 상품' else product_id end as product_id,
       case grouping(month)      when 1 then '모든 월'   else month end as month,
       sum(money) as money_total
from month_sales
group by rollup(product_id,month);

-- pivot row, column 바꾸기
select deptno, job, max(sal) as high
from emp
group by deptno, job
order by deptno, job;

-- 서브쿼리 select * from (피벗시킬 쿼리)
--         pivot(그룹함수(집계할 컬럼) for 피벗칼럼 in (피벗 컬럼값 as 별명))
select * 
from(select deptno, job, sal from emp)  -- 서브쿼리
pivot(max(sal)for deptno in (10,20,30))
order by job;

select * 
from(select deptno, job, sal from emp)
pivot(max(sal) for job in (
    'CLERK' as 사원,
    'SALESMAN' as 영업사원,
    'MANAGER' as 관리자,
    'ANALYST' as 분석가,
    'PRESIDENT' as 사장
    ))
order by deptno;

-- 달별 입사인력
select * 
from(select job, to_char(hiredate,'fmmm')||'월' as hire_month from emp)
pivot (count(*) for hire_month in ('1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'));

select job, to_char(hiredate,'mm') as hire_month, count(*)
from emp
group by job, hiredate;


----------------------------  연습문제 p.212 -------------------------------------------
-- Q1
select deptno, 
       trunc(avg(sal)) as avg_sal, 
       max(sal) as max_sal, 
       min(sal) as min_sal, 
       count(*) as cnt
from emp
group by deptno;

-- Q2
select job, count(*)
from emp
group by job
having count(*) >= 3;

-- Q3
select to_char(hiredate,'yyyy') as hire_year,
       deptno, 
       count(*) as cnt
from emp
group by to_char(hiredate,'yyyy'), deptno;

-- Q4
select nvl2(comm,'O','X') as exist_comm,
       count(*) as cnt
from emp
group by nvl2(comm,'O','X');

--select  case grouping(deptno)   when 1 then ' ' else to_char(deptno) end as deptno,
--        case grouping(hiredate) when 1 then ' ' else to_char(hiredate,'yyyy') end as hire_year,
select  deptno, 
        to_char(hiredate,'yyyy') as hire_year,
        count(*) as cnt,
        max(sal) as max_sal, 
        sum(sal) as sum_sal, 
        avg(sal) as avg_sal
from emp
--group by rollup(deptno, hiredate);
group by rollup(deptno, to_char(hiredate,'yyyy'));

------------------------------------------ table join -------------------------------------------
-- inner join (교차)
select * 
from emp, dept;

-- 등가 조인(같은 값)
select *
from emp e, dept d           -- 테이블 영어(별명)
where e.deptno = d.deptno;   -- 테이블.컬럼

select empno, ename, d.deptno, dname, loc  -- 중복 컬럼이 있으면 어디 테이블 것을 사용할지 정해야됨
from emp e, dept d
where e.deptno = d.deptno and sal >= 2500
order by deptno,empno;

-- 비등가 조인 (같은 값이 아님)
select *
from emp e, salgrade s
where sal between losal and hisal;

-- self  join (자기가 자기를 한 번 더 쓰기)
select e1.empno, 
       e1.ename, 
       e1.mgr,
--       e2.empno as mgr_num, 
       e2.ename as mgr_name 
from emp e1, emp e2
where e1.mgr = e2.empno;

-- outer join(오라클에서만 가능..)
select e1.empno, 
       e1.ename, 
       e1.mgr,
       e2.empno as mgr_num, 
       e2.ename as mgr_name
from emp e1, emp e2
where e1.mgr = e2.empno(+)  -- left outer join 조건에 만족하지 않는 좌항의 값들을 null로 가져와라..
order by e1.empno;

select e1.empno, 
       e1.ename, 
       e1.mgr,
       e2.empno as mgr_num, 
       e2.ename as mgr_name
from emp e1, emp e2
where e1.mgr(+) = e2.empno  -- right outer join 조건에 만족하지 않는 우항의 값들을 null로 가져와라..
order by e1.empno;

-- ansi join(표준..)
select empno, ename, job, mgr, hiredate, sal, comm, deptno, dname, loc
from emp e natural join dept d
order by deptno, empno;

select empno, ename, job, mgr, hiredate, sal, comm, deptno, dname, loc
from emp e join dept d using (deptno)
order by deptno, empno;

-- 아래 방법으로 사용하는 것을 권장(등가조인)
select empno, ename, job, mgr, hiredate, sal, comm, d.deptno, dname, loc  -- 겹치는 칼럼 지정해줘야함
from emp e join dept d on (e.deptno = d.deptno)
where sal < 3000
order by deptno, empno;

-- left outer join
select e1.empno, 
       e1.ename, 
       e1.mgr,
       e2.empno as mgr_num, 
       e2.ename as mgr_name
from emp e1 left outer join emp e2 on (e1.mgr = e2.empno)
order by e1.empno;

-- right outer join
select e1.empno, 
       e1.ename, 
       e1.mgr,
       e2.empno as mgr_num, 
       e2.ename as mgr_name
from emp e1 right outer join emp e2 on (e1.mgr = e2.empno)
order by e1.empno;

-- full outer join(양쪽)
select e1.empno, 
       e1.ename, 
       e1.mgr,
       e2.empno as mgr_num, 
       e2.ename as mgr_name
from emp e1 full outer join emp e2 on (e1.mgr = e2.empno)
order by e1.empno;


------------------------------------- 연습문제  p.239 ------------------------------
-- Q1 이전
select e.deptno,
       dname,
       empno,
       ename,
       sal
from emp e, dept d
where e.deptno = d.deptno and sal > 2000
order by deptno;

-- Q1 이후
select e.deptno,
       dname,
       empno,
       ename,
       sal
from emp e join dept d on (e.deptno = d.deptno)
where sal > 2000
order by deptno;

-- Q2 이전
select d.deptno,
       dname,
       trunc(avg(sal)) as avg_sal,
       max(sal) as max_sal,
       min(sal) as min_sal,
       count(*) as cnt
from emp e, dept d
where d.deptno=e.deptno
group by d.deptno, dname;

-- Q2 이후
select d.deptno,
       dname,
       trunc(avg(sal)) as avg_sal,
       max(sal) as max_sal,
       min(sal) as min_sal,
       count(*) as cnt
from emp e join dept d on (d.deptno = e.deptno)
group by d.deptno,dname;

-- Q3 이전
select d.deptno,
       dname,
       empno,
       ename,
       job,
       sal
from emp e, dept d
where d.deptno = e.deptno(+)
order by deptno,ename;

-- Q3 이후
select d.deptno,
       dname,
       empno,
       ename,
       job,
       sal
from emp e right outer join dept d on (d.deptno = e.deptno)
order by deptno,ename;

-- Q4 이전
select e1.deptno,
       dname,
       e1.empno,
       e1.ename,
       e1.mgr,
       e1.sal,
       d.deptno as deptno_1,
       losal,
       hisal,
       grade,
       e2.empno as mgr_empno,
       e2.ename as mgr_ename
from emp e1, emp e2, dept d, salgrade s
where e1.deptno = d.deptno and e1.sal between losal and hisal and e1.mgr = e2.empno(+)
order by e1.deptno, e1.empno;

-- Q4 이후
select e1.deptno,
       dname,
       e1.empno,
       e1.ename,
       e1.mgr,
       e1.sal,
       d.deptno as deptno_1,
       losal,
       hisal,
       grade,
       e2.empno as mgr_empno,
       e2.ename as mgr_ename
from emp e1 left outer join emp e2 on (e1.mgr = e2.empno),salgrade s, dept d
intersect
select e1.deptno,
       dname,
       e1.empno,
       e1.ename,
       e1.mgr,
       e1.sal,
       d.deptno as deptno_1,
       losal,
       hisal,
       grade,
       e2.empno as mgr_empno,
       e2.ename as mgr_ename
from emp e1 right outer join dept d on (e1.deptno = d.deptno),salgrade s, emp e2
intersect
select e1.deptno,
       dname,
       e1.empno,
       e1.ename,
       e1.mgr,
       e1.sal,
       d.deptno as deptno_1,
       s.losal,
       s.hisal,
       grade,
       e2.empno as mgr_empno,
       e2.ename as mgr_ename
from emp e1, emp e2, dept d ,salgrade s
where e1.sal between s.losal and s.hisal;