show user;

SELECT * FROM tabs;

INSERT INTO tbl_student (student_id, pwd, name, jubun, tel, grade, address, email, register_date, status, fk_department_seq)
VALUES (generate_student_id(), 'password123', 'John Doe', '1234567890123', '01012345678', 1, 'Some address', 'john.doe@example.com', SYSDATE, 1, 1);

select *
from tbl_student;

select *
from tbl_admin;

select *
from tbl_professor;

update tbl_professor set prof_id = 202400007
where prof_id = 202400009

commit;

-- 컬럼 이름 바꾸기
alter table tbl_admin rename COLUMN admin_seq to admin_id;
commit;

-- 컬럼 데이터 변경

update tbl_admin set email = '7DiCwyc+1dXTTwg5kjvDmHehvJlz/ESJNhef/5DX+YA='
where admin_id = '202400001';

alter table tbl_professor add img_name NVARCHAR2(200); 
commit;




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


SELECT P.PROF_ID, P.PWD, P.NAME, P.TEL, D.DEPARTMENT_NAME, P.EMAIL, P.OFFICE_ADDRESS
FROM 
(SELECT prof_id, pwd, name, tel, department_seq, email, office_address
FROM tbl_professor) P
JOIN 
(SELECT department_seq, department_name
FROM tbl_department) D
ON P.department_seq = D.department_seq
WHERE P.prof_id = '202400002';


select *
from tbl_professor
where pwd = '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4';

select img_name
from tbl_professor

select count(*)
from tbl_professor
where prof_id = 202400002 and name = '홍길동'   

-- 교수 진행 강의 리스트
SELECT P.prof_id AS prof_id,
       P.name AS prof_name,
       C.COURSE_SEQ AS course_seq, 
       C.FK_CURRICULUM_SEQ AS fk_curriculum_seq, 
       C.CAPACITY AS capacity, 
       C.SEMESTER_DATE AS semester_date,
       CU.fk_department_seq AS fk_department_seq, 
       CU.grade AS grade, 
       CU.name AS name, 
       CU.credit AS credit, 
       CU.required AS required, 
       CU.exist AS exist,
       T.DAY_OF_WEEK AS day_of_week,
       T.start_period AS start_period,
       T.end_period AS end_period
FROM tbl_professor P
JOIN tbl_course C ON P.prof_id = C.fk_professor_id
JOIN tbl_curriculum CU ON CU.curriculum_seq = C.fk_curriculum_seq
JOIN tbl_time T ON C.course_seq = T.fk_course_seq
WHERE P.prof_id = 202400002 and C.exist = 1;

select *
from tbl_time

select *
from tbl_course

-- 개설수업
select *
from tbl_course C
JOIN tbl_time T on C.course_seq = T.fk_course_seq
where course_seq = 12;

delete tbl_course
where course_seq = 12;

-- course_seq 57, fk_curriculum_seq 5 월 1-3
-- course_seq 4, fk_curriculum_seq 1 월 1-1
-- 
select *
from tbl_lecture
where fk_professor_id = 202400002

-- 수업
select *
from tbl_curriculum
--
/*
period
1 - 1교시
2 - 2교시
3
4
5
6
7
8
9

3학점인데 1~3교시다

time_seq 1 day_of_week 2 period 1
time_seq 2 day_of_week 2 period 2
time_seq 3 day_of_week 2 period 3
*/

-- 학과
select *
from tbl_department

select *
from tbl_student


select *
from tbl_time

INSERT INTO tbl_time (time_seq, day_of_week, fk_course_seq, start_period, end_period)
VALUES (time_seq.nextval, 1, 4, 1, 3);
commit;


select ROW_NUMBER() OVER(ORDER BY S.name asc) row_num, C.course_seq, C.fk_professor_id, C.fk_curriculum_seq, S.name, S.grade, S.fk_department_seq, D.department_name
from tbl_course C
JOIN tbl_registered_course R ON R.fk_course_seq = C.course_seq
JOIN tbl_student S ON S.student_id = R.fk_student_id
JOIN tbl_department D ON D.department_seq = S.fk_department_seq
where C.course_seq = 4


