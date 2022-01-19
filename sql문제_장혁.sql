select * from emp;
--  Q1 ������� �ٹ��ϰ� �ִ� �ٹ� �μ��� ��ȣ�� �ߺ����� �������ÿ�.  
select distinct(deptno) from emp;

-- Q2 ������� �̸��� ������ ���� ������� �����´�. 000 ����� ��� ������ XXX �Դϴ�.  
select ename||' ����� ��� ������ '||job||'�Դϴ�.' as ����2
from emp;

-- Q3 �� ������� �޿��װ� �޿��׿��� 1000�� ���� ��, 200�� �� ��, 2�� ���� ��, 2�� ���� ���� �������ÿ�.  
select ename, sal, sal+1000, sal-200, sal*2, sal/2
from emp;

-- Q4 �� ����� �޿���, Ŀ�̼�, �޿� + Ŀ�̼� �׼��� �������ÿ�. 
select ename, sal, nvl(comm,0) as comm , sal+nvl(comm,0) as sal_comm
from emp;

-- Q5 ����� �̸��� ��� ��ȣ�� �����´�.
select ename, empno 
from emp;

-- Q6 ����� �̸��� ��� ��ȣ, ����, �޿��� �����´�.
select ename, empno, job, sal
from emp;

-- Q7 �μ� ��ȣ�� �μ� �̸��� �����´�.
select deptno, dname
from dept;

-- Q8 �μ��� ��� ������ �����´�.
select * from dept;

-- Q9 ����� ��� ������ �����´�.
select * from emp;

-- Q10 �ٹ� �μ��� 10���� ������� �����ȣ, �̸�, �ٹ� �μ��� �����´�. 
select empno, ename, deptno
from emp
where deptno = 10;

-- Q11 �ٹ� �μ� ��ȣ�� 10���� �ƴ� ������� �����ȣ, �̸�, �ٹ� �μ� ��ȣ�� �����´�.
select empno, ename, deptno
from emp
where deptno <> 10;

-- Q12 �޿��� 1500�̻��� ������� �����ȣ, �̸�, �޿��� �����´�.
select empno, ename, deptno
from emp
where sal > 1500;

-- Q13 �̸��� SMITH ����� �����ȣ, �̸�, ����, �޿��� �����´�. 
select empno, ename, job, sal
from emp
where ename = 'SMITH';

-- Q14 ������ SALESMAN�� ����� �����ȣ, �̸�, ������ �����´�. 
select empno, ename, job
from emp
where job = 'SALESMAN';

-- Q15 ������ CLERK�� �ƴ� ����� �����ȣ, �̸�, ������ �����´�. 
select empno, ename, job
from emp
where job != 'CLERK';

-- Q16 1982�� 1�� 1�� ���Ŀ� �Ի��� ����� �����ȣ, �̸�, �Ի����� �����´�. 
select empno, ename, hiredate
from emp
where hiredate > '1982/01/01';

-- Q17 10�� �μ����� �ٹ��ϰ� �ִ� ������ MANAGER�� ����� �����ȣ, �̸�, �ٹ��μ�, ������ �����´�.  
select empno, ename, deptno, job
from emp
where deptno = 10 and job = 'MANAGER';

-- Q18 �Ի�⵵�� 1981���� ����߿� �޿��� 1500 �̻��� ����� �����ȣ, �̸�, �޿�, �Ի����� �����´�.  
select empno, ename, sal, hiredate
from emp
where to_char(hiredate,'yyyy') = '1981' and sal > 1500;

-- Q19 20�� �μ��� �ٹ��ϰ� �ִ� ��� �߿� �޿��� 1500 �̻��� ����� �����ȣ, �̸�, �μ���ȣ, �޿��� �����´�.
select empno, ename, deptno, sal
from emp
where deptno = 20 and sal > 1500;

-- Q20 ��� ��� ��ȣ�� 7698���� ����߿� ������ CLERK�� ����� �����ȣ, �̸�, ���ӻ����ȣ, ������ �����´�.
select empno, ename, mgr, job
from emp
where mgr = 7698 and job = 'CLERK';

-- Q21 �޿��� 2000���� ũ�ų� 1000���� ���� ����� �����ȣ, �̸�, �޿��� �����´�.
select empno, ename, sal
from emp
where sal > 2000 or sal < 1000;

-- Q22 �μ���ȣ�� 20�̰ų� 30�� ����� �����ȣ, �̸�, �μ���ȣ�� �����´�.
select empno, ename, deptno
from emp
where deptno in (20,30);

