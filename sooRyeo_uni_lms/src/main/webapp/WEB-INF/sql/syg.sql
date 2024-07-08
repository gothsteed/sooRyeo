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
ALTER TABLE tbl_announcement ADD viewcount number DEFAULT 0 NOT NULL;

ALTER TABLE tbl_recruitment_notice ADD writeday date DEFAULT sysdate NOT NULL;
ALTER TABLE tbl_recruitment_notice ADD viewcount number DEFAULT 0 NOT NULL;




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

