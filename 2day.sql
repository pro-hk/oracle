-- �ּ�
-- �⺻���� �����Ǵ� �Լ���.. ���� ����
select * from emp
where upper(ename) = upper('smith');

select sal*12 as annsal from emp;

select * from emp
where lower(ename) like lower('%s%');

-- ù ���ڸ� �빮��
select initcap(ename) from emp;

-- ���� �� ã�� length
select ename, length(ename) as Name_Total from emp;

select ename, length(ename) as Total from emp
where length(ename) >= 5;

-- dual : �ý����� ���� �ִ� �������̺� / lengthb : ����Ʈ ����
select length('�ѱ�'), lengthb('�ѱ�') from dual;

--substr : ���꽺Ʈ��.. ���� ������
select job, substr(job,1,2) as ó���ΰ�, substr(job,3,2) as ����°�����ΰ�, substr(job,length(job)) as ������ from emp;

-- �̸� �߿� 3��°���� ���������� ���
select ename, substr(ename,3) as ����°���͸����� from emp;

-- instr : �� ��°�� ���ԵǾ��ִ���.. instr('����','ã������')
select instr('hello oracle','l') from dual;

-- instr ������ ��ġ ���ķ� �� ��°�� ���ԵǾ��ִ���.. instr('����','ã������',������ġ)
select instr('hello oracle','l',5) from dual;

-- instr('����','ã������',������ġ, �� ��°�� ������ ����)
select instr('hello oracle','l',2,2) from dual;

-- �˻�... s�� ���ԵǾ��ִ��� Ȯ��
select * from emp
where instr(ename,'S') > 0;

-- replace('���ڿ�','ã�¹���','�ٲܹ���')
select '010-1234-5678' as replace_before,
       replace('010-1234-5678','-',' ') as replace01,
       replace('010-1234-5678','-') as replace02,
       replace('010-1234-5678','-','') as replace03,
       replace('010-       1234  -    5678',' ') as replace04
from dual;

-- lpad / rpad  -- ���� �޲ٱ� ex) �ֹι�ȣ 1******  l(r)pad('�Է¹���',�ѱ��ڼ�,'ä�﹮��')
select rpad('901212-',14,'*') as �ֹι�ȣ,
       rpad('010-1234-',13,'*') as �ڵ��� 
from dual;

select 'oracle', lpad('oracle',10,'#') as lpad01 from dual;

-- concat -- ���ڿ� �����ϱ�.. ||
select concat(empno,concat(':',ename)) as no_and_name,
       ename||':' ||sal as name_sal
from emp;

-- trim : �ڸ���.. ��������
select '[' || '     --oracle--     ' || ']' as nottrim, 
       '[' || trim('     --oracle--     ') || ']' as trim01,
       '[' || replace('     --oracle--     ',' ') || ']' as replace,
       '[' || trim('-' from '--oracle--') || ']' as trim02,
       '[' || trim(leading '-' from '--oracle--') || ']' as trim03,  -- ���� ����
       '[' || trim(trailing '-' from '--oracle--') || ']' as trim04  -- ������ ����
from dual;

-- ltrim, rtrim
select ltrim('oracle study oops','ora') as ltrim,
       rtrim('oracle study oops','oops') as rtrim
from dual;


--------------------------------------- ���� --------------------------------------------
select 1234.5678, 
       round(1234.5678) as round01,
       round(1234.5678,0) as round02,
       round(1234.5678,1) as round03,
       round(1234.5678,2) as round04,
       round(1234.5678,-2) as round05
from dual;

-- trunc : ����
select trunc(1234.5678) as trunc01,
       trunc(1234.5678,1) as trunc02,
       trunc(1234.5678,-1) as trunc03
from dual;

-- ceil �ø� / floor ����
select ceil(1234.5678) as ceil01,
       floor(1234.5678) as floor01,
       ceil(-3.14) as ceil02,
       floor(-3.14) as floor02
from dual;

-- mod
select mod(13,4) as mod
from dual;


--------------------------- DATE �߿�!! -------------------------------
-- sysdate ���� ��¥ / ���갡��
select sysdate as now,
       sysdate -1 as yesterday,
       sysdate +1 as tomorrow
from dual;

-- add_months �� �߰�..
select add_months(sysdate,3) from dual;
select add_months(hiredate,120) as anniversary from emp;

-- �Ի��� 40�� �ȵ� ��� ����ϱ�
select ename, empno, hiredate, sysdate from emp
where add_months(hiredate,40*12) > sysdate;

-- months_between(��¥01,��¥02)  ��¥01-��¥02
select empno,ename,hiredate,sysdate, 
       trunc(months_between(sysdate,hiredate)/12) as �ټӿ���
from emp;

select sysdate,
       next_day(sysdate,'������'),
       last_day(sysdate)
from dual;


------------------------ ����ȯ -------------------------------------------
desc emp;
select empno, ename, empno+'100' from emp;  -- �Ϲ��� ����ȯ
select 'abcd'+empno from emp;     -- �Ұ�
select 'abcd'+ename from emp;  -- �Ұ�  + -> ||

-- to_char(), to_number(), to_date()
select to_char(sysdate,'yyyy-mm-dd') as today,
       to_char(sysdate,'yyyy-mm-dd hh:mi:ss') as today01,
       to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') as today02
from dual;

select sysdate,
       to_char(sysdate,'mm') as mm, 
       to_char(sysdate,'mon') as mon,   -- jan
       to_char(sysdate,'month') as month,  -- january
       to_char(sysdate,'dd') as dd, 
       to_char(sysdate,'dy') as dy,    -- �� fri
       to_char(sysdate,'day') as day   -- �ݿ��� friday