-- Q23 ������ CLERK, SALESMAN, ANALYST�� ����� �����ȣ, �̸�, ������ �����´�.
select empno, ename, job
from emp
where job in ('CLERK','SALESMAN','ANALYST');

-- Q24 ��� ��ȣ�� 7499, 7566, 7839�� �ƴ� ������� �����ȣ, �̸��� �����´�
select empno, ename
from emp
where empno not in (7499, 7566, 7839);

-- Q25 �̸��� F�� �����ϴ� ����� �̸��� ��� ��ȣ�� �����´�.
select ename, empno
from emp
where ename like ('F%');

-- Q26 �̸��� S�� ������ ����� �̸��� ��� ��ȣ�� �����´�.
select ename, empno
from emp
where ename like ('%S');

-- Q27 �̸��� A�� ���ԵǾ� �ִ� ����� �̸��� ��� ��ȣ�� �����´�.
select ename, empno
from emp
where ename like ('%A%');

-- Q28 �̸��� �ι�° ���ڰ� A�� ����� ��� �̸�, ��� ��ȣ�� �����´�.
select ename, empno
from emp
where ename like ('_A%');

-- Q29 �̸��� 4������ ����� ��� �̸�, ��� ��ȣ�� �����´�.
select ename, empno
from emp
where length(ename) = 4;

-- Q30 ����߿� Ŀ�̼��� ���� �ʴ� ����� �����ȣ, �̸�, Ŀ�̼��� �����´�.
select empno, ename, comm
from emp
where comm is null;

-- Q31 ȸ�� ��ǥ(���ӻ���� ���� ���)�� �̸��� �����ȣ�� �����´�.
select ename, empno
from emp
where mgr is null;

-- Q32 ����� �����ȣ, �̸�, �޿��� �����´�. �޿��� �������� �������� ������ �Ѵ�.
select empno, ename, sal
from emp
order by sal;

-- Q33 ����� �����ȣ, �̸�, �޿��� �����´�. �����ȣ�� �������� �������� ������ �Ѵ�.
select empno, ename, sal
from emp
order by empno desc;

-- Q34 ����� �����ȣ, �̸��� �����´�, ����� �̸��� �������� �������� ������ �Ѵ�.
select empno, ename
from emp
order by ename;

-- Q35 ����� �����ȣ, �̸�, �Ի����� �����´�. �Ի����� �������� �������� ������ �Ѵ�.
select empno, ename, hiredate
from emp
order by hiredate desc;

-- Q36 ������ SALESMAN�� ����� ����̸�, �����ȣ, �޿��� �����´�. �޿��� �������� �������� ������ �Ѵ�.
select ename, empno, sal
from emp
where job = 'SALESMAN'
order by sal;

-- Q37 1981�⿡ �Ի��� ������� �����ȣ, ��� �̸�, �Ի����� �����´�. ��� ��ȣ�� �������� �������� ������ �Ѵ�.
select empno, ename, hiredate
from emp
where to_char(hiredate,'yyyy') = '1981'
order by empno desc;

-- Q38 ����� �̸�, �޿�, Ŀ�̼��� �����´�. Ŀ�̼��� �������� �������� ������ �Ѵ�.
select ename, sal, comm
from emp
order by comm;

-- Q39 ����� �̸�, �޿�, Ŀ�̼��� �����´�. Ŀ�̼��� �������� �������� ������ �Ѵ�.
select ename, sal, comm
from emp
order by comm desc;

-- Q40 �������� �޿��� 2000 �谨�ϰ� �谨�� �޿����� ���밪�� ���Ѵ�.
select ABS(sal-2000) as sal
from emp;

-- Q41 �޿��� 1500 �̻��� ����� �޿��� 15% �谨�Ѵ�. �� �Ҽ��� ���ϴ� ������.
select trunc(sal*0.85) as sal
from emp
where sal >= 1500;

-- Q42 �޿��� 2õ ������ ������� �޿��� 20%�� �λ��Ѵ�. �� 10�� �ڸ��� �������� �ݿø��Ѵ�.
select ROUND(sal*1.2, -2) as sal
from emp
where sal <= 2000;

-- Q43 �� ������ �޿��� 10�ڸ� ���ϸ� �谨�Ѵ�
select trunc(sal,-2) as sal
from emp;

-- Q44. �� ����� �μ� �̸��� �����´�. ex) 10 : �λ��, 20 : ���ߺ�, 30 : ���������,    40 : �����
select deptno, 
    case deptno
        when 10 then '�λ��'
        when 20 then '���ߺ�'
        when 30 then '�濵������'
        when 40 then '�����'
    end as deptno_kor
from dept;

