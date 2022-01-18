-- �ּ�
SELECT * FROM emp;
-- desc emp;
select empno,ename,job,mgr from emp;
-- distinct : �ߺ�����
select distinct deptno from emp;
-- all : ���� �Ƚᵵ ��
select all deptno from emp;

select distinct deptno,job from emp;

-- �޿� ������ �ñ��ϴ�  �÷��� �ٲ� �� : as ���
select ename as �̸�, sal, comm, sal*12+comm as annualincome from emp;

-- �� ���� �޴� ��� ã�� asc : ��������, desc : ��������
select * from emp
order by deptno asc, sal desc;

select * from emp 
where empno = 7369;

--�μ� ��ȣ�� 30���� �����̸鼭 job = clerk �̱� -- ���ڴ� ''�� ����
select * from emp
where deptno = 30 
and job = 'CLERK'
order by ename;

-- �μ� ��ȣ�� 20�̰ų� ������ salesman �̱�
select * from emp
where deptno = 20
or job = 'SALESMAN';

-- sal�� 3,000 �̻��� ���
select * from emp
where sal >= 3000;

-- �̸� F �̻��� ���
select * from emp
where ename >= 'F';

-- ������ 3000�� �ƴ� ��� �̱�
select * from emp
where sal <> 3000;

-- job : manager �Ǵ� saleman �Ǵ� clerk
select * from emp
where job = 'MANAGER' or
      job = 'SALESMAN' or
      job = 'CLERK'
order by job;

-- job : manager �Ǵ� saleman �Ǵ� clerk �ƴ� ���
select * from emp
where job not in ('MANAGER', 'SALESMAN','CLERK')
order by job;

-- �μ� ��ȣ�� 10, 20�� ��� �̱�
select * from emp
where deptno in (10,20);

-- ������ 2000���� �۰ų� 3000 ���� ū ���
select * from emp
where sal <= 2000 or
      sal >= 3000;
-- where sal not between 2000 and 3000;

-- ������ 2000~3000 ���̿� �ִ� ���
select * from emp
where sal between 2000 and 3000;

-- M���� �����ϴ� �̸� ã�� -- %: ���̿� ������� ��� ����
select * from emp
where ename like 'M%';

-- �ι�° ���ڰ� L�� �̸� ã�� -- _: 1����(3��° ���� : __'L')
select * from emp
where ename like '_L%';

-- �̸��� A�� ���� �̸� ã��
select * from emp
where ename like '%A%';

-- null ��ȸ�ϱ�( =�� ��ȸ �ȵ�, is�� ��ȸ)
select * from emp
where comm is null;
-- where comm is not null;

-- ������ union(union all : �ߺ� ���)
select empno, ename, sal, deptno from emp
where deptno = 20
union
select empno, ename, sal, deptno from emp
where deptno = 30;

-- ������ minus
select empno, ename, sal, deptno from emp
minus
select empno, ename, sal, deptno from emp
where deptno = 30;

-- ������ intersect
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