SELECT
			C.COURSE_SEQ AS course_seq,
			C.FK_PROFESSOR_ID AS fk_professor_id, 
       		C.FK_CURRICULUM_SEQ AS fk_curriculum_seq, 
       		C.CAPACITY AS capacity, 
       		C.SEMESTER_DATE AS semester_date,
       		CU.curriculum_seq AS curriculum_seq,
       		CU.fk_department_seq AS fk_department_seq, 
       		CU.grade AS grade, 
       		CU.name AS name, 
       		CU.credit AS credit, 
       		CU.required AS required,
            T.time_seq,
            T.day_of_week,
            T.start_period,
            T.end_period
		FROM 
		tbl_course C
		join tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
        join tbl_time T ON C.course_seq = T.fk_course_seq
		where C.FK_PROFESSOR_ID= 202400002 and C.exist = 1
        
        
        
        
        select *
        FROM 
		tbl_course C
		join tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
        where C.FK_PROFESSOR_ID= 202400002 and C.exist = 1
        
        
        select *
        from
        tbl_course C
        join tbl_time T ON C.course_seq = T.fk_course_seq
        where C.FK_PROFESSOR_ID= 202400002 and C.exist = 1
        order by T.day_of_week asc;
        
        
        select *
        from
        tbl_course C
        join tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
        join tbl_time T ON C.course_seq = T.fk_course_seq
        where C.FK_PROFESSOR_ID= 202400002 and C.exist = 1
        
        select *
        from
        tbl_time T
        join tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
        
        select *
        from
        tbl_assignment
        
        select *
        from
        tbl_schedule
        order by schedule_seq desc;
        
        
        select *
        from
        tbl_assignment
        where schedule_seq_assignment = 81
        
        --- 과제 테이블 셀렉트용 --
        select
        ROW_NUMBER() OVER(ORDER BY S.start_date desc) row_num,
        A.fk_course_seq,
        A.content,
        NVL(A.attatched_file, '없음') as attatched_file,
        -- A.orgfilename as orgfilename, 
        A.schedule_seq_assignment,
        S.schedule_seq,
        S.title,
        S.start_date,
        S.end_date
        from
        tbl_assignment A
        join tbl_schedule S ON A.schedule_seq_assignment = S.schedule_seq
        where A.fk_course_seq = 4
        
        
        
insert into tbl_assignment(schedule_seq_assignment, fk_course_seq, content, attatched_file) values(102, '박보영', default);

insert into tbl_schedule(schedule_seq, title, start_date, end_date) values(schedule_seq.nextval, '변우석', default, dd); 


DELETE FROM tbl_schedule
     WHERE schedule_seq = 47; 

commit;

insert into tbl_assignment(schedule_seq_assignment, fk_course_seq, content, attatched_file) values(27, 4, '제발들어가라', default);


commit;

-- 기존 외래 키 제약 조건 삭제
ALTER TABLE tbl_assignment
DROP CONSTRAINT FK_TBL_SCHE_TBL_ASSIGN;

rollback;

-- 새로운 외래 키 제약 조건 추가
ALTER TABLE tbl_assignment
ADD CONSTRAINT FK_TBL_SCHE_TBL_ASSIGN
FOREIGN KEY (schedule_seq_assignment)
REFERENCES tbl_schedule (schedule_seq)
ON DELETE CASCADE;


ALTER TABLE tbl_assignment
ADD CONSTRAINT fk_schedule
FOREIGN KEY (schedule_seq_assignment)
REFERENCES tbl_schedule (schedule_seq)
ON DELETE CASCADE;


select
A.fk_course_seq as fk_course_seq,
A.schedule_seq_assignment as schedule_seq_assignment,
A.content as content,
NVL(A.attatched_file, '없음') as attatched_file,
S.schedule_seq as schedule_seq,
S.title as title,
S.start_date as start_date,
S.end_date as end_date 
from
tbl_assignment A
join tbl_schedule S ON A.schedule_seq_assignment = S.schedule_seq
where A.schedule_seq_assignment = 5 and A.fk_course_seq = 4


