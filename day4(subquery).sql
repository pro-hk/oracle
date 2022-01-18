-- subquery(서브쿼리) -- 쿼리 안에 또다른 쿼리 
select sal
from emp
where ename = 'JONES';

select *
from emp
where sal > (
            select sal
            from emp
            where ename = 'JONES'  --  단일행 출력 : 스칼라 서브 쿼리
            );
            
-- emp 중 이름이 allen 의 추가 수당보다 많은 사람 출력
select *
from emp
where comm > (
              select comm
              from emp
              where ename = 'ALLEN'
              );

-- blake 보다 늦게 입사한 사람     
select *
from emp
where hiredate > (  select hiredate
                    from emp
                    where ename = 'BLAKE'
                    );
                    
-- 20번 부서에 속한 사람 중 전체 사원의 평균 급여보다 높은 사람 출력, join 포함
select empno, ename, job, sal, d.deptno, dname, loc
from emp e join dept d on (e.deptno = d.deptno)
where d.deptno = 20
and sal > ( select avg(sal)
            from emp
            );
            
-- 실행결과가 여러개 나올 경우 : in, some, any ..
select *
from emp
--where deptno = 20 or deptno = 30;
where deptno in (20,30);

-- 각 부서의 최고 급여를 받는 사람
select *
from emp
where sal in (  select max(sal)
                from emp
                group by deptno
                )
order by deptno;

select *
from emp
where sal = any (   select max(sal)    -- any, some : 1개라도 참이면 출력
                    from emp           -- all : 모두 만족해야 출력
                    group by deptno
                    )
order by deptno;

select *
from emp
--where sal  = any (1000,2000,3000);
where sal  > all (1000,2000,3000);

select *
from emp
where exists (  select dname           -- exists : 존재한다면..
                from dept
                where deptno = 10
                );
                
-- emp 10번 부서에 속한 모든 사원들보다 일찍 입사한 사람 출력
select *
from emp   -- 행과 열이 있으면 table
where hiredate < all (  select hiredate
                        from emp
                        where deptno = 10
                        );
                        
-- select 절에 쓰는 서브 쿼리를 스칼라 서브 쿼리 : 무조건 단일 행
-- from 절에 쓰는 서브 쿼리를 보통 인라인 뷰
-- where 절에 쓰는 서브 쿼리를 중첩 서브쿼리 : 다중행 가능

-- inline view(인라인 뷰)
select empno, ename, d.deptno, dname, loc
from ( select * from emp where deptno = 10 ) e10
     join
     ( select * from dept ) d 
     on (e10.deptno = d.deptno);

-- scalar subquery(스칼라 서브쿼리)
select empno, ename, job, sal, 
       ( select grade from salgrade where e.sal between losal and hisal) as salgrade,
       deptno,
       ( select dname from dept where e.deptno = dept.deptno) as dname
from emp e;

------------------------- 9장 연습문제 p.262 ---------------------------------------
-- Q1
select job, empno, ename, sal, d.deptno, dname
from emp e join dept d on (e.deptno = d.deptno)
where job = (   select job
                from emp
                where ename = 'ALLEN'
                );
                
-- Q2
select empno, ename, dname, hiredate, loc, sal, 
       ( select grade from salgrade where e.sal between losal and hisal) as grade
from emp e join dept d  on (e.deptno = d.deptno)
where sal > (   select avg(sal)
                from emp
                )
order by sal desc;

-- Q3
select empno, ename, job, d.deptno, dname, loc
from emp e join dept d on (e.deptno = d.deptno)
where d.deptno = 10 
and job != all( select job       -- not in 가능
                from emp
                where deptno = 30
                );
                
-- Q4
select empno, ename, sal, grade
from emp, salgrade
where sal between losal and hisal 
and sal > (   select max(sal)
                from emp
                where job = 'SALESMAN'
                )
order by empno;

-- Q4 다중행
select empno, ename, sal, grade
from emp, salgrade
where sal between losal and hisal 
and sal > all ( select sal
                from emp
                where job = 'SALESMAN'
                )
order by empno;

-- 부서번호 20번에 있는 사원들의 급여에서 해당하는 job의 평균 급여의 차이를 구하여라
select empno, ename, job, sal,
       e.sal - ( select trunc(avg(sal)) from emp ee where e.job = ee.job ) as avg_sal_diff
from emp e
where deptno = 20;

select empno, ename, job, sal,
       e.sal - ( select trunc(avg(sal)) from emp ee where e.job = ee.job ) as avg_sal_diff
from emp e
where deptno = 20;

--select job, trunc(avg(sal)) as avg
--from emp
--where deptno = 20
--group by job;

--------------------- insert update delete -----------------------------
create table dept_temp
    as select * from dept;   -- table 복제

drop table dept_temp;   -- table 삭제

select * from dept_temp;

rollback;

insert into dept_temp ( deptno, dname, loc)
values (50, 'DATABASE', 'SEOUL');

insert into dept_temp ( deptno, dname, loc)
values (60, 'JAVA','BUSAN');

insert into dept_temp
values (70, 'NETWORK','DANGSAN');

insert into dept_temp
values (80, 'WEB', NULL);

-- emp 복제해서 emp_temp 본인 데이터 넣어보기..
create table emp_temp as select * from emp;

select * from emp_temp;

