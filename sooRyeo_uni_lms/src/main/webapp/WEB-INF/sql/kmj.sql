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


select *
from tbl_lecture



alter table tbl_schedule add confirm smallint default '1' not null;


		where lecture_seq = '28';

select*
from 

select *
from tbl_schedule;


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



create table tbl_consult
(fk_schedule_seq    number
,fk_student_id   number         not null
,fk_prof_id      number         not null
,content         Nvarchar2(30)  not null

,CONSTRAINT PK_tbl_consult PRIMARY KEY (fk_schedule_seq)
,CONSTRAINT FK_tbl_consult_tbl_schedule FOREIGN KEY (fk_schedule_seq) REFERENCES tbl_schedule (schedule_seq)
,CONSTRAINT FK_tbl_student_tbl_consult FOREIGN KEY (fk_student_id) REFERENCES tbl_student (student_id)
,CONSTRAINT FK_tbl_professor_tbl_consult FOREIGN KEY (fk_prof_id) REFERENCES tbl_professor (prof_id)
);



drop table tbl_consult;


select *
from tbl_schedule
where schedule_type = '4'


select *
from tbl_consult;

delete
from tbl_schedule
where schedule_seq = '58'

select *
from tbl_schedule

commit;


B.name as professorName, A.title, C.name as className, A.end_datetime, A.assignment_submit_seq

UPDATE tbl_assignment SET end_datetime="to_date('2024-07-01 00:00:00','yyyy-mm-dd hh24:mi:ss')" WHERE assignment_seq='123';


select *
from tbl_curriculum
where name = '영화로 보는 동유럽';

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
values(SCHEDULE_SEQ.nextval, '교수님과 식사', '3', to_date('20240728120000','yyyymmddhh24miss'), to_date('20240728140000','yyyymmddhh24miss'));

delete from tbl_schedule
where schedule_seq = '41';

delete from tbl_consult
where schedule_seq = '41';

commit;

select *
from tbl_schedule
where schedule_seq = '33'; 

select *
from tbl_consult;

delete from tbl_consult
where schedule_seq = '36';


commit;

insert into tbl_schedule(Schedule_Seq, Title, Schedule_Type, Start_Date, End_Date)
values(SCHEDULE_SEQ.nextval, '국어학개론 2학기 중간고사', '2', to_date('20240716140000','yyyymmddhh24miss'), to_date('20240716150000','yyyymmddhh24miss'));




insert into tbl_schedule(Schedule_Seq, Title, Schedule_Type, Start_Date, End_Date)
values(SCHEDULE_SEQ.nextval, '국어학개론 현대시읽고 레포트 작성하기', '1', to_date('20240722000000','yyyymmddhh24miss'), to_date('20240726235959','yyyymmddhh24miss'));


insert into tbl_assignment(schedule_seq_assignment, fk_course_seq, content)
values('5', '4', '현대시 하나를 읽고 소감문 레포트를 작성해서 내주세요.');

commit;



select *
from tbl_schedule join tbl_assignment
on schedule_seq = schedule_seq_assginment;

select *
from tbl_assignment;


select fk_student_id, A.course_seq, SCHEDULE_SEQ, TITLE, SCHEDULE_TYPE, START_DATE, END_DATE
from tbl_schedule join tbl_assignment
on schedule_seq = schedule_seq_assignment
join tbl_course A
on course_seq = fk_course_seq
join tbl_registered_course B
on B.fk_course_seq = A.course_seq
where fk_student_id = '202400005';



select B.schedule_seq, A.content, title, schedule_type, start_date, end_date
from tbl_todo A join tbl_schedule B
on A.schedule_seq = B.SCHEDULE_SEQ
where fk_student_id = '202400005';


insert into tbl_todo(SCHEDULE_SEQ, CONTENT, FK_STUDENT_ID)
values('2','국어학개론 교수님과 점심식사', '202400005');

select *
from tbl_todo;
values(SCHEDULE_SEQ.nextval, '교수님과 식사', '3', to_date('2024-07-28 12:00','yyyy-mm-dd hh24:mi'), to_date('2024-07-28 14:00','yyyy-mm-dd hh24:mi'));


update tbl_member set idle = 1
where userid = 'yy6037';


select *
from tbl_todo

select *
from tbl_schedule;

select prof_id, name
from tbl_course join tbl_professor
on fk_professor_id = prof_id
where course_seq = '4'

