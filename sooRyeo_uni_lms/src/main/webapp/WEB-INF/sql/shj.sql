-- 학생 테이블
select * from tbl_student;

-- 학과 테이블
select * from tbl_department;


generate_student_id()
generate_professor_id()
generate_admin_id()

INSERT INTO tbl_student (student_id, pwd, name, jubun, tel, grade, address, email, register_date, status, fk_department_seq)
VALUES (generate_student_id(), 'password123', 'John Doe', '1234567890123', '01012345678', 1, 'Some address', 'john.doe@example.com', SYSDATE, 1, 1);