from dual;

select sysdate,
       to_char(sysdate,'mm') as mm,
       to_char(sysdate,'mon','nls_date_language = korean') as mon_kor,
       to_char(sysdate,'mon','nls_date_language = english') as mon_eng,
       initcap(to_char(sysdate,'month','nls_date_language = english')) as month_eng
from dual;

select sysdate,
       to_char(sysdate,'mm') as mm,
       to_char(sysdate,'dd') as dd,
       to_char(sysdate,'dy') as dy,
       to_char(sysdate,'dy','nls_date_language = english') as eng_dy,
       to_char(sysdate,'day') as day,
       to_char(sysdate,'day','nls_date_language = english') as eng_day,
       to_char(sysdate,'day','nls_date_language = japanese') as jpn_day
from dual;

select sal,
       to_char(sal,'9,999.00') as sal01,
       to_char(sal,'$9,999') as dollar ,
       to_char(sal,'L9,999') as won
from emp;

select to_number('1300') - to_number('1200') from dual;

select * from emp
where hiredate > to_date('1981/06/01','yyyy/mm/dd');

-- null
select empno, ename, comm, sal+comm,
       nvl(comm,0),  -- null���� 0���� ó��
       sal * 12 + nvl(comm,0) as annsal
from emp;

select empno, ename, 
       nvl2(comm,'o','x')  -- nvl2(nullã������,null����� ����,null������� ����)   if(comm has null,true,false)
from emp;

select empno, ename,
       nvl2(comm,sal*12+comm,sal*12) as annsal 
from emp;

-- decode if()  / ǥ�� sql �ƴ�.. �ٸ� ������ ����
select empno, ename, job, sal,
       decode(job,
            'MANAGER',sal*1.1,
            'SALESMAN',sal*1.05,
            'ANALYST',sal,
            sal*1.03) as up_sal
from emp;

-- ������ �ѱ۷� �ٲ㺸��
select distinct job from emp;

select empno, ename, job, sal,
       decode(job,
                'CLERK', '���',
                'SALESMAN','�������',
                'PRESIDENT', '����',
                'MANAGER', '������',
                '�м���') as job_kr
from emp;

-- case  ǥ�� sql
select empno, ename, job, sal,
       case job
        when 'MANAGER'  then sal*1.1
        when 'SALESMAN' then sal*1.05
        when 'ANALYST'  then sal
        else sal*1.03
        end as up_sal
from emp;

select empno, ename, job, sal,
       case 
        when job = 'MANAGER'  then sal*1.1
        when job = 'SALESMAN' then sal*1.05
        when job = 'ANALYST'  then sal
        else sal*1.03
        end as up_sal
from emp;

-- with �ӽ� ���̺��� ����
with temp as (
    select 'male' gender from dual union all
    select 'female' gender from dual union all
    select 'bisexual' gender from dual
)
select gender, 
       decode(gender,
            'male', '����',
            'female', '����',
            '��Ÿ'
       ) as gender_kor 
       from temp;
--select * from temp;

-- comm�� ������ �ش���� ����, comm�� 0�̸� �������, comm�� ������ ���� 300
select comm,
       case 
       when comm is null then '�ش���׾���'
       when comm = 0 then '�������'
       else '���� : ' || comm
       end as ����
from emp; 

-- sal 2900 diamond / sal 2700 gold / sal 2000 silver / bronze
select ename, sal,
       case 
       when sal >= 2900 then 'Diamond'
       when sal >= 2700 then 'GOLD'
       when sal >= 2000 then 'Silver'
       else 'Bronze'
       end as GRADE
from emp order by sal;

select ename, hiredate, 
       to_char(hiredate,'q')||'�б� �Ի�'     -- �б�
from emp;

select ename, 
       to_char(hiredate,'yyyy/mm/dd') as entry_date,
       case to_char(hiredate,'q')
        when '1' then '1�б� �Ի�'
        when '2' then '2�б� �Ի�'
        when '3' then '3�б� �Ի�'
        else '4�б� �Ի�'
       end as Quater
from emp;     

-------------------------------------------- �������� -----------------------------------
-- Q1
select empno, 
       rpad(substr(empno,1,2),4,'*') as masking_empno, 
       ename,
       rpad(substr(ename,1,1),length(ename),'*') as masking_ename
from emp
where length(ename) = 5;

-- Q2 + ��ȭ�� �ٲٱ�
select empno, ename, sal,
       to_char(trunc(sal/21.5, 2),'L9,999.00') as day_pay,
       to_char(round(sal/21.5/8, 1),'$9,999.0') as time_pay
from emp;

-- Q3
desc emp;
select empno, ename, 
       to_char(hiredate,'yyyy/mm/dd') as hiredate, 
       to_char(next_day(add_months(hiredate,3),'��'),'yyyy-mm-dd') as r_job,
       nvl(to_char(comm),'N/A') as comm
from emp;

select empno, ename, 
       to_char(hiredate,'yyyy/mm/dd') as hiredate, 
       to_char(next_day(add_months(hiredate,3),'��'),'yyyy-mm-dd') as r_job,
       case 
       when to_char(comm) is null then 'N/A'
       else ''||comm
       end as comm
from emp;

-- Q4
select empno, ename, mgr, 
       case 
            when mgr is null then '0000'
            when substr(mgr,1,2) = 75 then '5555'
            when substr(mgr,1,2) = 76 then '6666'
            when substr(mgr,1,2) = 77 then '7777'
            when substr(mgr,1,2) = 78 then '8888'
            else to_char(mgr)
       end as chg_mgr
from emp;