commit;

select *
from tbl_schedule
where Schedule_Seq = '33';

ALTER TABLE tbl_consult
CHANGE COLUMN COTENT content 

drop table tbl_consult;

ALTER TABLE tbl_consult CHANGE COLUMN COTENT CONTENT Nvarchar2(30);

SELECT *
FROM TBL_CONSULT
where fk_student_id = '202400009'

select *
from tbl_schedule
where schedule_seq = '42';




select assignment_submit_seq
from tbl_assignment_submit
where fk_schedule_seq_assignment = '5';


select *
from tbl_lecture
where fk_course_seq = '4'


select *
from tbl_consult
where fk_schedule_seq = '58'

select *
from tbl_schedule
where schedule_type = '4' and confirm = '1'


update tbl_schedule set confirm = '0'
where schedule_seq = '59';

commit;

select B.schedule_seq, A.content, title, schedule_type, start_date, end_date
from tbl_consult A join tbl_schedule B
on A.fk_schedule_seq = B.schedule_seq
where fk_student_id = '202400005' and confirm = '1'
      
      
select lecture_title, lecture_content     
from tbl_lecture
where lecture_seq = '14'
            
            
ALTER TABLE tbl_attendance ADD play_time Number(10); 

select play
from tbl_attendance
where fk_student_id  = '202400005' and FK_LECTURE_SEQ = '14'


ALTER TABLE tbl_attendance ADD play_time Number(10); 

Alter table tbl_attendance
    modify ( play_time Number);


select *
from all_sequences
where sequence_name = 'ATTENDANCE_SEQ'

select *
from tbl_attendance;

select *
from tbl_lecture
            
            
 
             
select L.lecture_time - (A.play_time + 1) 
from tbl_attendance A join tbl_lecture L
on A.fk_lecture_seq  = L.lecture_seq
where A.fk_student_id  = '202400005' and A.FK_LECTURE_SEQ = '15'
 
            
select A.play_time - L.lecture_time 
from tbl_attendance A join tbl_lecture L
on A.fk_lecture_seq  = L.lecture_seq
where A.fk_student_id  = '202400005' and A.FK_LECTURE_SEQ = '15'


select L.lecture_time - (A.play_time + #{play_time}) 
		from tbl_attendance A join tbl_lecture L
		on A.fk_lecture_seq  = L.lecture_seq
		where A.fk_student_id  = #{userid} and A.FK_LECTURE_SEQ = #{lecture_seq}


select *
from tbl_lecture
where lecture_seq = '15';

select *
from tbl_attendance
where fk_lecture_seq = '15'


update tbl_lecture set lecture_time = '3'
where lecture_seq = '15'

update tbl_attendance set ISATTENDED = '0'
where fk_lecture_seq = '15'


select *
from tbl_attendance;

commit;

alter table tbl_exam modify ORIGINAL_FILE_NAME not null;

alter table tbl_exam modify FILE_NAME not null;

            select *
            from tbl_exam
            
            select *
            from tbl_schedule
            where schedule_type = '2'
            
            
            select *
            from tbl_exam;

delete
from tbl_exam
where fk_schedule_seq = '94';

rollback;

select *
from tbl_exam

select *
from tbl_exam


			select fk_student_id, A.course_seq , schedule_seq, title, schedule_type, start_date, end_date
			from tbl_schedule join tbl_exam
			on schedule_seq = fk_schedule_seq
			join tbl_course A
			on course_seq = fk_course_seq
			join tbl_registered_course B
			on B.fk_course_seq = A.course_seq
			where fk_student_id = '202400005'



commit;



select C.name
from tbl_course A join tbl_curriculum C
on A.fk_curriculum_seq = C.curriculum_seq
where A.course_seq = '4';


select *
from tbl_curriculum;


select *
from tbl_course;


select S.schedule_seq, S.TITLE, s.START_DATE, s.END_DATE, E.FILE_NAME, E.ORIGINAL_FILE_NAME, E.ANSWER_MONGO_ID
from tbl_schedule S join tbl_exam E
on S.schedule_seq = E.Fk_schedule_seq
where schedule_seq  = '103';


select *
from tbl_assignment

select to_date(start_date , 'yyyy-mm-dd hh24:mi:ss')
from tbl_schedule
where schedule_seq = '5'
