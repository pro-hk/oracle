-- ������ �Լ� / ��ü ���� / �޿�..

select sum(sal) as total,   -- ������ ��
       trunc(avg(sal)) as avg   -- ������ ���
from emp;

select max(sal) as max,   -- �ִ밪
       min(sal) as min    -- �ּҰ�
from emp;

-- �Խ��ǿ��� ���� ���� ��
select count(sal) as count,  -- ����(null ������)
       count(*) as countall  -- ���� ���� ���� ǥ��
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

-- 30 �μ� �� ���� ���� ���� �޴� ����� ���� ���� �޴� ���
select max(sal) as max,
       min(sal) as min 
from emp
where deptno = 30;

-- ���� �ֱٿ� �Ի��� ���..
select max(hiredate) as �ֱ��Ի���, min(hiredate) as ù�Ի���
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
order by deptno;   -- order by�� �������� �������

select deptno,
       job,
       trunc(avg(sal)) as avg,
       count(*) as count
from emp
group by deptno, job
order by deptno, avg;

-- having��  group�� ��� ����(���� ����)
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

-- �μ��� ��å��� �޿��� 1000 �̻��� �����
select deptno,
       job,
       trunc(avg(sal)) as avg
from emp
group by deptno, job
having avg(sal) >= 1000
order by deptno, avg;

-- rollup : �κ���
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
group by grouping sets((deptno,job),null)  -- null, () ����
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

-- listagg  ��� ������ ���
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

-------------------------------------------------------- table �����  ----------------------------------
-- insert(create) select(read) update delete   CRUD
create table month_sales (
-- column, �Ӽ�
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

delete from month_sales;  -- table �� content ��ü ����
drop table month_sales;  -- table ����
rollback; -- �Ǽ� ���� ��, �ǵ�����
commit;   -- �Ϸ�

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
group by cube(month, product_id);   -- ����� ���� ����...

select product_id, month, company, sum(money) as total
from month_sales
group by grouping sets((product_id,month),company);

select case grouping(product_id) when 1 then '��� ��ǰ' else product_id end as product_id,
       case grouping(month)      when 1 then '��� ��'   else month end as month,
       sum(money) as money_total
from month_sales
group by rollup(product_id,month);

-- pivot row, column �ٲٱ�
select deptno, job, max(sal) as high
from emp
group by deptno, job
order by deptno, job;

-- �������� select * from (�ǹ���ų ����)
--         pivot(�׷��Լ�(������ �÷�) for �ǹ�Į�� in (�ǹ� �÷��� as ����))
select * 
from(select deptno, job, sal from emp)  -- ��������
pivot(max(sal)for deptno in (10,20,30))
order by job;

select * 
from(select deptno, job, sal from emp)
pivot(max(sal) for job in (
    'CLERK' as ���,
    'SALESMAN' as �������,
    'MANAGER' as ������,
    'ANALYST' as �м���,
    'PRESIDENT' as ����
    ))
order by deptno;

-- �޺� �Ի��η�
select * 
from(select job, to_char(hiredate,'fmmm')||'��' as hire_month from emp)
pivot (count(*) for hire_month in ('1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'));

select job, to_char(hiredate,'mm') as hire_month, count(*)
from emp
group by job, hiredate;


----------------------------  �������� p.212 -------------------------------------------
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
-- inner join (����)
select * 
from emp, dept;

-- � ����(���� ��)
select *
from emp e, dept d           -- ���̺� ����(����)
where e.deptno = d.deptno;   -- ���̺�.�÷�

select empno, ename, d.deptno, dname, loc  -- �ߺ� �÷��� ������ ��� ���̺� ���� ������� ���ؾߵ�
from emp e, dept d
where e.deptno = d.deptno and sal >= 2500
order by deptno,empno;

-- �� ���� (���� ���� �ƴ�)
select *
from emp e, salgrade s
where sal between losal and hisal;

-- self  join (�ڱⰡ �ڱ⸦ �� �� �� ����)
select e1.empno, 
       e1.ename, 
       e1.mgr,
--       e2.empno as mgr_num, 
       e2.ename as mgr_name 
from emp e1, emp e2
where e1.mgr = e2.empno;

-- outer join(����Ŭ������ ����..)
select e1.empno, 
       e1.ename, 
       e1.mgr,
       e2.empno as mgr_num, 
       e2.ename as mgr_name
from emp e1, emp e2
where e1.mgr = e2.empno(+)  -- left outer join ���ǿ� �������� �ʴ� ������ ������ null�� �����Ͷ�..
order by e1.empno;

select e1.empno, 
       e1.ename, 
       e1.mgr,
       e2.empno as mgr_num, 
       e2.ename as mgr_name
from emp e1, emp e2
where e1.mgr(+) = e2.empno  -- right outer join ���ǿ� �������� �ʴ� ������ ������ null�� �����Ͷ�..
order by e1.empno;

-- ansi join(ǥ��..)
select empno, ename, job, mgr, hiredate, sal, comm, deptno, dname, loc
from emp e natural join dept d
order by deptno, empno;

select empno, ename, job, mgr, hiredate, sal, comm, deptno, dname, loc
from emp e join dept d using (deptno)
order by deptno, empno;

-- �Ʒ� ������� ����ϴ� ���� ����(�����)
select empno, ename, job, mgr, hiredate, sal, comm, d.deptno, dname, loc  -- ��ġ�� Į�� �����������
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

-- full outer join(����)
select e1.empno, 
       e1.ename, 
       e1.mgr,
       e2.empno as mgr_num, 
       e2.ename as mgr_name
from emp e1 full outer join emp e2 on (e1.mgr = e2.empno)
order by e1.empno;


------------------------------------- ��������  p.239 ------------------------------
-- Q1 ����
select e.deptno,
       dname,
       empno,
       ename,
       sal
from emp e, dept d
where e.deptno = d.deptno and sal > 2000
order by deptno;

-- Q1 ����
select e.deptno,
       dname,
       empno,
       ename,
       sal
from emp e join dept d on (e.deptno = d.deptno)
where sal > 2000
order by deptno;

-- Q2 ����
select d.deptno,
       dname,
       trunc(avg(sal)) as avg_sal,
       max(sal) as max_sal,
       min(sal) as min_sal,
       count(*) as cnt
from emp e, dept d
where d.deptno=e.deptno
group by d.deptno, dname;

-- Q2 ����
select d.deptno,
       dname,
       trunc(avg(sal)) as avg_sal,
       max(sal) as max_sal,
       min(sal) as min_sal,
       count(*) as cnt
from emp e join dept d on (d.deptno = e.deptno)
group by d.deptno,dname;

-- Q3 ����
select d.deptno,
       dname,
       empno,
       ename,
       job,
       sal
from emp e, dept d
where d.deptno = e.deptno(+)
order by deptno,ename;

-- Q3 ����
select d.deptno,
       dname,
       empno,
       ename,
       job,
       sal
from emp e right outer join dept d on (d.deptno = e.deptno)
order by deptno,ename;

-- Q4 ����
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

-- Q4 ����
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