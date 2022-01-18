-- 주석
-- 기본으로 제공되는 함수들.. 문자 관련
select * from emp
where upper(ename) = upper('smith');

select sal*12 as annsal from emp;

select * from emp
where lower(ename) like lower('%s%');

-- 첫 글자만 대문자
select initcap(ename) from emp;

-- 글자 수 찾기 length
select ename, length(ename) as Name_Total from emp;

select ename, length(ename) as Total from emp
where length(ename) >= 5;

-- dual : 시스템이 갖고 있는 더미테이블 / lengthb : 바이트 길이
select length('한글'), lengthb('한글') from dual;

--substr : 서브스트링.. 문자 빼오기
select job, substr(job,1,2) as 처음두개, substr(job,3,2) as 세번째에서두개, substr(job,length(job)) as 마지막 from emp;

-- 이름 중에 3번째부터 마지막까지 출력
select ename, substr(ename,3) as 세번째부터마지막 from emp;

-- instr : 몇 번째에 포함되어있는지.. instr('문자','찾을문자')
select instr('hello oracle','l') from dual;

-- instr 지정한 위치 이후로 몇 번째에 포함되어있는지.. instr('문자','찾을문자',지정위치)
select instr('hello oracle','l',5) from dual;

-- instr('문자','찾을문자',지정위치, 몇 번째에 나오는 문자)
select instr('hello oracle','l',2,2) from dual;

-- 검색... s가 포함되어있는지 확인
select * from emp
where instr(ename,'S') > 0;

-- replace('문자열','찾는문자','바꿀문자')
select '010-1234-5678' as replace_before,
       replace('010-1234-5678','-',' ') as replace01,
       replace('010-1234-5678','-') as replace02,
       replace('010-1234-5678','-','') as replace03,
       replace('010-       1234  -    5678',' ') as replace04
from dual;

-- lpad / rpad  -- 공백 메꾸기 ex) 주민번호 1******  l(r)pad('입력문자',총글자수,'채울문자')
select rpad('901212-',14,'*') as 주민번호,
       rpad('010-1234-',13,'*') as 핸드폰 
from dual;

select 'oracle', lpad('oracle',10,'#') as lpad01 from dual;

-- concat -- 문자열 연결하기.. ||
select concat(empno,concat(':',ename)) as no_and_name,
       ename||':' ||sal as name_sal
from emp;

-- trim : 자르기.. 공백제거
select '[' || '     --oracle--     ' || ']' as nottrim, 
       '[' || trim('     --oracle--     ') || ']' as trim01,
       '[' || replace('     --oracle--     ',' ') || ']' as replace,
       '[' || trim('-' from '--oracle--') || ']' as trim02,
       '[' || trim(leading '-' from '--oracle--') || ']' as trim03,  -- 왼쪽 제거
       '[' || trim(trailing '-' from '--oracle--') || ']' as trim04  -- 오른쪽 제거
from dual;

-- ltrim, rtrim
select ltrim('oracle study oops','ora') as ltrim,
       rtrim('oracle study oops','oops') as rtrim
from dual;


--------------------------------------- 숫자 --------------------------------------------
select 1234.5678, 
       round(1234.5678) as round01,
       round(1234.5678,0) as round02,
       round(1234.5678,1) as round03,
       round(1234.5678,2) as round04,
       round(1234.5678,-2) as round05
from dual;

-- trunc : 버림
select trunc(1234.5678) as trunc01,
       trunc(1234.5678,1) as trunc02,
       trunc(1234.5678,-1) as trunc03
from dual;

-- ceil 올림 / floor 버림
select ceil(1234.5678) as ceil01,
       floor(1234.5678) as floor01,
       ceil(-3.14) as ceil02,
       floor(-3.14) as floor02
from dual;

-- mod
select mod(13,4) as mod
from dual;


--------------------------- DATE 중요!! -------------------------------
-- sysdate 현재 날짜 / 연산가능
select sysdate as now,
       sysdate -1 as yesterday,
       sysdate +1 as tomorrow
from dual;

