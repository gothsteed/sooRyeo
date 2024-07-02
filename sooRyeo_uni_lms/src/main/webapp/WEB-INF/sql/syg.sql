select * from tbl_department;

SELECT department_name
FROM tbl_department;

insert into tbl_department(department_seq, department_name) values(department_seq.nextval, '국어국문학과');
insert into tbl_department(department_seq, department_name) values(department_seq.nextval, '국제통상학과');
insert into tbl_department(department_seq, department_name) values(department_seq.nextval, '화학공학과');
insert into tbl_department(department_seq, department_name) values(department_seq.nextval, '작곡과');
insert into tbl_department(department_seq, department_name) values(department_seq.nextval, '회계학과');

commit;

select *
from tbl_student;

delete from tbl_student
where student_id = '202400010';

commit;

INSERT INTO tbl_student (student_id, pwd, name, jubun, tel, grade, address, email, register_year, status, fk_department_seq)
VALUES (generate_student_id(), 'password123', 'John Doe', '1234567890123', '01012345678', 1, 'Some address', 'john.doe@example.com', SYSDATE, 1, 1);

ALTER TABLE tbl_student MODIFY register_year Number;

ALTER TABLE tbl_student
RENAME COLUMN register_date TO register_year;