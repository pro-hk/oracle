-- sys
create user tis identified by 1234;
grant create session, create table, create view, create sequence to user_role;
grant resource, create synonym to tis;
create role user_role
grant user_role to tis;

-- tis
create table member (
    id number(4) primary key,
    name varchar2(20),
    email varchar2(20),
    hp varchar2(13),
    regdate date
);
drop table member;
insert into member values(SEQ_MEMBER.nextval,'jang','jang@naver.com','010-1111-1111',sysdate);
select * from member;
commit;
update member 
set name = 'Jang',
    email = 'Jang@naver.com',
    hp = '010-1111-1111'
where id = 1003;

delete from member where id = 1002;
rollback;