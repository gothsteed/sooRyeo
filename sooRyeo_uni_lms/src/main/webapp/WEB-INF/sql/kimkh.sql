show user;

SELECT * FROM tabs;

INSERT INTO tbl_student (student_id, pwd, name, jubun, tel, grade, address, email, register_date, status, fk_department_seq)
VALUES (generate_student_id(), 'password123', 'John Doe', '1234567890123', '01012345678', 1, 'Some address', 'john.doe@example.com', SYSDATE, 1, 1);

select *
from tbl_student;

select *
from tbl_admin;

-- 컬럼 이름 바꾸기
alter table tbl_admin rename COLUMN admin_seq to admin_id;
commit;

-- 컬럼 데이터 변경

update tbl_admin set email = '7DiCwyc+1dXTTwg5kjvDmHehvJlz/ESJNhef/5DX+YA='
where admin_id = '202400001';


select rno, student_id
from
(select rownum AS rno, student_id
from tbl_student) V
WHERE RNO = 1

select *
from tbl_recruitment_notice;

insert into tbl_admin (admin_id, name, pwd, jubun, tel, email)
values (generate_admin_id(), '관리자', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '9101011234567', 'k6AvvKD9cZaeKhlunBk9ew==', '2kh94@naver.com');


select *
from tbl_professor;

select *
from tbl_department;

insert into tbl_professor (prof_id, pwd, name, jubun, tel, department_seq, email, office_address, employment_stat, employment_date)
values (generate_professor_id(), '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '홍길동', '9010101234567', 'k6AvvKD9cZaeKhlunBk9ew==', 2, '2kh94@naver.com', '서울특별시 서대문구 연세로 50', 1, sysdate);