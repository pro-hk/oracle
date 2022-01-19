-- crud   insert / select / update / delete : dml
-- create  : ddl

select * from dict;     -- ������ ����.. DBA

select * from dictionary;

select table_name
from user_tables;

select * from user_tables;

select * from all_tables;

select owner,table_name from all_tables;

-- dba table�� sys, system ������ ��ȸ ����
select * from dba_tables;

-- index : �˻��� ���� �ϱ� ���� ���
select * from user_indexes;

-- index ����
create index idx_emp_sal
on emp(sal);

select * from user_ind_columns;

drop index idx_emp_sal;

-- view : table�� masking(����) �ϱ� .. �κ����̺� - select�� ����ؾߵ�.. ������ ������
-- ���� ������ ���� ��, sys �������� grant(���� �ο�) ���� ex) grant create view to scott;
create view vw_emp20
as (
    select empno, ename, job, deptno
    from emp
    where deptno = 20
);

select * from vw_emp20;

-- ����ڰ� ������ �� Ȯ��
select * from user_views;

desc emp;

insert into emp
values (8000,'HYEOK','CLERK',NULL,'22/01/19',3000,1000,20);

select * from emp;

-- rownum : ���ȣ 
select rownum, e.*
from emp e;

-- order by ���� ������ �ٲ�
select rownum, e.*
from emp e
order by sal desc;  

-- ���������� ����Ͽ� ���� ����  -- �Խ��� ���Ľ� ����� ���� ��(rownum)
select rownum, e.*
from ( select * from emp order by sal desc ) e  -- from ���� ���� �������� : inline view
where rownum <= 3;

-- with ���� ���̺�
with e as ( select * from emp order by sal desc )
select rownum, e.*
from e
where rownum <= 3;

-- sequnece : oracle���� ����, mysql���� ���ԵǾ� ����
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

-- synonym ���Ǿ�(����)   �� �Ⱦ�
--grant create synonym to scott;
--grant create public synonym to scott;
create synonym e for emp;
drop synonym e;

select * from e;

---------------------------------------- 13�� ��������  p. 357 ------------------------------
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


---------------------------------------- ���� ���� ------------------------------------
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

-- ���� �����Ϳ� null�� ������ �ȹٲ�..
alter table table_notnull 
modify (tel not null);

alter table table_notnull 
modify (tel constraint table_notnull_tel_notnull not null);  -- constraint_name ����

alter table table_notnull
drop constraint table_notnull_tel_notnull;  -- �ɷ��ִ� ���� ���� ����

-- unique  : �ߺ� �Ұ� ( null�� ���)
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
-- �Ұ�
insert into table_pk (login_id, login_pwd, tel)
values ('','1234','010-1111-1111');
insert into table_pk (login_id, login_pwd, tel)
values ('TEST01','5678','010-2222-2222'); 

desc table_pk;
select * from table_pk;

-- foreign key  �ٸ� ���̺�� ���� ���� �α� -- ����� ���̺� ���� �־�ߵ�..
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

drop table dept_fk cascade constraints;  -- ���� ������ �־ ������ �ȵǴ� ���..

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

-- check  : ���� �ɱ�.. (��ȣ ��)
create table table_check(
    login_id varchar2(20) constraint tb_check_loginid_pk primary key,
    login_pwd varchar2(20) constraint tb_check_loginpwd_ch check (length(login_pwd) > 3),  -- front���� ���� �Ÿ��� ����
    tel varchar(20)
);

insert into table_check
values ('TEST_ID_01','1234','010-1111-2222');

-- default : null(����)�� ������ default������ �Էµ�
create table table_default(
    login_id varchar2(20) constraint tb_default_loginid_pk primary key,
    login_pwd varchar2(20) default '1234',
    tel varchar(20)
);

insert into table_default (login_id, tel)
values ('TEST_ID_01','010-1111-2222');

select * from table_default;


------------------------------------------------------ 14�� �������� p.394 --------------------------------------------
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


--------------------------------------------- ����� system �������� ���� ��������-----------------------------------------
--create user orclstudy identified by oracle;
--grant create session to orclstudy;
--grant resource, create session, create table to orclstudy;
-- ������ �������� & drop user orclstudy cascade;

-- role ����
--create role rolestudy;
--grant connect, resource, create table, create view, create synonym to rolestudy;
--grant rolestudy to orclstudy;

create user orclstudy identified by oracle;

create table temp (
    col01 varchar2(20),
    col02 varchar2(20)
);

insert into temp values ('002','�ι�° ������');

drop table temp;
select * from temp;

grant select on temp to orclstudy;   -- orclstudy�� select ���� �ο�
grant insert on temp to orclstudy;   -- orclstudy�� insert ���� �ο�

select * from orclstudy.temp;

insert into orclstudy.temp values ('003','����° ������');

-- grant to <-> revoke from (öȸ�ϴ�)
revoke insert on temp from orclstudy;

--------------------------------- 15�� �������� p.416 ----------------------------
-- Q2
grant select on emp to prev_hw;
grant select on dept to prev_hw;
grant select on salgrade to prev_hw;

revoke select on salgrade from prev_hw;