-- Q45 ���޿� ���� �λ�� �޿����� �����´�. ex) CLERK : 10% / SALESMAN : 15% / PRESIDENT : 200% / MANAGER : 5% / ANALYST : 20%
select job, sal, case job
    when 'CLERK'     then sal * 1.1
    when 'SALESMAN'  then sal * 1.15
    when 'PRESIDENT' then sal * 1.2
    when 'MANAGER'   then sal * 1.05
    when 'ANALYST'    then sal * 1.2
    end as increase_sal
from emp;

-- Q46 �޿��� �� ����� �����´�.  ex) 1000 �̸� : C��� / 1000 �̻� 2000�̸� : B��� / 2000 �̻� : A���
select sal, case 
    when sal < 1000 then 'C���'
    when sal between 1000 and 2000 then 'B���'
    when sal > 2000 then 'A���' 
    end as grade
from emp;

-- Q47 �������� �޿��� ������ ���� �λ��Ѵ�.  ex) 1000 ���� : 100% / 1000 �ʰ� 2000�̸� : 50% / 2000 �̻� : 200%
select sal, case
    when sal <= 1000 then sal * 2
    when sal > 1000 and sal < 2000 then sal * 1.5
    when sal >= 2000 then sal * 3 
    end as increase_sal
from emp;

-- Q48 ������� Ŀ�̼� ������ ���Ѵ�.
select sum(comm)
from emp;

-- Q49 �޿��� 1500 �̻��� ������� �޿� ������ ���Ѵ�.
select sum(sal)
from emp
where sal >= 1500;

-- Q50 20�� �μ��� �ٺ��ϰ� �ִ� ������� �޿� ������ ���Ѵ�.
select sum(sal)
from emp
where deptno = 20;

-- Q51 ������ SALESMAN�� ������� �޿� ������ ���Ѵ�.
select sum(sal)
from emp
where job = 'SALESMAN';

-- Q52 ������ SALESMAN�� ������� �̸��� �޿������� �����´�.
select ename, sal
from emp
where job = 'SALESMAN';
--group by job;

-- Q53 �� ����� �޿� ����� ���Ѵ�.
select trunc(avg(sal))
from emp;

-- Q54 Ŀ�̼��� �޴� ������� Ŀ�̼� ����� ���Ѵ�.
select trunc(avg(comm))
from emp
where comm is not null;

-- Q55 �� ����� Ŀ�̼��� ����� ���Ѵ�.
select trunc(avg(nvl(comm,0)))
from emp;

-- Q56 Ŀ�̼��� �޴� ������� �޿� ����� ���Ѵ�.
select trunc(avg(sal))
from emp
where comm is not null;

-- Q57 30�� �μ��� �ٹ��ϰ� �ִ� ������� �޿� ����� ���Ѵ�.
select trunc(avg(sal))
from emp
where deptno = 30;

-- Q58 ������ SALESMAN�� ������� �޿� + Ŀ�̼� ����� ���Ѵ�.
select trunc(avg(sal + nvl(comm,0)))
from emp
where job = 'SALESMAN';

-- Q59 ������� �� ���� �����´�.
select count(*)
from emp;

-- Q60 Ŀ�̼��� �޴� ������� �� ���� �����´�.
select count(comm)
from emp;

-- Q61 ������� �޿� �ִ�, �ּҰ��� �����´�.
select max(sal), min(sal)
from emp;

-- Q62 �� �μ��� ������� �޿� ����� ���Ѵ�.
select deptno, trunc(avg(sal))
from emp
group by deptno;

-- Q63 �� ������ ������� �޿� ������ ���Ѵ�.
select job, sum(sal)
from emp
group by job;

-- Q64 1500 �̻� �޿��� �޴� ������� �μ��� �޿� ����� ���Ѵ�.
select deptno, trunc(avg(sal))
from emp
where sal >= 1500
group by deptno;

-- Q65 �μ��� ��� �޿��� 2000�̻��� �μ��� �޿� ����� �����´�.
select deptno, trunc(avg(sal))
from emp
group by deptno
having avg(sal) >= 2000;

-- Q66 �μ��� �ִ� �޿����� 3000������ �μ��� �޿� ������ �����´�.
select deptno, max(sal), sum(sal)
from emp
group by deptno
having max(sal) <= 3000;

-- Q67 �μ��� �ּ� �޿����� 1000 ������ �μ����� ������ CLERK�� ������� �޿� ������ ���Ѵ�
select deptno, job, min(sal), sum(sal)
from emp
where job = 'CLERK'
group by deptno, job
having min(sal) < 1000;

