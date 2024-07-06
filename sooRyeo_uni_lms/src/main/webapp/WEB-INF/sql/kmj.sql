show user;

SELECT * FROM tabs;

INSERT INTO tbl_student (student_id, pwd, name, jubun, tel, grade, address, email, register_date, status, fk_department_seq)
VALUES (generate_student_id(), 'password123', 'John Doe', '1234567890123', '01012345678', 1, 'Some address', 'john.doe@example.com', SYSDATE, 1, 1);


select *
from tbl_admin;

-- 컬럼 이름 바꾸기
alter table tbl_admin rename COLUMN admin_seq to admin_id;
commit;

-- 컬럼 데이터 변경
update tbl_admin set email = '7DiCwyc+1dXTTwg5kjvDmHehvJlz/ESJNhef/5DX+YA='
where admin_id = '202400001';


insert into tbl_admin (admin_id, name, pwd, jubun, tel, email)
values (generate_admin_id(), '관리자', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '9101011234567', 'k6AvvKD9cZaeKhlunBk9ew==', '2kh94@naver.com');


select *
from tbl_student;

select *
from tbl_professor;

select *
from tbl_department;

insert into tbl_professor (prof_id, pwd, name, jubun, tel, department_seq, email, office_address, employment_stat, employment_date)
values (generate_professor_id(), '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '홍길동', '9010101234567', 'k6AvvKD9cZaeKhlunBk9ew==', 2, '2kh94@naver.com', '서울특별시 서대문구 연세로 50', 1, sysdate);



select *
from tbl_curriculum
where curriculum_seq = '1'

select *
from tbl_course;

SELECT *
FROM all_sequences;

select *
from tbl_time


insert into tbl_course(course_seq, FK_PROFESSOR_ID, FK_CURRICULUM_SEQ, FK_TIME_SEQ, CAPACITY, SEMESTER_DATE) values(COURSE_SEQ.nextval, '202400002', '1', '1', '20', '2024-03-02'); 
insert into tbl_course(course_seq, FK_PROFESSOR_ID, FK_CURRICULUM_SEQ, FK_TIME_SEQ, CAPACITY, SEMESTER_DATE) values(COURSE_SEQ.nextval, '202400002', '50', '1', '20', '2024-03-02'); 
insert into tbl_course(course_seq, FK_PROFESSOR_ID, FK_CURRICULUM_SEQ, FK_TIME_SEQ, CAPACITY, SEMESTER_DATE) values(COURSE_SEQ.nextval, '202400002', '7', '1', '20', '2024-03-02'); 


insert into tbl_time(time_seq, day_of_week,period) values(time_seq.nextval, 2, 2);
insert into tbl_time(time_seq, day_of_week,period) values(time_seq.nextval, 3, 2);

insert into tbl_registered_course(REGISTERED_COURSE_SEQ, FK_STUDENT_ID, FK_COURSE_SEQ, REGISTER_DATE) values(REGISTERED_COURSE_SEQ.nextval, '202400005', '4', '2024-07-02');
insert into tbl_registered_course(REGISTERED_COURSE_SEQ, FK_STUDENT_ID, FK_COURSE_SEQ, REGISTER_DATE) values(REGISTERED_COURSE_SEQ.nextval, '202400005', '5', '2024-07-02');

select *
from tbl_registered_course;




insert into tbl_professor (prof_id, pwd, name, jubun, tel, department_seq, email, office_address, employment_stat, employment_date)
values (generate_professor_id(), '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '서영학', '7104171234567', 'k6AvvKD9cZaeKhlunBk9ew==', 2, '2kh94@naver.com', '서울특별시 서대문구 연세로 50', 1, sysdate);


select *
from tbl_department;

commit;





WITH
P AS (
select name, prof_id     교수명, 교수아이디
from tbl_professor       교수테이블
),
C AS (
select curriculum_seq, fk_department_seq, required, name    
from tbl_curriculum                                         수업테이블
),
V AS (
select course_seq, fk_curriculum_seq, fk_professor_id, fk_student_id
from tbl_course join tbl_registered_course
on course_seq = fk_course_seq
)
select p.name as professorName,
       c.name as className,
       c.fk_department_seq as department_seq,
       c.required as required
       
from P JOIN V
on V.fk_professor_id = P.prof_id
JOIN C
on V.fk_curriculum_seq = C.curriculum_seq
where V.fk_student_id = '202400005';









B.name as professorName, A.title, C.name as className, A.end_datetime, A.assignment_submit_seq

UPDATE tbl_assignment SET end_datetime="to_date('2024-07-01 00:00:00','yyyy-mm-dd hh24:mi:ss')" WHERE assignment_seq='123';





WITH
A AS(
select fk_course_seq, end_datetime, D.title, assignment_submit_seq
from tbl_assignment D left join tbl_assignment_submit
on assignment_seq = fk_assignment_seq
where sysdate < end_datetime
),
B AS(
select prof_id, name, course_seq 
from tbl_professor join tbl_course
on fk_professor_id = prof_id
join tbl_assignment
on fk_course_seq = course_seq
),
C AS (
select fk_student_id, course_seq, fk_professor_id, fk_curriculum_seq, name
from tbl_registered_course join tbl_course
on fk_course_seq = course_seq
join tbl_curriculum
on fk_curriculum_seq = curriculum_seq
)

select *
from A join C
on A.fk_course_seq = C.course_seq
left join B
on C.course_seq = A.fk_course_seq
where fk_student_id = '202400005';


select *
from tbl_assignment
wherer userid = '202400005'


 
        
            select end_datetime, assignment_submit_seq, title, fk_professor_id as professor, X.name as professorName, fk_curriculum_seq, B.name as className
            from
            (select  course_seq, end_datetime, assignment_submit_seq, title, fk_professor_id, C.name, fk_curriculum_seq
                from
                (select course_seq, end_datetime, assignment_submit_seq, title, fk_professor_id, fk_curriculum_seq
                    from
                    (select course_seq, end_datetime, assignment_submit_seq, title, fk_professor_id, fk_curriculum_seq
                        from
                        (select fk_course_seq, end_datetime, assignment_submit_seq, E.title
                            from tbl_assignment_submit D right join tbl_assignment E
                            on E.assignment_seq = D.fk_assignment_seq
                        ) V JOIN tbl_course F 
                        on V.fk_course_seq = F.course_seq
                    ) V2 join tbl_registered_course G
                    on V2.course_seq = G.fk_course_seq
                    where sysdate < end_datetime and G.fk_student_id = '202400005'
                ) Z join tbl_professor C
                on Z.fk_professor_id = C.prof_id
            ) X join tbl_curriculum B
            on X.fk_curriculum_seq = B.curriculum_seq
            


select *
from tbl_registered_course;


select *
from tbl_course;



		),
		B AS(
			select prof_id, name
			from tbl_professor
		),
		C AS(
			select fk_student_id, course_seq, fk_professor_id, fk_curriculum_seq, name
			from tbl_registered_course join tbl_course
			on fk_course_seq = course_seq
			join tbl_curriculum
			on fk_curriculum_seq = curriculum_seq
		)
		
		select B.name as professorName, A.title, C.name as className, A.end_datetime, assignment_submit_seq
		from A join C
		on A.fk_course_seq = C.course_seq
		join B
		on C.course_seq = A.fk_course_seq
		where fk_student_id = '202400005'




select *
from tbl_professor


select *
from tbl_course


select *
from tbl_registered_course


select *
from tbl_curriculum;

select *
from tbl_time;

commit;

select *
from tbl_assignment;


update tbl_assignment set fk_course_seq = '12' where assignment_seq = '2'
----------------------------------------

insert into tbl_course(course_seq, FK_PROFESSOR_ID, FK_CURRICULUM_SEQ, FK_TIME_SEQ, CAPACITY, SEMESTER_DATE)
values(COURSE_SEQ.nextval, '202400004', '5', '2', '25', '2024-03-02'); 


insert into tbl_course(course_seq, FK_PROFESSOR_ID, FK_CURRICULUM_SEQ, FK_TIME_SEQ, CAPACITY, SEMESTER_DATE)
values(COURSE_SEQ.nextval, '202400002', '7', '1', '20', '2024-03-02'); 

insert into tbl_assignment(ASSIGNMENT_SEQ, FK_COURSE_SEQ, START_DATETIME, END_DATETIME, TITLE, CONTENT)
values(ASSIGNMENT_SEQ.nextval, '4', sysdate, to_date('2024-08-02 00:00:00','yyyy-mm-dd hh24:mi:ss'), '시 한편 지어보기', '자신이 가장 좋아하는 인물에 대한 시 한편을 지어보세요.');




insert into tbl_assignment(ASSIGNMENT_SEQ, FK_COURSE_SEQ, START_DATETIME, END_DATETIME, TITLE, CONTENT)
values(ASSIGNMENT_SEQ.nextval, '5', sysdate, to_date('2024-07-25 00:00:00','yyyy-mm-dd hh24:mi:ss'), '회계공부하기', '회계용어를 외워오세요.');

commit;


select to_date(START_DATE, 'yyyy-mm-dd hh24:mi') 
from tbl_schedule;


insert into tbl_schedule(Schedule_Seq, Title, Schedule_Type, Start_Date, End_Date)
values(SCHEDULE_SEQ.nextval, '교수님과 식사', '3', to_date('2024-07-28 12:00','yyyy-mm-dd hh24:mi'), to_date('2024-07-28 14:00','yyyy-mm-dd hh24:mi'));


