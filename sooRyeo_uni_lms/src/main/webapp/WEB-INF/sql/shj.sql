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
insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content, start_date, end_date)
values(lecture_seq.nextval, '4', '1단원 영상', '1주차 수업 자료', '제 1장. 국어학개론의 이해', '1) 국어학개론의 이해', to_date(20240707, 'yyyy-mm-dd'), to_date(20240714,'yyyy-mm-dd'));

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content, start_date, end_date)
values(lecture_seq.nextval, '4', '2단원 영상', '2주차 수업 자료', '제 2장. 언어와 언어학', '1) 통계를 통해 본 자연언어의 모습 2) 인간과 언어', to_date(20240714, 'yyyy-mm-dd'), to_date(20240721,'yyyy-mm-dd'));

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content, start_date, end_date)
values(lecture_seq.nextval, '4', '3단원 영상', '3주차 수업 자료', '제 3장. 한국어의 말소리(1):자음 ', '1) 자음과 모음의 구분 2) 말소리의 생성 과정', to_date(20240721, 'yyyy-mm-dd'), to_date(20240728,'yyyy-mm-dd'));

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content, start_date, end_date)
values(lecture_seq.nextval, '4', '4단원 영상', '4주차 수업 자료', '제 4장. 한국어의 말소리(2): 모음과 초분절음', '1) 자음과 모음의 구분 2) 모음의 분류 : 단모음/이중모음 3) 단모음의 분류 기준 4) 한국어의 초분절음', to_date(20240728, 'yyyy-mm-dd'), to_date(20240804,'yyyy-mm-dd'));

commit;

-- 5번 개설수업 현대문학
insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content, start_date, end_date)
values(lecture_seq.nextval, '5', '1단원 영상', '1주차 수업 자료', '제 1장. 한국현대작가론특강', '개화기에서 1970년대 소설작품의 특징', to_date(20240707, 'yyyy-mm-dd'), to_date(20240714,'yyyy-mm-dd'));

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content, start_date, end_date)
values(lecture_seq.nextval, '5', '2단원 영상', '2주차 수업 자료', '제 2장. 한국현대시인론특강', '문학세계에 이르는 총체적인 문제들을 연구', to_date(20240714, 'yyyy-mm-dd'), to_date(20240721,'yyyy-mm-dd'));

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content, start_date, end_date)
values(lecture_seq.nextval, '5', '3단원 영상', '3주차 수업 자료', '제 3장. 한국현대비평론특강', '한국현대비평을 문학사적인 측면과 비평가론적인 측면에서 심도있게 탐구', to_date(20240721, 'yyyy-mm-dd'), to_date(20240728,'yyyy-mm-dd'));

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content, start_date, end_date)
values(lecture_seq.nextval, '5', '4단원 영상', '4주차 수업 자료', '제 4장. 한국현대시특강', '당대의 현실과 시문학의 자율성을 함께 살펴보면서 연구', to_date(20240728, 'yyyy-mm-dd'), to_date(20240804,'yyyy-mm-dd'));

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content, start_date, end_date)
values(lecture_seq.nextval, '5', '5단원 영상', '5주차 수업 자료', '제 5장. 한국현대소설특강', '특정한 경향을 띠는 작품들을 중심으로 한 소설사적 시각이나 연구방법론을 취하여 새로운 해석 및 평가', to_date(20240804, 'yyyy-mm-dd'), to_date(20240811,'yyyy-mm-dd'));

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content, start_date, end_date)
values(lecture_seq.nextval, '5', '6단원 영상', '6주차 수업 자료', '제 6장. 한국현대작가집중연구', '다양한 시각과 관점에서 작가와 작품의 관계를 파악하고 한 작가와 그의 문학 작품의 독특한 특질', to_date(20240811, 'yyyy-mm-dd'), to_date(20240818,'yyyy-mm-dd'));


-- 12번 개설수업 회계학원론
insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content, start_date, end_date)
values(lecture_seq.nextval, '12', '1단원 영상', '1주차 수업 자료', '제 1장. K-IFRS의 개념체계 (1)', '1. 재무보고와 재무제표', to_date(20240707, 'yyyy-mm-dd'), to_date(20240714,'yyyy-mm-dd'));

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content, start_date, end_date)
values(lecture_seq.nextval, '12', '2단원 영상', '2주차 수업 자료', '제 2장. K-IFRS의 개념체계 (1)', '2. 재무회계의 목적', to_date(20240714, 'yyyy-mm-dd'), to_date(20240721,'yyyy-mm-dd'));

