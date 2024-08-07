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

alter table tbl_student
add finish_date DATE;

select *
from tbl_student

commit;



update tbl_lecture set lecture_time = 5
where lecture_seq = 26;


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
where fk_student_id = '202400009'

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



SELECT  V.schedule_seq_assignment as schedule_seq_assignment,
        V.title as title,
        V.content as content,
        V.start_date as start_date,
        V.end_date as end_date,
        B.score as score,
        B.submit_datetime as submit_datetime,
        V.attatched_file as attatched_file,
        V.schedule_seq_assignment as schedule_seq_assignment,
        B.fk_student_id as fk_student_id,
        case when B.submit_datetime is null then 0 else 1 end AS submit_yes
FROM
(
    select *
    from tbl_assignment A join tbl_schedule S
    on A.schedule_seq_assignment = S.schedule_seq
    where schedule_type = 1
)V LEFT JOIN
(
    SELECT GUAJE.schedule_seq_assignment, GUAJE_SUBMIT.submit_datetime, GUAJE_SUBMIT.fk_schedule_seq_assignment, score, fk_student_id
    FROM tbl_assignment GUAJE LEFT JOIN 
    (
      select *
      from tbl_assignment_submit
      where fk_student_id = '202400005'
    ) GUAJE_SUBMIT
    ON GUAJE.schedule_seq_assignment = GUAJE_SUBMIT.fk_schedule_seq_assignment
) B
on V.schedule_seq_assignment = B.fk_schedule_seq_assignment
where V.schedule_seq_assignment = 5;

---------------------------------------------------------------------------------------



B.score as score,
B.submit_datetime as submit_datetime,

B.fk_student_id as fk_student_id,
        
        
-- 과제 내용1
select A.schedule_seq_assignment, S.title, A.content, S.start_date, S.end_date, A.attatched_file, A.fk_course_seq, A.orgfilename
from tbl_assignment A join tbl_schedule S
on A.schedule_seq_assignment = S.schedule_seq
where schedule_type = 1 AND schedule_seq_assignment ='5'

-- 과제 내용2
select B.score, B.submit_datetime, B.fk_student_id, B.attatched_file, B.content, B.orgfilename, B.fk_schedule_seq_assignment
from tbl_assignment A join tbl_assignment_submit B
on A.schedule_seq_assignment = B.fk_schedule_seq_assignment
where fk_student_id = '202400005' AND fk_schedule_seq_assignment ='5'


-- 순번, 학번, 제목, 내용, 첨부파일, 제출시간
-- 과제 제출 내용 보기
select assignment_submit_seq, fk_student_id, title, content, attatched_file, submit_datetime
from tbl_assignment_submit
where fk_schedule_seq_assignment = '5' AND fk_student_id = '202400009'


select *
from tbl_assignment_submit;

select *
from tbl_assignment;



select *
from tbl_lecture
where lecture_seq = 15

alter table tbl_lecture 
add lecture_time Number;

commit;

update tbl_lecture set lecture_time = 5
where lecture_seq = 26;

commit;



--------------------------------------------------------------

-- 학번(출석테이블), 출석날짜(출석테이블), 수업명(수업테이블), 강의명(강의테이블)
-- tbl_attendance(fk_student_id), tbl_attendance(attended_date), tbl_curriculum(name), tbl_lecture(lecture_title)


select fk_student_id, attended_date
from tbl_attendance
where isAttended = 1 And fk_student_id = '202400005'


select D.fk_student_id, A.name, C.lecture_title, D.attended_date
from tbl_curriculum A JOIN tbl_course B
on A.curriculum_seq = B.fk_curriculum_seq
JOIN tbl_lecture C
on B.course_seq = C.fk_course_seq
JOIN tbl_attendance D
on C.lecture_seq = D.fk_lecture_seq
where D.isAttended = 1 AND D.fk_student_id = '202400005'


-- 14	4	1단원 영상	1주차 수업 자료	제 1장. 국어학개론의 이해	1) 국어학개론의 이해	24/07/07	24/07/14			3

insert into tbl_attendance(attendance_seq, fk_student_id, isattended, attended_date, fk_lecture_seq, play_time) 
values(attendance_seq.nextval, '202400005', 1, sysdate, '14', 3)


