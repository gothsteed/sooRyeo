-- 학생 테이블
select * from tbl_student;

-- 학과 테이블
select * from tbl_department;



generate_student_id()
generate_professor_id()
generate_admin_id()

INSERT INTO tbl_student (student_id, pwd, name, jubun, tel, grade, address, email, register_date, status, fk_department_seq)
VALUES (generate_student_id(), 'password123', 'John Doe', '1234567890123', '01012345678', 1, 'Some address', 'john.doe@example.com', SYSDATE, 1, 1);


select department_name
from tbl_department join tbl_student
on tbl_department.department_seq = tbl_student.fk_department_seq
where student_id = '';

/*
   alter table 테이블명 add 추가할컬럼명 데이터타입;
*/

alter table tbl_student
add postcode Nvarchar2(200);

alter table tbl_student
add detailAddress Nvarchar2(200);

alter table tbl_student
add extraAddress Nvarchar2(200);

-- Table TBL_STUDENT이(가) 변경되었습니다.


update tbl_student set postcode = '03217'
update tbl_student set detailaddress = '3층 G클래스'
update tbl_student set extraaddress = '쌍용강북교육센터'

-- 3개 행 이(가) 업데이트되었습니다.

desc tbl_student

-- 우편번호, 주소, 상세주소, 추가주소 not null 만들기!
/*
    alter table 테이블명 add 추가할컬럼명 데이터타입 default 기본값 not null;  <-- 테이블명에 insert 되어진 행이 있을 경우에 가능함.!!
*/   

ALTER TABLE tbl_student MODIFY (postcode NOT NULL);

ALTER TABLE tbl_student MODIFY (detailaddress NOT NULL);

ALTER TABLE tbl_student MODIFY (extraaddress NOT NULL);














