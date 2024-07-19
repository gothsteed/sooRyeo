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

select *
from tbl_professor;

select *
from tbl_admin;

delete from tbl_student
where student_id = '202400010';
2024070414003518453562059800.png
commit;

INSERT INTO tbl_student (student_id, pwd, name, jubun, tel, grade, address, email, register_year, status, fk_department_seq)
VALUES (generate_student_id(), 'password123', 'John Doe', '1234567890123', '01012345678', 1, 'Some address', 'john.doe@example.com', SYSDATE, 1, 1);

ALTER TABLE tbl_student MODIFY register_year Number;

ALTER TABLE tbl_student
RENAME COLUMN register_date TO register_year;

select * from tab;

select *
from tbl_announcement;

select *
from tbl_recruitment_notice;

insert into tbl_announcement (announcement_seq, a_title, a_content)
values (ANNOUNCEMENT_SEQ.nextval, '학생들 이번학기는 개강을 안해요5', '행복하죠?');


commit;

ALTER TABLE tbl_announcement ADD writeday date DEFAULT sysdate NOT NULL;
ALTER TABLE tbl_announcement ADD orgfilename nvarchar2(50);

ALTER TABLE tbl_recruitment_notice ADD writeday date DEFAULT sysdate NOT NULL;
ALTER TABLE tbl_recruitment_notice ADD orgfilename nvarchar2(50);




SELECT previousseq, previoussubject, announcement_seq, a_title,
		a_content
		, viewcount, writeday
		, nextseq, nextsubject
		, attatched_file
		from
		(
		select lag (announcement_seq) over(order by announcement_seq desc) AS
		previousseq
		, lag (a_title,1) over(order by announcement_seq desc) AS
		previoussubject
		, announcement_seq
		, lead (announcement_seq) over(order by announcement_seq desc) AS
		nextseq
		, lead (a_title, 1) over(order by announcement_seq desc) AS Nextsubject
		, attatched_file, writeday, viewcount, a_title, a_content
		from tbl_announcement
		--where announcement_seq = 2
		) V
		WHERE V.announcement_seq = 2

SELECT previousseq, previoussubject, announcement_seq, a_title,	a_content
		, viewcount, writeday
		, nextseq, nextsubject
		, attatched_file
		from
		(
			select lag (announcement_seq) over(order by announcement_seq desc) AS previousseq
			, lag (a_title,1) over(order by announcement_seq desc) AS previoussubject
			, announcement_seq
			, lead (announcement_seq) over(order by announcement_seq desc) AS nextseq
			, lead (a_title, 1) over(order by announcement_seq desc) AS Nextsubject
			, attatched_file, writeday, viewcount, a_title, a_content
			from tbl_announcement 
            where lower(a_title) like '%'||lower('학생')||'%'
		) V
		WHERE V.announcement_seq = 3

select 고정글(5)

UNION ALL
여기부터만 페이징 처리
select 안고정글(10)

ALTER TABLE tbl_announcement ADD status number DEFAULT 0 NOT NULL;

select *
from tbl_announcement;

update tbl_announcement set status = 1
		where announcement_seq in(1,2,3);

commit;


delete from tbl_announcement
where 1=1;


select rownum, lecture_notice_seq, fk_course_seq, l_title, l_content, writeday
from tbl_lecture_notice;

CREATE TABLE tbl_lecture_notice 
( 
    lecture_notice_seq       NUMBER	NOT NULL primary key,
    fk_course_seq       NUMBER not null,
    l_title         VARCHAR2(200),
    l_content         VARCHAR2(600)
);

ALTER TABLE tbl_lecture_notice
	ADD
		CONSTRAINT fk_course_s
		FOREIGN KEY (
			fk_course_seq
		)
		REFERENCES tbl_course (
			course_seq
		);

create sequence lecture_notice_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

ALTER TABLE tbl_lecture_notice ADD writeday date DEFAULT sysdate NOT NULL;
ALTER TABLE tbl_lecture_notice ADD viewcount number DEFAULT 0 NOT NULL;
ALTER TABLE tbl_lecture_notice ADD status number DEFAULT 0 NOT NULL;



select *
from tbl_student;

insert into tbl_lecture_notice (lecture_notice_seq, fk_course_seq, l_title, l_content)
values (lecture_notice_seq.nextval, 4 ,'게임 필수입니다.', '게임 컴퓨터 꼭 수강하세요');

commit;

select *
from
(
SELECT rownum as rno, lecture_notice_seq AS seq, l_title AS title, writeday, viewcount
FROM tbl_lecture_notice
WHERE fk_course_seq = 4
)V
order by writeday desc

update tbl_student set pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
where name = '강민정';

commit;
		
		select announcement_seq, a_title, writeday, viewcount
		from
        (
        select rownum rn, announcement_seq, a_title, a_content, attatched_file, writeday, viewcount, status, orgfilename
        from
		(
            SELECT *
            FROM tbl_announcement
            order by writeday desc
        )V
        )T
        where rn BETWEEN 11 AND 12;
    
select *
from tbl_lecture_notice;