SELECT *
FROM
tbl_student S
join tbl_registered_course R ON S.student_id = R.fk_student_id
left join tbl_assignment_submit A ON S.student_id = A.fk_student_id



-- 기존 외래 키 제약 조건 삭제
ALTER TABLE tbl_assignment_submit
DROP CONSTRAINT FK_ASSIGN_TO_ASSIGN_SUBMIT;


commit;
-- 새로운 외래 키 제약 조건 추가
ALTER TABLE tbl_assignment_submit
ADD CONSTRAINT FK_ASSIGN_TO_ASSIGN_SUBMIT
FOREIGN KEY (fk_schedule_seq_assignment)
REFERENCES tbl_assignment (schedule_seq_assignment)
ON DELETE CASCADE;


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
where schedule_seq_assignment = 81

select *
from
tbl_assignment_submit

select *
from
tbl_assignment

SELECT ROW_NUMBER() OVER(order by V.end_date asc) row_num,
SA.fk_schedule_seq_assignment AS fk_schedule_seq_assignment,
SA.assignment_submit_seq AS assignment_submit_seq,
S.name AS name,
NVL(SA.attatched_file, '없음')AS attached_file,
to_char(V.end_date, 'yyyy-mm-dd')AS end_date,
NVL(to_char(SA.submit_datetime, 'yyyy-mm-dd'), '미제출')AS submit_datetime,
NVL(to_char(SA.score), '미채점') AS score
FROM
tbl_student S
join tbl_assignment_submit SA ON S.student_id = SA.fk_student_id
left join
(select *
from tbl_assignment A join tbl_schedule S
on A.schedule_seq_assignment = S.schedule_seq
where schedule_type = 1)V
ON SA.fk_schedule_seq_assignment = V.schedule_seq_assignment
WHERE SA.fk_schedule_seq_assignment = 45


select *
from
tbl_assignment

ALTER TABLE tbl_assignment ADD orgfilename NVARCHAR2(200);


select *
from
tbl_assignment_submit


select S.name as name, S.grade as grade, C.semester_date as semester_date, CU.name as gradename, CU.credit as credit, sum(CU.credit) as totalcredit, CU.required as required
from
tbl_student S 
join tbl_registered_course R on S.student_id = R.fk_student_id
join tbl_course C on R.fk_course_seq = C.course_seq
join tbl_curriculum CU on C.fk_curriculum_seq = CU.curriculum_seq
where student_id = 202400009


----- 학생 총학점 가져오기
SELECT 
    S.name AS name, 
    S.grade AS grade, 
    C.semester_date AS semester_date, 
    CU.name AS gradename, 
    CU.credit AS credit, 
    CU.required AS required
FROM
    tbl_student S 
    JOIN tbl_registered_course R ON S.student_id = R.fk_student_id
    JOIN tbl_course C ON R.fk_course_seq = C.course_seq
    JOIN tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
WHERE 
    S.student_id = 202400009

-- 학생이 듣고 있는 수업리스트
select S.student_id as student_id, S.name as name, CU.name as gradename, CU.fk_department_seq as fk_department_seq, CU.credit as credit, CU.required as required
FROM
tbl_student S 
JOIN tbl_registered_course R ON S.student_id = R.fk_student_id
JOIN tbl_course C ON R.fk_course_seq = C.course_seq
JOIN tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
WHERE S.student_id = 202400009


-- 전공필수 가져오는 식
select  NVL(SUM(CU.credit), 0) AS total_Required_credit
FROM
tbl_student S 
JOIN tbl_registered_course R ON S.student_id = R.fk_student_id
JOIN tbl_course C ON R.fk_course_seq = C.course_seq
JOIN tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
WHERE S.student_id = 202400009 and CU.fk_department_seq is not null and CU.required = 1 and R.pass_status = 1 

-- 전공선택 가져오는 식
select NVL(SUM(CU.credit), 0) AS total_Unrequired_credit
FROM
tbl_student S 
JOIN tbl_registered_course R ON S.student_id = R.fk_student_id
JOIN tbl_course C ON R.fk_course_seq = C.course_seq
JOIN tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
WHERE S.student_id = 202400009 and CU.fk_department_seq is not null and CU.required = 0 and R.pass_status = 1