insert into emp_temp
values (8000, 'HYEOK', 'ANALYST', 7839, '2022/01/18',3500,1000,10);  -- sysdate : 현재 날짜, 시간 들어감
 
-- 서브쿼리로 넣을 때는 values 쓰지 않음
insert into emp_temp        
select e.*
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and s.grade = 1;

-- update 조건 필수!
create table dept_temp02
as select * from dept;

update dept_temp02
set loc = 'SEOUL',
    dname = 'DB'
where deptno = 40;

rollback;
commit;

select * from dept_temp02;

-- emp_temp에서 급여가 2500 이하인 사람은 comm 50 바꾸기
update emp_temp
set comm = 50
where sal <= 2500;

commit;

select * from emp_temp;

-- delete
delete from emp_temp
where job = 'CLERK';

rollback;
commit;

select * from emp_temp;

-- 30번 부서에 grade = 3
delete from emp_temp
where deptno = 30
and (select grade from salgrade where sal between losal and hisal) = 3;

delete from emp_temp
where empno in (
select empno
from emp_temp e, salgarde s
where e.sal between s.losal and s.hisal
and s.grade = 3
and e.deptno = 30);


----------------------------------- 10장 연습문제 p.287 ----------------------------
-- Q1
create table chap10hw_emp as select * from emp;
create table chap10hw_dept as select * from dept;
create table chap10hw_salgrade as select * from salgrade;

insert into chap10hw_dept
--values (50, 'ORACLE','busan');
--values (60,'SQL','ILSAN');
--values (70,'SELECT','INCHEON');
values (80,'DML','BUNDANG');

select * from chap10hw_dept;

-- Q2
insert into chap10hw_emp
--values (7201,'TEST_USER1','MANAGER',7788,'2016/01/02',4500,NULL,50);
--values (7202,'TEST_USER2','CLERK',7201,'2016/02/21',1800,NULL,50);
--values (7203,'TEST_USER3','ANALYST',7201,'2016/04/11',3400,NULL,60);
--values (7204,'TEST_USER4','SALESMAN',7201,'2016/05/31',2700,300,60);
--values (7205,'TEST_USER5','CLERK',7201,'2016/07/20',2600,NULL,70);
--values (7206,'TEST_USER6','CLERK',7201,'2016/09/08',2600,NULL,70);
--values (7207,'TEST_USER7','LECTURER',7201,'2016/10/28',2300,NULL,80);
values (7208,'TEST_USER8','STUDENT',7201,'2018/03/09',1200,NULL,80);

select * from chap10hw_emp;

-- Q3
update chap10hw_emp
set deptno = 70
where sal > (select avg(sal) from chap10hw_emp where deptno = 50);

select * from chap10hw_emp order by deptno;

-- Q4
update chap10hw_emp
set sal = sal*1.1, deptno = 80
where hiredate > (select min(hiredate) from chap10hw_emp where deptno=60);
select * from chap10hw_emp order by deptno;

-- Q5
delete from chap10hw_emp
where (select grade from chap10hw_salgrade where sal between losal and hisal) = 5;

select * from chap10hw_emp;


---------------------------- transaction  -----------------------------------
create table dept_tcl
as select * from dept;

insert into dept_tcl values (50,'DATABASE','INCHEON');
update dept_tcl set loc = 'BUSAN' where deptno = 40;
delete from dept_tcl where deptno = 50;

rollback;
commit;

select * from dept_tcl;
update dept_tcl set loc = 'FADFLKJASDLKF'
where deptno = 10;

----------------- dml : insert update delete (commit / rollback)
----------------- ddl : defination   (table 만들기)
-- table / index / view 만드는 DB명령어.. commit, rollback 없음
drop table emp_ddl;
create table emp_ddl (
    empno number(4) not null,
    ename varchar2(10),
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),    -- 소수점 포함 7자리까지 가능
    comm number(7,2),     
    deptno number(2)
);
insert into emp_ddl values (7877,'KING','PRISIDENT',NULL,'2022-01-18',5000,NULL, 10);
insert into emp_ddl values (7878,'BLAKE','MANAGER',7877,'2022-01-10',3000,NULL, 20);
insert into emp_ddl values (1001,'SCOTT','FREE',7877,SYSDATE,5500,NULL, NULL);
insert into emp_ddl values (1001,'HYEOK','FREE',7877,SYSDATE,5500.555,NULL, NULL);
insert into emp_ddl values (1001,'JANG','FREE',7877,SYSDATE,55500.555,NULL, NULL);

select * from emp_ddl;

create table emp_dept_ddl
as select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, d.deptno, d.dname, d.loc
from emp e, dept d
where 1=0;   -- 껍데기만 만듬..

select * from emp_dept_ddl;

create table emp_alter
as select * from emp;

select * from emp_alter;

-- alter add : column 생성
alter table emp_alter
add hp varchar2(20);

-- alter rename : 이름 변경
alter table emp_alter
rename column hp to tel;

-- alter modify : 속성 변경
alter table emp_alter
modify empno number(5);

desc emp_alter;

-- alter drop : 삭제
alter table emp_alter
drop column hp;

-- table 이름 바꾸기
rename emp_alter to emp_rename;

-- table 삭제
drop table emp_rename;

-- data 삭제
truncate table emp_rename;

desc emp_rename;

select * from emp_rename;


---------------------------- 12장 연습문제 p.324 ---------------------------------