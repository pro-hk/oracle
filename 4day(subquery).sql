-- subquery(��������) -- ���� �ȿ� �Ǵٸ� ���� 
select sal
from emp
where ename = 'JONES';

select *
from emp
where sal > (
            select sal
            from emp
            where ename = 'JONES'  --  ������ ��� : ��Į�� ���� ����
            );
            
-- emp �� �̸��� allen �� �߰� ���纸�� ���� ��� ���
select *
from emp
where comm > (
              select comm
              from emp
              where ename = 'ALLEN'
              );

-- blake ���� �ʰ� �Ի��� ���     
select *
from emp
where hiredate > (  select hiredate
                    from emp
                    where ename = 'BLAKE'
                    );
                    
-- 20�� �μ��� ���� ��� �� ��ü ����� ��� �޿����� ���� ��� ���, join ����
select empno, ename, job, sal, d.deptno, dname, loc
from emp e join dept d on (e.deptno = d.deptno)
where d.deptno = 20
and sal > ( select avg(sal)
            from emp
            );
            
-- �������� ������ ���� ��� : in, some, any ..
select *
from emp
--where deptno = 20 or deptno = 30;
where deptno in (20,30);

-- �� �μ��� �ְ� �޿��� �޴� ���
select *
from emp
where sal in (  select max(sal)
                from emp
                group by deptno
                )
order by deptno;

select *
from emp
where sal = any (   select max(sal)    -- any, some : 1���� ���̸� ���
                    from emp           -- all : ��� �����ؾ� ���
                    group by deptno
                    )
order by deptno;

select *
from emp
--where sal  = any (1000,2000,3000);
where sal  > all (1000,2000,3000);

select *
from emp
where exists (  select dname           -- exists : �����Ѵٸ�..
                from dept
                where deptno = 10
                );
                
-- emp 10�� �μ��� ���� ��� ����麸�� ���� �Ի��� ��� ���
select *
from emp   -- ��� ���� ������ table
where hiredate < all (  select hiredate
                        from emp
                        where deptno = 10
                        );
                        
-- select ���� ���� ���� ������ ��Į�� ���� ���� : ������ ���� ��
-- from ���� ���� ���� ������ ���� �ζ��� ��
-- where ���� ���� ���� ������ ��ø �������� : ������ ����

-- inline view(�ζ��� ��)
select empno, ename, d.deptno, dname, loc
from ( select * from emp where deptno = 10 ) e10
     join
     ( select * from dept ) d 
     on (e10.deptno = d.deptno);

-- scalar subquery(��Į�� ��������)
select empno, ename, job, sal, 
       ( select grade from salgrade where e.sal between losal and hisal) as salgrade,
       deptno,
       ( select dname from dept where e.deptno = dept.deptno) as dname
from emp e;

------------------------- 9�� �������� p.262 ---------------------------------------
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
and job != all( select job       -- not in ����
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

-- Q4 ������
select empno, ename, sal, grade
from emp, salgrade
where sal between losal and hisal 
and sal > all ( select sal
                from emp
                where job = 'SALESMAN'
                )
order by empno;

-- �μ���ȣ 20���� �ִ� ������� �޿����� �ش��ϴ� job�� ��� �޿��� ���̸� ���Ͽ���
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
    as select * from dept;   -- table ����

drop table dept_temp;   -- table ����

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

-- emp �����ؼ� emp_temp ���� ������ �־��..
create table emp_temp as select * from emp;

select * from emp_temp;

insert into emp_temp
values (8000, 'HYEOK', 'ANALYST', 7839, '2022/01/18',3500,1000,10);  -- sysdate : ���� ��¥, �ð� ��
 
-- ���������� ���� ���� values ���� ����
insert into emp_temp        
select e.*
from emp e, salgrade s
where e.sal between s.losal and s.hisal
and s.grade = 1;

-- update ���� �ʼ�!
create table dept_temp02
as select * from dept;

update dept_temp02
set loc = 'SEOUL',
    dname = 'DB'
where deptno = 40;

rollback;
commit;

select * from dept_temp02;

-- emp_temp���� �޿��� 2500 ������ ����� comm 50 �ٲٱ�
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

-- 30�� �μ��� grade = 3
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


----------------------------------- 10�� �������� p.287 ----------------------------
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
----------------- ddl : defination   (table �����)
-- table / index / view ����� DB��ɾ�.. commit, rollback ����
drop table emp_ddl;
create table emp_ddl (
    empno number(4) not null,
    ename varchar2(10),
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),    -- �Ҽ��� ���� 7�ڸ����� ����
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
where 1=0;   -- �����⸸ ����..

select * from emp_dept_ddl;

create table emp_alter
as select * from emp;

select * from emp_alter;

-- alter add : column ����
alter table emp_alter
add hp varchar2(20);

-- alter rename : �̸� ����
alter table emp_alter
rename column hp to tel;

-- alter modify : �Ӽ� ����
alter table emp_alter
modify empno number(5);

desc emp_alter;

-- alter drop : ����
alter table emp_alter
drop column hp;

-- table �̸� �ٲٱ�
rename emp_alter to emp_rename;

-- table ����
drop table emp_rename;

-- data ����
truncate table emp_rename;

desc emp_rename;

select * from emp_rename;


---------------------------- 12�� �������� p.324 ---------------------------------