-- 교양 가져오는 식
select NVL(SUM(CU.credit), 0) AS total_Liberal_credit
FROM
tbl_student S 
JOIN tbl_registered_course R ON S.student_id = R.fk_student_id
JOIN tbl_course C ON R.fk_course_seq = C.course_seq
JOIN tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
WHERE S.student_id = 202400009 and CU.fk_department_seq is null and R.pass_status = 1


select *
from tbl_registered_course


update tbl_registered_course set pass_status = 1
commit;

ALTER TABLE tbl_assignment_submit ADD orgfilename NVARCHAR2(200);

commit;



-- 학기별 수업 가져오기

SELECT P.prof_id AS prof_id,
       	P.name AS prof_name,
       	C.COURSE_SEQ AS course_seq, 
       	C.FK_CURRICULUM_SEQ AS fk_curriculum_seq, 
       	C.CAPACITY AS capacity, 
       	to_char(C.SEMESTER_DATE, 'YY-MM') AS semester_date,
       	CU.fk_department_seq AS fk_department_seq,  
       	CU.name AS name, 
       	CU.credit AS credit, 
       	CU.required AS required, 
       	CU.exist AS exist,
       	T.DAY_OF_WEEK AS day_of_week,
       	T.start_period AS start_period,
       	T.end_period AS end_period
		FROM tbl_professor P
		JOIN tbl_course C ON P.prof_id = C.fk_professor_id
		JOIN tbl_curriculum CU ON CU.curriculum_seq = C.fk_curriculum_seq
		JOIN tbl_time T ON C.course_seq = T.fk_course_seq
		WHERE P.prof_id = 202400002 and C.exist = 1 and to_char(C.SEMESTER_DATE, 'yy-MM') = '24-07'

    
        select *
        from tbl_course
        
        commit;
        
        
        
WITH
		P AS (
		select name, prof_id 
		from tbl_professor
		),
		C AS (
		select curriculum_seq, name, fk_department_seq, required
		from tbl_curriculum
		),
		V AS (
			select course_seq, fk_curriculum_seq, fk_professor_id, fk_student_id, semester_date
			from tbl_course join tbl_registered_course
			on course_seq = fk_course_seq
		)
		select p.name as professorName,
			   c.name as className,
			   c.fk_department_seq as department_seq,
       		   c.required as required,
       		   v.course_seq as course_seq,
       		   v.semester_date as semester_date
		from P JOIN V
		on V.fk_professor_id = P.prof_id
		JOIN C
		on V.fk_curriculum_seq = C.curriculum_seq
		where V.fk_student_id = 202400009 and '24-03' < to_char(V.semester_date, 'yy-MM') and to_char(V.semester_date, 'yy-MM') <= '24-07'
        
        
        SELECT
        A.schedule_seq_assignment as schedule_seq_assignment,
		SA.assignment_submit_seq AS assignment_submit_seq,
		S.name AS name,
		NVL(SA.score, 0) AS score
		FROM
		tbl_student S
		join tbl_assignment_submit SA ON S.student_id = SA.fk_student_id
		join tbl_assignment A ON SA.fk_schedule_seq_assignment = A.schedule_seq_assignment
        join tbl_course C ON A.fk_course_seq = C.course_seq
        where course_seq = 4 and student_id = 202400005;
        
        
        
        select *
        from tbl_assignment_submit
        
        -- 202400005 학생 과제 총점
        SELECT sum(SA.score) as totalscore
		FROM
		tbl_student S
		join tbl_assignment_submit SA ON S.student_id = SA.fk_student_id
		join tbl_assignment A ON SA.fk_schedule_seq_assignment = A.schedule_seq_assignment
        join tbl_course C ON A.fk_course_seq = C.course_seq
        where course_seq = 4 and S.student_id = 202400005

       -- 총 과제 갯수
        select count(schedule_seq_assignment) as totalCount
        from tbl_assignment
        where fk_course_seq = 4
        
        -- 과제 백분율 점수
        (190/500)*100 
        
        -- 과목 총 시험 갯수
        select count(*) as totalCount
        from tbl_course C
        join tbl_exam E ON C.course_seq = E.fk_course_seq
        where course_seq = 4
        
        
        select *
        from tbl_student
        
        select *
        from tbl_grade
        
        select *
        from tbl_registered_course
        
        select *
        from tbl_exam
        -- G.score
        
        
        
        
        select * 
        from tbl_student S
        join tbl_registered_course R ON S.student_id = R.fk_student_id
        join tbl_grade G ON R.registered_course_seq = G.fk_registered_course_seq
        Where S.student_id = 202400005 and R.fk_course_seq = 4
        
        select * 
        from tbl_student S
        join tbl_registered_course R ON S.student_id = R.fk_student_id
        Where S.student_id = 202400005 and R.fk_course_seq = 4
        
        select total_score
        from tbl_student S
        join tbl_registered_course R ON S.student_id = R.fk_student_id
        
        Where student_id = 202400005 and course_seq = 4
        
        
        select *
        from tbl_course C
        order by course_seq asc
        join tbl_curriculum CU on C.fk_curriculum_seq = CU.curriculum_seq
        
        update tbl_course set semester_date = '2024/07/07'
        commit;
        
        
        select *
        from tbl_student S
        join tbl_registered_course R ON S.student_id = R.fk_student_id
        join tbl_grade G ON R.registered_course_seq = G.fk_registered_course_seq
        where student_id = 202400005 and R.registered_course_seq = 23
        
        
        