-- Q68 �� �μ��� �޿� �ּҰ� 900�̻� �ִ밡 10000������ �μ��� ����� ��1500�̻��� �޿��� �޴� ������� ��� �޿����� �����´�.
select deptno, min(sal), max(sal), trunc(avg(sal))
from emp
where sal >= 1500
group by deptno
having min(sal) >= 900 and max(sal) <= 10000;

-- Q69 ����� �����ȣ, �̸�, �ٹ��μ� �̸��� �����´�.
select empno, ename, d.deptno,dname
from emp e join dept d on (e.deptno = d.deptno);

-- Q70 ����� �����ȣ, �̸�, �ٹ������� �����´�.
select empno, ename, d.deptno, loc
from emp e join dept d on (e.deptno = d.deptno);

-- Q71 DALLAS�� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, ������ �����´�.
select empno, ename, job
from emp e join dept d on (e.deptno = d.deptno)
where d.loc = 'DALLAS';

-- Q72 SALES �μ��� �ٹ��ϰ� �ִ� ������� �޿� ����� �����´�.
select trunc(avg(sal))
from emp e join dept d on (e.deptno = d.deptno)
where d.dname = 'SALES';

-- Q73 1982�⿡ �Ի��� ������� �����ȣ, �̸�, �Ի���, �ٹ��μ��̸��� �����´�.
select empno, ename, hiredate, dname
from emp e join dept d on (e.deptno = d.deptno)
where to_char(hiredate,'yyyy') = '1982';

-- Q74 �� ������� �����ȣ, �̸�, �޿�, �޿������ �����´�.
select empno, ename, sal, grade
from emp join salgrade on (sal between losal and hisal);

-- Q75 SALES �μ��� �ٹ��ϰ� �ִ� ����� �����ȣ, �̸�, �޿������ �����´�.
select empno, ename, grade, d.deptno
from dept d ,emp e ,salgrade s 
where sal between losal and hisal
and d.deptno = e.deptno
and d.dname = 'SALES';

-- Q76 �� �޿� ��޺� �޿��� ���հ� ���, ����Ǽ�, �ִ�޿�, �ּұ޿��� �����´�.
select grade, sum(sal), trunc(avg(sal)), count(*), max(sal), min(sal)
from emp e join salgrade s on (sal between losal and hisal)
group by grade
order by grade;

-- 77. �޿� ����� 4����� ������� �����ȣ, �̸�, �޿�, �ٹ��μ��̸�, �ٹ������� �����´�.

--(hint) self join �̿�
--78. SMITH ����� �����ȣ, �̸�, ���ӻ�� �̸��� �����´�.
--79. FORD ��� �ؿ��� ���ϴ� ������� �����ȣ, �̸�, ������ �����´�.
--80. SMITH ����� ���ӻ���� ������ ������ ������ �ִ� ������� �����ȣ, �̸�, ������ �����´�.
--
--(hint) outer join �̿�
--81. �� ����� �̸�, �����ȣ, ������ �̸��� �����´�. �� ���ӻ���� ���� ����� �����´�.
--82. ��� �μ��� �Ҽ� ����� �ٹ��μ���, �����ȣ, ����̸�, �޿��� �����´�
--
--
--(hint) subquery
--83. SMITH����� �ٹ��ϰ� �ִ� �μ��� �̸��� �����´�.
--84. SMITH�� ���� �μ��� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, �޿���, �μ��̸��� �����´�.
--85. MARTIN�� ���� ������ ������ �ִ� ������� �����ȣ, �̸�, ������ �����´�.
--86. ALLEN�� ���� ���ӻ���� ���� ������� �����ȣ, �̸�, ���ӻ���̸��� �����´�.
--87. WARD�� ���� �μ��� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, �μ���ȣ�� �����´�.
--88. SALESMAN�� ��� �޿����� ���� �޴� ������� �����ȣ, �̸�, �޿��� �����´�.
--89. DALLAS ������ �ٹ��ϴ� ������� ��� �޿��� �����´�.
--90. SALES �μ��� �ٹ��ϴ� ������� �����ȣ, �̸�, �ٹ������� �����´�
--91. CHICAGO ������ �ٹ��ϴ� ����� �� BLAKE�� ���ӻ���� ������� �����ȣ, �̸�, ������ �����´�.	
--
--
--(hint) ����� �ϳ� �̻��� subquery�� in,some,any , all  �� �̿��Ѵ�.
--92. 3000 �̻��� �޿��� �޴� ������ ���� �μ��� �ٹ��ϰ� �ִ� ����� �����ȣ, �̸�, �޿��� �����´�
--93. ������ CLERK�� ����� ������ �μ��� �ٹ��ϰ� �ִ� ������� �����ȣ, �̸�, �Ի��� �����´�.