select count(*)
from tbl_student S
join tbl_registered_course R on S.student_id = R.fk_student_id
join tbl_course C on R.fk_course_seq = C.course_seq
where course_seq = 4;


select fk_professor_id, name, grade, department_name
from
(
select rownum rn, fk_professor_id, name, grade, department_name
from
(
select  C.fk_professor_id AS fk_professor_id,
S.name AS name, 
S.grade AS grade,
D.department_name AS department_name
from tbl_course C
JOIN tbl_registered_course R ON R.fk_course_seq = C.course_seq
JOIN tbl_student S ON S.student_id = R.fk_student_id
JOIN tbl_department D ON D.department_seq = S.fk_department_seq
where C.course_seq = 4
) V
) T
where rn BETWEEN 1 AND 2










CREATE TABLE tbl_login_history
( 
    login_history_seq    NUMBER	NOT NULL primary key,
    member_type          VARCHAR2(10) not null,
    login_date           date DEFAULT sysdate
);

create sequence login_history_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

ALTER TABLE tbl_login_history MODIFY login_date date DEFAULT sysdate;



select *
from tbl_login_history;


SELECT SUM(DECODE(TO_CHAR(login_date, 'MM'), '01', sal)) AS "01월"
     , SUM(DECODE(TO_CHAR(login_date, 'MM'), '02', sal)) AS "02월"
     , SUM(DECODE(TO_CHAR(login_date, 'MM'), '03', sal)) AS "03월"
     , SUM(DECODE(TO_CHAR(login_date, 'MM'), '04', sal)) AS "04월"
     , SUM(DECODE(TO_CHAR(login_date, 'MM'), '05', sal)) AS "05월"
     , SUM(DECODE(TO_CHAR(login_date, 'MM'), '06', sal)) AS "06월"
     , SUM(DECODE(TO_CHAR(login_date, 'MM'), '07', sal)) AS "07월"
     , SUM(DECODE(TO_CHAR(login_date, 'MM'), '08', sal)) AS "08월"
     , SUM(DECODE(TO_CHAR(login_date, 'MM'), '09', sal)) AS "09월"
     , SUM(DECODE(TO_CHAR(login_date, 'MM'), '10', sal)) AS "10월"
     , SUM(DECODE(TO_CHAR(login_date, 'MM'), '11', sal)) AS "11월"
     , SUM(DECODE(TO_CHAR(login_date, 'MM'), '12', sal)) AS "12월"
FROM tbl_login_history;

select *
from tbl_student;

select department_name
   , count(*) AS cnt 
   , round(count(*)/(select count(*) from tbl_student) * 100, 2) AS percentage 
from tbl_student S left join tbl_department D
on fk_department_seq = D.department_seq
group by D.department_name
order by cnt desc, department_name asc


CREATE TABLE tbl_student_status_change
( 
    student_status_change_seq    NUMBER	NOT NULL primary key,
    fk_student_id          number not null,
    change_status          number not null
);

create sequence student_status_change_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

ALTER TABLE tbl_student_status_change
	ADD
		CONSTRAINT con_fk_student_id
		FOREIGN KEY (
			fk_student_id
		)
		REFERENCES tbl_student (
			student_id
		);

select *
from tbl_registered_course;

select credit, r.register_date, R.pass_status
from tbl_student S
join tbl_registered_course R on S.student_id = R.fk_student_id
join tbl_course C on R.fk_course_seq = C.course_seq
join tbl_curriculum L on C.fk_curriculum_seq = L.curriculum_seq
where student_id = '202400005' and R.pass_status = 1;

select *
from tbl_student_status_change
where fk_student_id = #{student_id}

insert into tbl_student_status_change(student_status_change_seq, fk_student_id, change_status) values(student_status_change_seq.nextval, 202400021, 2)

delete from tbl_student_status_change
where change_status = '2';
commit;

ALTER TABLE tbl_registered_course ADD pass_status number DEFAULT 0 NOT NULL;
ALTER TABLE tbl_registered_course MODIFY pass_status number DEFAULT 1;


select S.student_id, C.change_status, S.name, s.grade, d.department_name, S.status
from tbl_student_status_change C
join tbl_student S on s.student_id = c.fk_student_id
join tbl_department D on s.fk_department_seq = d.department_seq;


update tbl_student set status = 1
where fk_student_id = '202500021';

select distinct(cu.name), p.name
from tbl_student S
join tbl_registered_course R on S.student_id = R.fk_student_id
join tbl_course C on R.fk_course_seq = C.course_seq
join tbl_curriculum CU on C.fk_curriculum_seq = CU.curriculum_seq
join tbl_time T on C.course_seq = T.fk_course_seq
join tbl_professor P on P.prof_id = C.fk_professor_id
where day_of_week =
CASE
WHEN to_char(sysdate, 'd') = '1' THEN 1 
WHEN to_char(sysdate, 'd') = '2' THEN 2 
WHEN to_char(sysdate, 'd') = '3' THEN 3 
WHEN to_char(sysdate, 'd') = '4' THEN 4 
WHEN to_char(sysdate, 'd') = '5' THEN 5 
END;