SELECT sum(SA.score) as totalscore
		FROM
		tbl_student S
		join tbl_assignment_submit SA ON S.student_id = SA.fk_student_id
		join tbl_assignment A ON SA.fk_schedule_seq_assignment = A.schedule_seq_assignment
        join tbl_course C ON A.fk_course_seq = C.course_seq
        where course_seq = 4 and S.student_id = 202400009
        
 select *
 from tbl_exam
 
 select *
 from tbl_schedule
 
 
 select *
 from tbl_student S
 join tbl_registered_course R ON S.student_id = R.fk_student_id
 join tbl_exam E ON R.fk_course_seq = E.fk_course_seq
 join tbl_schedule SC ON E.fk_schedule_seq = SC.schedule_seq
 where R.fk_course_seq = 4
 
 
 select count(*)
 from tbl_exam
 where fk_course_seq = 4
 
 select *
 from tbl_attendance
 where fk_student_id = 202400005 and attended_date IS NOT NULL;
 
 SELECT *
 FROM TBL_ATTENDANCE
 
 -- 출석갯수
 select count(*)
 from tbl_attendance A
 join tbl_registered_course R  ON A.fk_student_id = R.fk_student_id
 join tbl_lecture L ON R.fk_course_seq = L.fk_course_seq and A.fk_lecture_seq = L.lecture_seq
 where A.fk_student_id = 202400005 and R.fk_course_seq = 4 and A.attended_date IS NOT NULL;
 
 -- 수강 갯수
 select count(*)
 from tbl_lecture
 where fk_course_seq = 4       
 
 
 select*
 from tbl_department
        
        
        -- 전공필수(자학과) 가져오기
        select  NVL(SUM(CU.credit), 0) AS total_myRequired_credit
		FROM
		tbl_student S 
		JOIN tbl_registered_course R ON S.student_id = R.fk_student_id
		JOIN tbl_course C ON R.fk_course_seq = C.course_seq
		JOIN tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
		WHERE S.student_id = 202400005 and CU.fk_department_seq is not null
        and CU.fk_department_seq = 2 and CU.required = 1 and R.pass_status = 1 
        
        -- 전공필수(타학과) 가져오기
        select  NVL(SUM(CU.credit), 0) AS total_yourRequired_credit
		FROM
		tbl_student S 
		JOIN tbl_registered_course R ON S.student_id = R.fk_student_id
		JOIN tbl_course C ON R.fk_course_seq = C.course_seq
		JOIN tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
		WHERE S.student_id = 202400005 and CU.fk_department_seq is not null 
        and CU.fk_department_seq != 2 and CU.required = 1 and R.pass_status = 1 
        
        
        
