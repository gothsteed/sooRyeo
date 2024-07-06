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

select *
from tbl_lecture;

select *
from tbl_course;

select *
from tbl_curriculum;

-- 4번 개설수업 국어학개론
insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content)
values(lecture_seq.nextval, '4', '1단원 영상', '1주차 수업 자료', '제 1장. 국어학개론의 이해', '1) 국어학개론의 이해');

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content)
values(lecture_seq.nextval, '4', '2단원 영상', '2주차 수업 자료', '제 2장. 언어와 언어학', '1) 통계를 통해 본 자연언어의 모습 2) 인간과 언어');

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content)
values(lecture_seq.nextval, '4', '3단원 영상', '3주차 수업 자료', '제 3장. 한국어의 말소리(1):자음 ', '1) 자음과 모음의 구분 2) 말소리의 생성 과정');

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content)
values(lecture_seq.nextval, '4', '4단원 영상', '4주차 수업 자료', '제 4장. 한국어의 말소리(2): 모음과 초분절음', '1) 자음과 모음의 구분 2) 모음의 분류 : 단모음/이중모음 3) 단모음의 분류 기준 4) 한국어의 초분절음');

commit;

-- 5번 개설수업 현대문학
insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content)
values(lecture_seq.nextval, '5', '1단원 영상', '1주차 수업 자료', '제 1장. 한국현대작가론특강', '개화기에서 1970년대 소설작품의 특징');

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content)
values(lecture_seq.nextval, '5', '2단원 영상', '2주차 수업 자료', '제 2장. 한국현대시인론특강', '문학세계에 이르는 총체적인 문제들을 연구');

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content)
values(lecture_seq.nextval, '5', '3단원 영상', '3주차 수업 자료', '제 3장. 한국현대비평론특강', '한국현대비평을 문학사적인 측면과 비평가론적인 측면에서 심도있게 탐구');

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content)
values(lecture_seq.nextval, '5', '4단원 영상', '4주차 수업 자료', '제 4장. 한국현대시특강', '당대의 현실과 시문학의 자율성을 함께 살펴보면서 연구');


-- 12번 개설수업 회계학원론
insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content)
values(lecture_seq.nextval, '12', '1단원 영상', '1주차 수업 자료', '제 1장. ', '');

select *
from tbl_lecture;

tbl_course

select lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content
from tbl_lecture join tbl_course
on tbl_lecture.fk_course_seq = tbl_course.course_seq
where fk_course_seq = '4';





