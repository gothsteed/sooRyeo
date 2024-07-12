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

-- 개설수업
select *
from tbl_course C
JOIN tbl_time T on C.course_seq = T.fk_course_seq
where fk_professor_id = 202400002

-- 
select *
from tbl_lecture


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
        
        
        select attatched_file
        from
        tbl_assignment
        where schedule_seq_assignment = 47
        
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
        where A.schedule_seq_assignment = 46