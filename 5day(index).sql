-- crud   insert / select / update / delete : dml
-- create  : ddl

select * from dict;     -- 감춰진 정보.. DBA

select * from dictionary;

select table_name
from user_tables;

select * from user_tables;

select * from all_tables;

select owner,table_name from all_tables;

-- dba table은 sys, system 에서만 조회 가능
select * from dba_tables;

-- index : 검색을 빨리 하기 위해 사용
select * from user_indexes;

-- index 생성
create index idx_emp_sal
on emp(sal);

select * from user_ind_columns;

drop index idx_emp_sal;

-- view : table에 masking(구멍) 하기 .. 부분테이블 - select만 사용해야됨.. 수정시 연동됨
-- 생성 권한이 없을 시, sys 계정에서 grant(권한 부여) 해줌 ex) grant create view to scott;
create view vw_emp20
as (
    select empno, ename, job, deptno
    from emp
    where deptno = 20
);

select * from vw_emp20;

-- 사용자가 생성한 뷰 확인
select * from user_views;

desc emp;

insert into emp
values (8000,'HYEOK','CLERK',NULL,'22/01/19',3000,1000,20);

select * from emp;

-- rownum : 행번호 
select rownum, e.*
from emp e;

-- order by 사용시 순서가 바뀜
select rownum, e.*
from emp e
order by sal desc;  

-- 서브쿼리를 사용하여 정렬 가능  -- 게시판 정렬시 사용을 많이 함(rownum)
select rownum, e.*
from ( select * from emp order by sal desc ) e  -- from 절에 쓰는 서브쿼리 : inline view
where rownum <= 3;

-- with 가상 테이블
with e as ( select * from emp order by sal desc )
select rownum, e.*
from e
where rownum <= 3;

-- sequnece : oracle에만 있음, mysql에는 포함되어 있음
create table dept_sequence
as (select * from dept
where 1 = 0);

create sequence seq_dept_sequence 
    increment by 10
    start with 10
    maxvalue 90
    minvalue 0
    nocycle
    cache 2;
    
CREATE SEQUENCE SEQ_DEPT_SEQUENCE 
    INCREMENT BY 10 
    START WITH 10 
    MAXVALUE 90 
    MINVALUE 0 
    CYCLE 
    CACHE 2;

drop table dept_sequence;
drop sequence seq_dept_sequence;
    
insert into dept_sequence (deptno, dname, loc)
values (SEQ_DEPT_SEQUENCE.nextval,'DATABASE','SEOUL');

insert into dept_sequence (deptno, dname, loc)
values (SEQ_DEPT_SEQUENCE.nextval,'JAVA','BUSAN');

select * from dept_sequence;

insert into dept_sequence (deptno, dname, loc)
values (
    (select nvl(max(deptno),0)+1 from dept_sequence)
,'JAVA','BUSAN');

select seq_dept_sequence.currval
from dual;

alter sequence seq_dept_sequence
increment by 5
maxvalue 1000
nocycle;

-- synonym 동의어(별명)   잘 안씀
--grant create synonym to scott;
--grant create public synonym to scott;
create synonym e for emp;
drop synonym e;

select * from e;

---------------------------------------- 13장 연습문제  p. 357 ------------------------------
-- Q1
create table empidx
as ( select * from emp );

create index idx_empidx_empno
on empidx(empno);

select * from emp;
select * from empidx;

select * from user_ind_columns;

select * from user_indexes
where index_name = 'IDX_EMPIDX_EMPNO';

-- Q2
create or replace view empidx_over15k
as ( select empno, ename, job, deptno, sal, nvl2(comm,'O','X') as comm from empidx where sal > 1500 );

select * from empidx_over15k;

-- Q3
create table deptseq
as ( select * from dept);

create sequence seq_deptseq
    start with 1
    increment by 1
    MAXVALUE 99
    MINVALUE 1
    nocycle
    nocache;
    
insert into deptseq (deptno, dname, loc)
values ( seq_deptseq.nextval, 'DATABASE','SEOUL');
insert into deptseq (deptno, dname, loc)
values ( seq_deptseq.nextval, 'WEB','BUSAN');
insert into deptseq (deptno, dname, loc)
values ( seq_deptseq.nextval, 'MOBILE','ILSAN');

select * from deptseq;


---------------------------------------- 제약 조건 ------------------------------------
create table table_notnull(
    login_id varchar2(20) not null,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
    );
    
desc table_notnull;

insert into table_notnull (login_id, login_pwd, tel)
values ( 'TEST_ID_01', '1234', '010-1111-1111' );
insert into table_notnull (login_id, login_pwd, tel)
values ( 'TEST_ID_02', '3456', '010-2222-2222' );

select * from table_notnull;

select * from user_constraints;

-- 기존 데이터에 null이 있으면 안바뀜..
alter table table_notnull 
modify (tel not null);

alter table table_notnull 
modify (tel constraint table_notnull_tel_notnull not null);  -- constraint_name 지정

alter table table_notnull
drop constraint table_notnull_tel_notnull;  -- 걸려있는 제약 조건 제거