insert into tbl_lecture(lecture_seq, fk_course_seq, video_file_name, lecture_file_name, lecture_title, lecture_content, start_date, end_date)
values(lecture_seq.nextval, '12', '3단원 영상', '3주차 수업 자료', '제 3장. K-IFRS의 개념체계 (1)', '3. 재무제표 작성의 기본 가정', to_date(20240721, 'yyyy-mm-dd'), to_date(20240728,'yyyy-mm-dd'));


select *
from tbl_lecture
order by lecture_seq asc;

select *
from tbl_course;

select lecture_seq, fk_course_seq
     , video_file_name, lecture_file_name, lecture_title
     , lecture_content
     , start_date
     , end_date
from tbl_lecture join tbl_course
on tbl_lecture.fk_course_seq = tbl_course.course_seq
where fk_course_seq = '4'
order by lecture_seq asc



select lecture_seq, fk_course_seq
     , video_file_name, lecture_file_name, lecture_title
     , lecture_content
     , start_date
     , end_date
from tbl_lecture join tbl_course
on tbl_lecture.fk_course_seq = tbl_course.course_seq
where fk_course_seq = '5' AND start_date <= sysdate AND sysdate <= end_date
order by lecture_seq asc



---- *** 어떤 테이블에 새로운 컬럼 추가하기 *** ----
/*
    alter table 테이블명 add 추가할컬럼명 데이터타입;
*/
alter table tbl_lecture 
add start_date date;

alter table tbl_lecture 
add end_date date;
-- Table TBL_LECTURE이(가) 변경되었습니다.



desc tbl_lecture;

select *
from tbl_assignment;

select *
from tbl_schedule;

SELECT *
FROM all_sequences;


SELECT V.schedule_seq_assignment, V.title, V.content, V.start_date, V.end_date, B.submit_datetime, B.fk_student_id
FROM
(
    select *
    from tbl_assignment A join tbl_schedule S
    on A.schedule_seq_assignment = S.schedule_seq
    where schedule_type = 1
)V LEFT JOIN
(
    select *
    from tbl_assignment_submit
) B
on V.schedule_seq_assignment = B.fk_schedule_seq_assignment

SELECT 
    A.schedule_seq_assignment as schedule_seq_assignment,
    S.title as title,
    A.content as content,
    S.start_date as start_date,
    S.end_date as end_date,
    B.score as score,
    B.submit_datetime as submit_datetime,
    B.attatched_file as attatched_file,
    A.fk_course_seq as fk_course_seq
FROM
    tbl_assignment A
JOIN
    tbl_schedule S ON A.schedule_seq_assignment = S.schedule_seq
LEFT JOIN
    tbl_assignment_submit B ON A.schedule_seq_assignment = B.fk_schedule_seq_assignment
WHERE
    S.schedule_type = 1


SELECT V.title, V.content, V.start_date, V.end_date, B.submit_datetime
FROM
(
    select *
    from tbl_assignment A join tbl_schedule S
    on A.schedule_seq_assignment = S.schedule_seq
    where schedule_type = 1
)V LEFT JOIN
(
    select *
    from tbl_assignment_submit
) B
on V.schedule_seq_assignment = B.fk_schedule_seq_assignment



-- 과제번호, 제목, 내용, 시작일자, 마감일자, 점수, 제출시간, 첨부파일
SELECT V.schedule_seq_assignment as schedule_seq_assignment
     , V.title as title
     , V.content as content
     , V.start_date as start_date
     , V.end_date as end_date
     , B.score as score
     , B.submit_datetime as submit_datetime
     , B.attatched_file as attatched_file
FROM
(
    select *
    from tbl_assignment A join tbl_schedule S
    on A.schedule_seq_assignment = S.schedule_seq
    where schedule_type = 1
)V LEFT JOIN
(
    select *
    from tbl_assignment_submit
) B
on V.schedule_seq_assignment = B.fk_schedule_seq_assignment




SELECT 
    A.schedule_seq_assignment as schedule_seq_assignment,
    S.title as title,
    A.content as content,
    S.start_date as start_date,
    S.end_date as end_date,
    B.score as score,
    B.submit_datetime as submit_datetime,
    A.attatched_file as attatched_file,
    A.fk_course_seq as fk_course_seq
FROM tbl_assignment A
JOIN tbl_schedule S 
ON A.schedule_seq_assignment = S.schedule_seq
LEFT JOIN tbl_assignment_submit B 
ON A.schedule_seq_assignment = B.fk_schedule_seq_assignment
WHERE A.schedule_seq_assignment = 31