SELECT  TO_CHAR(C.semester_date, 'YYYY-MM-DD') AS semesterdate, CU.name AS coursename, CU.curriculum_seq AS coursenumber, G.mark AS mark
		FROM tbl_student S
		JOIN tbl_registered_course R ON S.student_id = R.fk_student_id
		LEFT JOIN tbl_grade G ON R.registered_course_seq = G.fk_registered_course_seq
		JOIN tbl_course C ON R.fk_course_seq = C.course_seq
		JOIN tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
		WHERE S.student_id = 202400005
		ORDER BY C.semester_date asc, CU.name asc
        
        
SELECT COUNT(DISTINCT TO_CHAR(C.semester_date, 'YYYY-MM')) AS unique_semesterdate_count
FROM tbl_student S
JOIN tbl_registered_course R ON S.student_id = R.fk_student_id
LEFT JOIN tbl_grade G ON R.registered_course_seq = G.fk_registered_course_seq
JOIN tbl_course C ON R.fk_course_seq = C.course_seq
JOIN tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
WHERE S.student_id = 202400005


SELECT semesterdate
FROM (
    SELECT TO_CHAR(C.semester_date, 'YYYY-MM') AS semesterdate
    FROM tbl_student S
    JOIN tbl_registered_course R ON S.student_id = R.fk_student_id
    LEFT JOIN tbl_grade G ON R.registered_course_seq = G.fk_registered_course_seq
    JOIN tbl_course C ON R.fk_course_seq = C.course_seq
    JOIN tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
    WHERE S.student_id = 202400005
)
GROUP BY semesterdate
ORDER BY semesterdate asc;


SELECT  TO_CHAR(C.semester_date, 'YYYY-MM-DD') AS semesterdate, CU.name AS coursename, CU.curriculum_seq AS coursenumber, G.mark AS mark
		FROM tbl_student S
		JOIN tbl_registered_course R ON S.student_id = R.fk_student_id
		LEFT JOIN tbl_grade G ON R.registered_course_seq = G.fk_registered_course_seq
		JOIN tbl_course C ON R.fk_course_seq = C.course_seq
		JOIN tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
		WHERE S.student_id = 202400005 and TO_CHAR(C.semester_date, 'YYYY-MM') = '2024-07' 
		ORDER BY C.semester_date asc, CU.name asc







SELECT TO_CHAR(C.semester_date, 'YYYY-MM') AS semesterdate
    FROM tbl_student S
    JOIN tbl_registered_course R ON S.student_id = R.fk_student_id
    LEFT JOIN tbl_grade G ON R.registered_course_seq = G.fk_registered_course_seq
    JOIN tbl_course C ON R.fk_course_seq = C.course_seq
    JOIN tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
    WHERE S.student_id = 202400005


SELECT *
FROM tbl_student S
JOIN tbl_registered_course R ON S.student_id = R.fk_student_id
LEFT JOIN tbl_grade G ON R.registered_course_seq = G.fk_registered_course_seq
JOIN tbl_course C ON R.fk_course_seq = C.course_seq
JOIN tbl_curriculum CU ON C.fk_curriculum_seq = CU.curriculum_seq
WHERE S.student_id = 202400005



SELECT *
FROM tbl_registered_course



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
	    WHERE V.fk_student_id = 202400005 and to_char(V.semester_date, 'yy-MM') = '24-07'
        
        
        
        
        select lecture_seq, fk_course_seq
		     , video_file_name, lecture_file_name, lecture_title
		     , lecture_content
		     , start_date
		     , end_date
		from tbl_lecture join tbl_course
		on tbl_lecture.fk_course_seq = tbl_course.course_seq
		where fk_course_seq = 4 and lecture_seq = 
		order by lecture_seq asc
        
        
        select lecture_seq, fk_course_seq
			 , video_file_name, lecture_file_name, lecture_title
			 , lecture_content
             , upload_lecture_file_name
             , upload_video_file_name
			 , start_date
     		 , end_date
		from tbl_lecture join tbl_course
		on tbl_lecture.fk_course_seq = tbl_course.course_seq
		where exist = 1 AND lecture_seq = 56
		order by lecture_seq asc
        
        
        select *
        from tbl_lecture