select name
from tbl_curriculum
order by curriculum_seq asc;


select *
from tbl_lecture
order by lecture_seq;


select *
from tbl_attendance
order by fk_lecture_seq;


-- 학번(출석테이블), 출석날짜(출석테이블), 수업명(수업테이블), 강의명(강의테이블)
-- tbl_attendance(fk_student_id), tbl_attendance(attended_date), tbl_curriculum(name), tbl_lecture(lecture_title)

-- 로그인한 학생이 듣는 수업명

select L.name
from tbl_registered_course R
JOIN tbl_course C
ON R.fk_course_seq = C.course_seq
JOIN tbl_curriculum L
ON C.fk_curriculum_seq = L.curriculum_seq
where R.fk_student_id = 202400005






-- 강의목록
select *
from tbl_lecture join tbl_course
on tbl_lecture.fk_course_seq = tbl_course.course_seq
where exist = 1 AND fk_course_seq = '4'
order by lecture_seq asc 

select *
from tbl_course


-----------------------------------------------------------
--=== 출석률 구하기 ===--

-- 1과목에 대한 전체 강의 수 : 14개(16주차에서 시험2주차 뺀)
-- 내가 출석한 강의 수 : 1개(가정)
-- 1/14 * 100 = 7.14%

-- 수강신청 tbl_registered_course
-- 개설수업 tbl_course
-- 강의 tbl_lecture
-- 출석 tbl_attendance



-- 내가 듣는 수업에 대한 한 과목의 강의 수(14개 / 현재 DB에 존재하는 국어학개론의 강의 수 7개)
select count(*)
from tbl_registered_course A JOIN tbl_course B
ON A.fk_course_seq = B.course_seq
JOIN tbl_lecture E
ON B.course_seq = E.fk_course_seq
where A.fk_student_id = '202400005' AND exist = 1 and course_seq = '4'


-- 내가 출석한 강의 수
select count(*)
from tbl_lecture C JOIN tbl_attendance D
ON C.lecture_seq = D.fk_lecture_seq
where D.fk_student_id = '202400005' AND attended_date is not null


SELECT
     ROUND(
        CASE 
            WHEN total_lectures = 0 THEN 0 
            ELSE (attended_lectures * 100.0 / total_lectures) 
        END, 0) AS attendance_rate
FROM (
    SELECT
        -- 총 강의 수
        (SELECT COUNT(*)
         FROM tbl_registered_course A 
         JOIN tbl_course B ON A.fk_course_seq = B.course_seq
         JOIN tbl_lecture E ON B.course_seq = E.fk_course_seq
         WHERE A.fk_student_id = '202400005' AND exist = 1 AND B.course_seq = '4') AS total_lectures,

        -- 출석한 강의 수
        (SELECT COUNT(*)
         FROM tbl_lecture C 
         JOIN tbl_attendance D ON C.lecture_seq = D.fk_lecture_seq
         WHERE D.fk_student_id = '202400005' AND attended_date IS NOT NULL) AS attended_lectures
    FROM dual 
) sub;

-- 출석률
SELECT
     ROUND(
        CASE 
            WHEN total_lectures = 0 THEN 0 
            ELSE (attended_lectures * 100.0 / total_lectures) 
        END, 0) AS attendance_rate
FROM (
    SELECT
        (SELECT COUNT(*)
         FROM tbl_registered_course A 
         JOIN tbl_course B ON A.fk_course_seq = B.course_seq
         JOIN tbl_lecture E ON B.course_seq = E.fk_course_seq
         WHERE A.fk_student_id = '202400005' AND exist = 1 AND B.course_seq = '4') AS total_lectures,

        (SELECT COUNT(*)
         FROM tbl_lecture C 
         JOIN tbl_attendance D ON C.lecture_seq = D.fk_lecture_seq
         WHERE D.fk_student_id = '202400005' AND attended_date IS NOT NULL) AS attended_lectures
    FROM dual 
) sub


-- 수업명, 출석률 합침
SELECT 
    L.name AS name,
    R.registered_course_seq AS registered_course_seq,
    ROUND(
        COALESCE(
            CASE 
                WHEN total_lectures = 0 THEN 0 
                ELSE (attended_lectures * 100.0 / total_lectures) 
            END, 0
        ), 0
    ) AS attendance_rate