-- unique  : 중복 불가 ( null은 허용)
create table table_unique(
    login_id varchar2(20) unique,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);

insert into table_unique (login_id, login_pwd, tel)
values ('TEST01','1234','010-111-1111');
insert into table_unique (login_id, login_pwd, tel)
values (null,'1234','010-111-1111');

desc table_unique;
select * from table_unique;

-- primary key (unique + not null)
create table table_pk(
    login_id varchar2(20) primary key,
    login_pwd varchar2(20) not null,
    tel varchar2(20) 
);

insert into table_pk (login_id, login_pwd, tel)
values ('TEST01','1234','010-1111-1111');
-- 불가
insert into table_pk (login_id, login_pwd, tel)
values ('','1234','010-1111-1111');
insert into table_pk (login_id, login_pwd, tel)
values ('TEST01','5678','010-2222-2222'); 

desc table_pk;
select * from table_pk;

-- foreign key  다른 테이블과 연관 관계 맺기 -- 연결된 테이블에 값이 있어야됨..
select * from emp;

insert into emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ( 1234, 'HONG', 'JOB', 7698, SYSDATE, 2100, null, 50 );

select * from dept;

insert into dept
values ( 50, 'WEB', 'BUSAN' );

select * from user_constraints where table_name in ('EMP', 'DEPTNO');

----------- foreign key -----
create table dept_fk(
    deptno number(2) constraint deptfk_deptno_pk primary key ,
    dname varchar2(14),
    loc varchar2(20)
);

drop table dept_fk cascade constraints;  -- 제약 조건이 있어서 삭제가 안되는 경우..

create table emp_fk(
    empno number(4) constraint empfk_empno_pk primary key,
    ename varchar2(20),
    job varchar2(20),
    mgr varchar2(20),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2) constraint empfk_deptno_fk references dept_fk (deptno)
);

insert into dept_fk
values ( 10, 'WEB', 'BUSAN' );
insert into dept_fk
values ( 20, 'DB', 'SEOUL' );

insert into emp_fk (empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ( 1234, 'HONG', 'JOB', 7698, SYSDATE, 2100, null, 10 );

select * from dept_fk;
select * from emp_fk;

-- check  : 조건 걸기.. (암호 등)
create table table_check(
    login_id varchar2(20) constraint tb_check_loginid_pk primary key,
    login_pwd varchar2(20) constraint tb_check_loginpwd_ch check (length(login_pwd) > 3),  -- front에서 먼저 거르면 편함
    tel varchar(20)
);

insert into table_check
values ('TEST_ID_01','1234','010-1111-2222');

-- default : null(누락)시 지정한 default값으로 입력됨
create table table_default(
    login_id varchar2(20) constraint tb_default_loginid_pk primary key,
    login_pwd varchar2(20) default '1234',
    tel varchar(20)
);

insert into table_default (login_id, tel)
values ('TEST_ID_01','010-1111-2222');

select * from table_default;


------------------------------------------------------ 14장 연습문제 p.394 --------------------------------------------
-- Q1
create table dept_const (
    deptno number(2) constraint deptconst_deptno_pk primary key,
    dname varchar2(14) constraint deptconst_dname_unq unique,
    loc varchar2(13) constraint deptconst_loc_nn not null
);

create table emp_const (
    empno number(4) constraint empconst_empno_pk primary key,
    ename varchar2(10) constraint empconst_ename_nn not null,
    job varchar2(9),
    tel varchar2(20) constraint empconst_tel_unq unique,
    hiredate date,
    sal number(7,2) constraint mepconst_sal_chk check (sal between 1000 and 9999 ),
    comm number(7,2),
    deptno number(2) constraint empconst_deptno_fk references dept_const(deptno)
);

select table_name, constraint_name, constraint_type from user_constraints
where table_name in ('DEPT_CONST', 'EMP_CONST');


--------------------------------------------- 사용자 system 계정에서 권한 설정가능-----------------------------------------
--create user orclstudy identified by oracle;
--grant create session to orclstudy;
--grant resource, create session, create table to orclstudy;
-- 삭제시 접속해제 & drop user orclstudy cascade;

-- role 역할
--create role rolestudy;
--grant connect, resource, create table, create view, create synonym to rolestudy;
--grant rolestudy to orclstudy;

create user orclstudy identified by oracle;

create table temp (
    col01 varchar2(20),
    col02 varchar2(20)
);

insert into temp values ('002','두번째 데이터');

drop table temp;
select * from temp;

grant select on temp to orclstudy;   -- orclstudy에 select 권한 부여
grant insert on temp to orclstudy;   -- orclstudy에 insert 권한 부여

select * from orclstudy.temp;

insert into orclstudy.temp values ('003','세번째 데이터');

-- grant to <-> revoke from (철회하다)
revoke insert on temp from orclstudy;

--------------------------------- 15장 연습문제 p.416 ----------------------------
-- Q2
grant select on emp to prev_hw;
grant select on dept to prev_hw;
grant select on salgrade to prev_hw;

revoke select on salgrade from prev_hw;