-- 첨부파일 없는것
insert into tbl_assignment_submit(assignment_submit_seq, fk_schedule_seq_assignment, fk_student_id, title, content, submit_datetime) 
values(schedule_seq_assignment.nextval, #{schedule_seq_assignment}, #{student_id}, #{title}, #{content}, sysdate)


select *
from tbl_assignment_submit


delete from tbl_assignment_submit
where assignment_submit_seq between 14 and 17

commit;


select assignment_submit_seq, fk_student_id, title, content, attatched_file, submit_datetime
from tbl_assignment_submit
where fk_schedule_seq_assignment = '4'


select attatched_file
from tbl_assignment_submit
where fk_schedule_seq_assignment = '16'


/* --------------------------------------------------------------------- */
SELECT V.title as title
			 , V.content as content
			 , V.start_date as start_date
			 , V.end_date as end_date
			 , B.submit_datetime as submit_datetime
			 , V.schedule_seq_assignment as schedule_seq_assignment
			 , V.fk_course_seq as fk_course_seq
		FROM
		(
		    select *
		    from tbl_assignment A join tbl_schedule S
		    on A.schedule_seq_assignment = S.schedule_seq
		    where schedule_type = 1
		)V LEFT JOIN
		(
		    select *
		    from tbl_assignment_submit
		) B
		on V.schedule_seq_assignment = B.fk_schedule_seq_assignment
		where V.fk_course_seq = 4


-- B.fk_schedule_seq_assignment(과제번호),  B.submit_datetime(제출시간)   
select *
from tbl_assignment_submit  -- 제출

select schedule_seq_assignment  -- schedule_seq_assignment(과제번호)
from tbl_assignment -- 과제


SELECT A.schedule_seq_assignment, B.submit_datetime
FROM tbl_assignment A LEFT JOIN 
(
  select *
  from tbl_assignment_submit
  where fk_student_id = '202400009'
) B
ON A.schedule_seq_assignment = B.fk_schedule_seq_assignment;




SELECT GUAJE.schedule_seq_assignment, GUAJE_SUBMIT.submit_datetime
FROM tbl_assignment GUAJE LEFT JOIN 
(
  select *
  from tbl_assignment_submit
  where fk_student_id = '202400005'
) GUAJE_SUBMIT
ON GUAJE.schedule_seq_assignment = GUAJE_SUBMIT.fk_schedule_seq_assignment;



SELECT V.title as title
			 , V.content as content
			 , V.start_date as start_date
			 , V.end_date as end_date
			 , B.submit_datetime as submit_datetime
			 , V.schedule_seq_assignment as schedule_seq_assignment
			 , V.fk_course_seq as fk_course_seq
		FROM
		(
		    select *
		    from tbl_assignment A join tbl_schedule S
		    on A.schedule_seq_assignment = S.schedule_seq
		    where schedule_type = 1
		)V LEFT JOIN
		(
            SELECT GUAJE.schedule_seq_assignment, GUAJE_SUBMIT.submit_datetime, GUAJE_SUBMIT.fk_schedule_seq_assignment 
            FROM tbl_assignment GUAJE LEFT JOIN 
            (
              select *
              from tbl_assignment_submit
              where fk_student_id = '202400005'
            ) GUAJE_SUBMIT
            ON GUAJE.schedule_seq_assignment = GUAJE_SUBMIT.fk_schedule_seq_assignment
		) B
		on V.schedule_seq_assignment = B.fk_schedule_seq_assignment
		where V.fk_course_seq = 4;



SELECT V.title as title
			 , V.content as content
			 , V.start_date as start_date
			 , V.end_date as end_date
			 , B.submit_datetime as submit_datetime
			 , V.schedule_seq_assignment as schedule_seq_assignment
			 , V.fk_course_seq as fk_course_seq
		FROM
		(
		    select *
		    from tbl_assignment A join tbl_schedule S
		    on A.schedule_seq_assignment = S.schedule_seq
		    where schedule_type = 1
		)V LEFT JOIN
		(
            SELECT GUAJE.schedule_seq_assignment, GUAJE_SUBMIT.submit_datetime, GUAJE_SUBMIT.fk_schedule_seq_assignment 
            FROM tbl_assignment GUAJE LEFT JOIN 
            (
              select *
              from tbl_assignment_submit
              where fk_student_id = '202400009'
            ) GUAJE_SUBMIT
            ON GUAJE.schedule_seq_assignment = GUAJE_SUBMIT.fk_schedule_seq_assignment
		) B
		on V.schedule_seq_assignment = B.fk_schedule_seq_assignment
		where V.fk_course_seq = 4;

---------------------------------------------------------------------------------------