FROM 
    tbl_registered_course R
JOIN 
    tbl_course C ON R.fk_course_seq = C.course_seq
JOIN 
    tbl_curriculum L ON C.fk_curriculum_seq = L.curriculum_seq
LEFT JOIN (
    SELECT 
        A.fk_course_seq,
        COUNT(E.lecture_seq) AS total_lectures,
        (SELECT COUNT(*)
         FROM tbl_lecture C 
         JOIN tbl_attendance D ON C.lecture_seq = D.fk_lecture_seq
         WHERE D.fk_student_id = '202400005' AND attended_date IS NOT NULL
         AND C.fk_course_seq = A.fk_course_seq) AS attended_lectures
    FROM 
        tbl_registered_course A 
    JOIN 
        tbl_course B ON A.fk_course_seq = B.course_seq
    JOIN 
        tbl_lecture E ON B.course_seq = E.fk_course_seq
    WHERE 
        A.fk_student_id = '202400005' AND exist = 1
    GROUP BY 
        A.fk_course_seq
) sub ON C.course_seq = sub.fk_course_seq
WHERE 
    R.fk_student_id = '202400005' AND name = '국어학개론'



-- 수업 성적 확인하기
-- 03월 1학기 07월 2학기
SELECT B.fk_student_id as 학번,
        A.score as 점수,
       A.mark as 학점,
       CASE 
           WHEN EXTRACT(MONTH FROM C.semester_date) BETWEEN 3 AND 6 THEN 
               TO_CHAR(EXTRACT(YEAR FROM C.semester_date)) || '년 1학기'
           WHEN EXTRACT(MONTH FROM C.semester_date) BETWEEN 7 AND 12 THEN 
               TO_CHAR(EXTRACT(YEAR FROM C.semester_date)) || '년 2학기'
           ELSE '기타' -- 만약 다른 달이 포함된다면
       END as 수강년도학기,
       D.name as 수업명
FROM tbl_grade A
JOIN tbl_registered_course B ON A.fk_registered_course_seq = B.registered_course_seq
JOIN tbl_course C ON B.fk_course_seq = C.course_seq
JOIN tbl_curriculum D ON C.fk_curriculum_seq = D.curriculum_seq
WHERE B.fk_student_id = '202400009'



select *
from tbl_assignment_submit
where fk_student_id = '202400009'


delete from tbl_assignment_submit
where assignment_submit_seq = '33'

commit;


to_char(attended_date, 'yyyy-mm-dd hh24:mi:ss')

select fk_student_id, fk_lecture_seq, to_char(attended_date, 'yyyy-mm-dd hh24:mi:ss')
from tbl_attendance


update tbl_attendance set ISATTENDED = '1', attended_date = sysdate
where fk_student_id = '202400009' and fk_lecture_seq = '14'



SELECT student_id, name, email, register_year, status
FROM tbl_student
order by student_id desc

select *
from tbl_student



select *
from tbl_menu

update tbl_menu set menu_name = '내 정보'
where menu_url = '/student/myInfo.lms'

commit;


	    WITH
	    P AS (
	        SELECT name, prof_id 
	        FROM tbl_professor
	    ),
	    C AS (
	        SELECT curriculum_seq, name, fk_department_seq, required
	        FROM tbl_curriculum
	    ),
	    V AS (
	        SELECT course_seq, fk_curriculum_seq, fk_professor_id, fk_student_id, 
	        semester_date
	        FROM tbl_course JOIN tbl_registered_course
	        ON course_seq = fk_course_seq
	    )
	    
	    SELECT p.prof_id,
	           p.name AS professorName,
	           c.curriculum_seq,
	           c.name AS className,
	           c.fk_department_seq AS department_seq,
	           c.required AS required,
	           v.course_seq AS course_seq,
	           v.semester_date as semester_date
	    FROM P 
	    JOIN V ON V.fk_professor_id = P.prof_id
	    JOIN C ON V.fk_curriculum_seq = C.curriculum_seq
	    WHERE V.fk_student_id = '202400009' and to_char(semester_date, 'yy-MM') = '24-07'