-- add_months 월 추가..
select add_months(sysdate,3) from dual;
select add_months(hiredate,120) as anniversary from emp;

-- 입사일 40년 안된 사람 출력하기
select ename, empno, hiredate, sysdate from emp
where add_months(hiredate,40*12) > sysdate;

-- months_between(날짜01,날짜02)  날짜01-날짜02
select empno,ename,hiredate,sysdate, 
       trunc(months_between(sysdate,hiredate)/12) as 근속연수
from emp;

select sysdate,
       next_day(sysdate,'월요일'),
       last_day(sysdate)
from dual;


------------------------ 형변환 -------------------------------------------
desc emp;
select empno, ename, empno+'100' from emp;  -- 암묵적 형변환
select 'abcd'+empno from emp;     -- 불가
select 'abcd'+ename from emp;  -- 불가  + -> ||

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
       to_char(sysdate,'dy') as dy,    -- 금 fri
       to_char(sysdate,'day') as day   -- 금요일 friday
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
       nvl(comm,0),  -- null값을 0으로 처리
       sal * 12 + nvl(comm,0) as annsal
from emp;

select empno, ename, 
       nvl2(comm,'o','x')  -- nvl2(null찾을값들,null존재시 실행,null미존재시 실행)   if(comm has null,true,false)
from emp;

select empno, ename,
       nvl2(comm,sal*12+comm,sal*12) as annsal 
from emp;

-- decode if()  / 표준 sql 아님.. 다른 곳에서 못씀
select empno, ename, job, sal,
       decode(job,
            'MANAGER',sal*1.1,
            'SALESMAN',sal*1.05,
            'ANALYST',sal,
            sal*1.03) as up_sal
from emp;

-- 직급을 한글로 바꿔보기
select distinct job from emp;

select empno, ename, job, sal,
       decode(job,
                'CLERK', '사원',
                'SALESMAN','영업사원',
                'PRESIDENT', '사장',
                'MANAGER', '관리자',
                '분석가') as job_kr
from emp;

-- case  표준 sql
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

-- with 임시 테이블을 만듬
with temp as (
    select 'male' gender from dual union all
    select 'female' gender from dual union all
    select 'bisexual' gender from dual
)
select gender, 
       decode(gender,
            'male', '남성',
            'female', '여성',
            '기타'
       ) as gender_kor 
       from temp;
--select * from temp;

-- comm이 없으면 해당사항 없음, comm이 0이면 수당없음, comm이 있으면 수당 300
select comm,
       case 
       when comm is null then '해당사항없음'
       when comm = 0 then '수당없음'
       else '수당 : ' || comm
       end as 수당
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
       to_char(hiredate,'q')||'분기 입사'     -- 분기
from emp;

select ename, 
       to_char(hiredate,'yyyy/mm/dd') as entry_date,
       case to_char(hiredate,'q')
        when '1' then '1분기 입사'
        when '2' then '2분기 입사'
        when '3' then '3분기 입사'
        else '4분기 입사'
       end as Quater
from emp;     

-------------------------------------------- 연습문제 -----------------------------------
-- Q1
select empno, 
       rpad(substr(empno,1,2),4,'*') as masking_empno, 
       ename,
       rpad(substr(ename,1,1),length(ename),'*') as masking_ename
from emp
where length(ename) = 5;

-- Q2 + 원화로 바꾸기
select empno, ename, sal,
       to_char(trunc(sal/21.5, 2),'L9,999.00') as day_pay,
       to_char(round(sal/21.5/8, 1),'$9,999.0') as time_pay
from emp;

-- Q3
desc emp;
select empno, ename, 
       to_char(hiredate,'yyyy/mm/dd') as hiredate, 
       to_char(next_day(add_months(hiredate,3),'월'),'yyyy-mm-dd') as r_job,
       nvl(to_char(comm),'N/A') as comm
from emp;

select empno, ename, 
       to_char(hiredate,'yyyy/mm/dd') as hiredate, 
       to_char(next_day(add_months(hiredate,3),'월'),'yyyy-mm-dd') as r_job,
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