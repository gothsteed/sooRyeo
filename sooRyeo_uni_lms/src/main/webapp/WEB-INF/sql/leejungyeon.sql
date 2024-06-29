CREATE TABLE tbl_department (
	department_seq  Number        NOT NULL, -- 학과코드
	department_name NVARCHAR2(200) NOT NULL  -- 학과명
);

-- 학과
ALTER TABLE tbl_department
	ADD
		CONSTRAINT PK_tbl_department -- 학과 기본키
		PRIMARY KEY (
			department_seq -- 학과코드
		);
        

create sequence department_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from 
tbl_department;


CREATE TABLE tbl_student (
	student_id        Number        NOT NULL
	, -- 학번
	pwd               NVARCHAR2(100) NOT NULL, -- 비밀번호
	name              NVARCHAR2(100) NOT NULL, -- 성명
	jubun             NVARCHAR2(13)  NOT NULL, -- 주민번호
	tel               NVARCHAR2(11)  NOT NULL, -- tel
	grade             SMALLINT      NOT NULL, -- 학년
	address           NVARCHAR2(200) NOT NULL, -- 주소
	email             NVARCHAR2(200) NOT NULL, -- 이메일
	register_date     DATE          NOT NULL, -- 입학년도
	status            SMALLINT      NOT NULL, -- 학적상태
	fk_department_seq Number        NOT NULL  -- 학과코드


);
ALTER TABLE tbl_student
DROP COLUMN register_year;

ALTER TABLE tbl_student
ADD register_year SMALLINT DEFAULT EXTRACT(YEAR FROM SYSDATE) NOT NULL;


desc tbl_student;
select *
from tbl_board
where seq = 217;

select * from tbl_student;


ALTER TABLE tbl_student MODIFY pwd NVARCHAR2(200);
ALTER TABLE tbl_student MODIFY email NVARCHAR2(200);
ALTER TABLE tbl_student MODIFY tel NVARCHAR2(200);


ALTER TABLE tbl_student
	ADD
		CONSTRAINT PK_tbl_student -- 학생 기본키
		PRIMARY KEY (
			student_id -- 학번
		);

ALTER TABLE tbl_student
	ADD
		CONSTRAINT FK_tbl_depar_tbl_student -- 학과 -> 학생
		FOREIGN KEY (
			fk_department_seq -- 학과코드
		)
		REFERENCES tbl_department ( -- 학과
			department_seq -- 학과코드
		);
        
ALTER TABLE tbl_student
MODIFY status DEFAULT 1;


CREATE TABLE tbl_professor (
	prof_id         Number        NOT NULL 
	, -- 교수번호
	pwd             NVARCHAR2(100) NOT NULL, -- 비밀번호
	name            NVARCHAR2(100) NOT NULL, -- 성명
	jubun           NVARCHAR2(13)  NOT NULL, -- jubun
	tel             NVARCHAR2(11)  NOT NULL, -- 전화번호
	department_seq  Number        NOT NULL, -- 학과코드
	email           NVARCHAR2(200) NOT NULL, -- 이메일
	office_address  NVARCHAR2(200) NOT NULL, -- 연구실주소
	employment_stat SMALLINT      NOT NULL,
	employment_date DATE          NOT NULL  -- employment_date
);

ALTER TABLE tbl_professor MODIFY pwd NVARCHAR2(200);
ALTER TABLE tbl_professor MODIFY email NVARCHAR2(200);
ALTER TABLE tbl_professor MODIFY tel NVARCHAR2(200);

ALTER TABLE tbl_professor
	ADD
		CONSTRAINT PK_tbl_professor -- 교수 기본키
		PRIMARY KEY (
			prof_id -- 교수번호
		);

 ALTER TABLE tbl_professor
	MODIFY employment_stat DEFAULT 1;
    
    ALTER TABLE tbl_professor
	ADD
		CONSTRAINT FK_tbl_depart_tbl_professor -- 학과 -> 교수
		FOREIGN KEY (
			department_seq -- 학과코드
		)
		REFERENCES tbl_department ( -- 학과
			department_seq -- 학과코드
		);
    
    CREATE TABLE tbl_admin (
	admin_seq Number        NOT NULL, -- 관리자 아이디
	name      NVARCHAR2(100) NOT NULL, -- 성명
	pwd       NVARCHAR2(100) NOT NULL, -- 비밀번호
	jubun     NVARCHAR2(13)  NOT NULL, -- 주민번호
	tel       NVARCHAR2(11)  NOT NULL, -- 전화번호
	email     NVARCHAR2(200) NOT NULL  -- 이메일
);

ALTER TABLE tbl_admin MODIFY pwd NVARCHAR2(200);
ALTER TABLE tbl_admin MODIFY email NVARCHAR2(200);
ALTER TABLE tbl_admin MODIFY tel NVARCHAR2(200);


ALTER TABLE tbl_admin
	ADD
		CONSTRAINT PK_tbl_admin -- 관리자 기본키
		PRIMARY KEY (
			admin_seq -- 관리자 아이디
		);



-- 시퀀스 생성
CREATE SEQUENCE student_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE SEQUENCE professor_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE SEQUENCE admin_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- 학번 생성 함수
CREATE OR REPLACE FUNCTION generate_student_id RETURN Number IS
  v_year VARCHAR2(4);
  v_seq  VARCHAR2(5);
BEGIN
  SELECT TO_CHAR(SYSDATE, 'YYYY') INTO v_year FROM DUAL;
  SELECT LPAD(student_seq.NEXTVAL, 5, '0') INTO v_seq FROM DUAL;
  RETURN v_year || v_seq;
END;
/

-- 교수번호 생성 함수
CREATE OR REPLACE FUNCTION generate_professor_id RETURN Number IS
  v_year VARCHAR2(4);
  v_seq  VARCHAR2(5);
BEGIN
  SELECT TO_CHAR(SYSDATE, 'YYYY') INTO v_year FROM DUAL;
  SELECT LPAD(professor_seq.NEXTVAL, 5, '0') INTO v_seq FROM DUAL;
  RETURN v_year || v_seq;
END;
/

-- 직원번호 생성 함수
CREATE OR REPLACE FUNCTION generate_admin_id RETURN Number IS
  v_year VARCHAR2(4);
  v_seq  VARCHAR2(5);
BEGIN
  SELECT TO_CHAR(SYSDATE, 'YYYY') INTO v_year FROM DUAL;
  SELECT LPAD(admin_seq.NEXTVAL, 5, '0') INTO v_seq FROM DUAL;
  RETURN v_year || v_seq;
END;
/

insert into tbl_department(department_seq, department_name)
values(department_seq.nextval, 'test');

select *
from tbl_department;

-- 학생 테이블에 학번 삽입
INSERT INTO tbl_student (student_id, pwd, name, jubun, tel, grade, address, email, register_date, status, fk_department_seq)
VALUES (generate_student_id(), 'password123', 'John Doe', '1234567890123', '01012345678', 1, 'Some address', 'john.doe@example.com', SYSDATE, 1, 1);

select * from tbl_student;

rollback;

CREATE TABLE tbl_announcement (
	announcement_seq Number        NOT NULL, -- 공지사항 시퀀스
	a_title          NVARCHAR2(200) NOT NULL, -- 공지제목
	a_content        NVARCHAR2(600) NULL,     -- 공지내용
	attatched_file   NVARCHAR2(200) NULL      -- 첨부파일
);

drop table tbl_announcement;

ALTER TABLE tbl_announcement
	ADD
		CONSTRAINT PK_tbl_announcement -- 학사공지사항 기본키
		PRIMARY KEY (
			announcement_seq -- 공지사항 시퀀스
		);
        
CREATE SEQUENCE announcement_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
CREATE TABLE tbl_recruitment_notice (
	recruitment_notice_seq Number  NOT NULL, -- 채용공지사항 시퀀스
	r_title                NVARCHAR2(200)      NOT NULL, -- 공지 제목
	r_content              NVARCHAR2(600)      NOT NULL, -- 공지 내용
	attatched_file         NVARCHAR2(200)      NULL      -- 새 컬럼
); 

CREATE SEQUENCE recruitment_notice_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
ALTER TABLE tbl_recruitment_notice
	ADD
		CONSTRAINT PK_tbl_recruitment_notice -- 채용공지사항 기본키
		PRIMARY KEY (
			recruitment_notice_seq -- 채용공지사항 시퀀스
		);
  

CREATE TABLE tbl_curriculum_type (
	curriculum_type_seq  Number        NOT NULL, -- 수업타입시퀀스
	curriculum_type_name NVARCHAR2 (100) NOT NULL  -- 수업타입
);
CREATE SEQUENCE curriculum_type_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  ALTER TABLE tbl_curriculum_type
	ADD
		CONSTRAINT PK_tbl_curriculum_type -- 수업타입 기본키
		PRIMARY KEY (
			curriculum_type_seq -- 수업타입시퀀스
		);
        
CREATE TABLE tbl_curriculum (
	curriculum_seq         Number        NOT NULL, -- 수업시퀀스
	fk_curriculum_type_seq Number        NOT NULL, -- 수업타입시퀀스
	fk_department_seq      Number        NOT NULL, -- 학과코드
	grade                  SMALLINT      NULL,     -- 학년
	name                   NVARCHAR2(100) NOT NULL, -- 수업명
	credit                 SMALLINT      NOT NULL  -- 이수단위(n학점)
);

CREATE SEQUENCE curriculum_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
  ALTER TABLE tbl_curriculum
	ADD
		CONSTRAINT PK_tbl_curriculum -- 수업 기본키
		PRIMARY KEY (
			curriculum_seq -- 수업시퀀스
		);
        
        
ALTER TABLE tbl_curriculum
	ADD
		CONSTRAINT FK_tbl_curri_type_tbl_curri -- 수업타입 -> 수업
		FOREIGN KEY (
			fk_curriculum_type_seq -- 수업타입시퀀스
		)
		REFERENCES tbl_curriculum_type ( -- 수업타입
			curriculum_type_seq -- 수업타입시퀀스
		);
ALTER TABLE tbl_curriculum
	ADD
		CONSTRAINT FK_tbl_depart_TO_tbl_curri-- 학과 -> 수업
		FOREIGN KEY (
			fk_department_seq -- 학과코드
		)
		REFERENCES tbl_department ( -- 학과
			department_seq -- 학과코드
		);
        
CREATE TABLE tbl_time (
	time_seq    Number   NOT NULL, -- 시간시퀀스
	day_of_week SMALLINT NOT NULL, -- 요일
	period      SMALLINT NOT NULL  -- 시간
);

CREATE SEQUENCE time_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  ALTER TABLE tbl_time
	ADD
		CONSTRAINT PK_tbl_time -- 시간표 기본키
		PRIMARY KEY (
			time_seq -- 시간시퀀스
		);


CREATE TABLE tbl_course (
	course_seq        Number NOT NULL, -- 개설수업시퀀스
	fk_professor_id  Number NOT NULL, -- 교수번호
	fk_curriculum_seq Number NOT NULL, -- 수업시퀀스
	fk_time_seq       Number NOT NULL, -- 시간시퀀스
	capacity          Number NOT NULL, -- 정원
	semester_date     DATE   NOT NULL  -- 개강년도학기
);

drop table tbl_course;

CREATE SEQUENCE course_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;


ALTER TABLE tbl_course
	ADD
		CONSTRAINT PK_tbl_course -- 개설수업 기본키
		PRIMARY KEY (
			course_seq -- 개설수업시퀀스
		);


ALTER TABLE tbl_course
	ADD
		CONSTRAINT FK_tbl_prof_tbl_course -- 교수 -> 개설수업
		FOREIGN KEY (
			fk_professor_id -- 교수번호
		)
		REFERENCES tbl_professor ( -- 교수
			prof_id -- 교수번호
);

ALTER TABLE tbl_course
	ADD
		CONSTRAINT FK_tbl_curri_TO_tbl_course -- 수업 -> 개설수업
		FOREIGN KEY (
			fk_curriculum_seq -- 수업시퀀스
		)
		REFERENCES tbl_curriculum ( -- 수업
			curriculum_seq -- 수업시퀀스
		);

ALTER TABLE tbl_course
	ADD
		CONSTRAINT FK_tbl_time_TO_tbl_course -- 시간표 -> 개설수업
		FOREIGN KEY (
			fk_time_seq -- 시간시퀀스
		)
		REFERENCES tbl_time ( -- 시간표
			time_seq -- 시간시퀀스
		);


CREATE TABLE tbl_lecture (
	lecture_seq       Number         NOT NULL, -- lecture_seq
	fk_course_seq     Number         NOT NULL, -- 개설수업시퀀스
	video_file_name   NVARCHAR2(200) NULL,     -- 강의영상파일이름
	lecture_file_name NVARCHAR2(200) NULL,     -- 강의자료파일이름
	lecture_title     NVARCHAR2(200) NOT NULL, -- 강의제목
	lecture_content   NVARCHAR2(800)  NOT NULL  -- 새 컬럼
);
CREATE SEQUENCE lecture_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;


ALTER TABLE tbl_lecture
	ADD
		CONSTRAINT PK_tbl_lecture -- 강의 기본키
		PRIMARY KEY (
			lecture_seq -- lecture_seq
		);
        
        
ALTER TABLE tbl_lecture
	ADD
		CONSTRAINT FK_tbl_cours_tbl_lecture -- 개설수업 -> 강의
		FOREIGN KEY (
			fk_course_seq -- 개설수업시퀀스
		)
		REFERENCES tbl_course ( -- 개설수업
			course_seq -- 개설수업시퀀스
		);

CREATE TABLE tbl_attendance (
	attendance_seq Number NOT NULL, -- 출석시퀀스
	fk_course_seq  Number             NOT NULL, -- 개설수업시퀀스
	fk_student_id  Number             NOT NULL, -- 학번
	isAttended     CHAR(1)             NOT NULL, -- 출석유무
	attended_date  DATE               NOT NULL  -- 출석날짜
);

CREATE SEQUENCE attendance_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

ALTER TABLE tbl_attendance
	ADD
		CONSTRAINT PK_tbl_attendance -- 출석 기본키
		PRIMARY KEY (
			attendance_seq -- 출석시퀀스
		);

ALTER TABLE tbl_attendance
	ADD
		CONSTRAINT FK_tbl_cours_tbl_atten -- 개설수업 -> 출석
		FOREIGN KEY (
			fk_course_seq -- 개설수업시퀀스
		)
		REFERENCES tbl_course ( -- 개설수업
			course_seq -- 개설수업시퀀스
		);
        
ALTER TABLE tbl_attendance
	ADD
		CONSTRAINT FK_tbl_stud_tbl_attend -- 학생 -> 출석
		FOREIGN KEY (
			fk_student_id -- 학번
		)
		REFERENCES tbl_student ( -- 학생
			student_id -- 학번
		);

CREATE TABLE tbl_registered_course (
	registered_course_seq Number NOT NULL, -- 수강신청시퀀스
	fk_student_id         Number NOT NULL, -- 학생아이디
	fk_course_seq         Number NOT NULL, -- 개설수업시퀀스
	register_date         DATE   NOT NULL  -- 신청날짜
);

CREATE SEQUENCE registered_course_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
  ALTER TABLE tbl_registered_course
	ADD
		CONSTRAINT PK_tbl_registered_course -- 수강신청 기본키
		PRIMARY KEY (
			registered_course_seq -- 수강신청시퀀스
		);


ALTER TABLE tbl_registered_course
	ADD
		CONSTRAINT FK_tbl_stud_tbl_regist_course -- 학생 -> 수강신청2
		FOREIGN KEY (
			fk_student_id -- 학생아이디
		)
		REFERENCES tbl_student ( -- 학생
			student_id -- 학번
		);
  
CREATE TABLE tbl_grade (
	grade_seq                Number    NOT NULL, -- 성적시퀀스
	fk_registered_course_seq Number    NOT NULL, -- 수강신청시퀀스
	score                    NUMber    NOT NULL, -- 점수
	mark                     CHARACTER NOT NULL  -- 학점(A, B ...)
);
  
  
  


ALTER TABLE tbl_registered_course
	ADD
		CONSTRAINT FK_tbl_course_tbl_regist_cour -- 개설수업 -> 수강신청
		FOREIGN KEY (
			fk_course_seq -- 개설수업시퀀스
		)
		REFERENCES tbl_course ( -- 개설수업
			course_seq -- 개설수업시퀀스
		);
CREATE SEQUENCE grade_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
  
  ALTER TABLE tbl_grade
	ADD
		CONSTRAINT PK_tbl_grade -- 성적 기본키
		PRIMARY KEY (
			grade_seq -- 성적시퀀스
		);




ALTER TABLE tbl_grade
	ADD
		CONSTRAINT FK_regist_course_tbl_grade -- 수강신청 -> 성적
		FOREIGN KEY (
			fk_registered_course_seq -- 수강신청시퀀스
		)
		REFERENCES tbl_registered_course ( -- 수강신청
			registered_course_seq -- 수강신청시퀀스
		);



CREATE TABLE tbl_assignment (
	assignment_seq Number         NOT NULL, -- 과제시퀀스
	fk_course_seq  Number         NOT NULL, -- 개설수업시퀀스
	start_datetime DATE       NOT NULL, -- 등록시간
	end_datetime   DATE       NOT NULL, -- 마감시간
	title          NVARCHAR2(200)  NOT NULL, -- 과제이름
	content        NVARCHAR2(800)  NOT NULL, -- 과제 내용
	attatched_file NVARCHAR2(200) NULL      -- 첨부파일
);

CREATE SEQUENCE assignment_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
ALTER TABLE tbl_assignment
	ADD
		CONSTRAINT PK_tbl_assignment -- 과제 기본키
		PRIMARY KEY (
			assignment_seq -- 과제시퀀스
		);
        
        
ALTER TABLE tbl_assignment
	ADD
		CONSTRAINT FK_tbl_cour_tbl_assigt -- 개설수업 -> 과제
		FOREIGN KEY (
			fk_course_seq -- 개설수업시퀀스
		)
		REFERENCES tbl_course ( -- 개설수업
			course_seq -- 개설수업시퀀스
		);
        
  DROP TABLE tbl_assignment_submit;      

CREATE TABLE tbl_assignment_submit (
	assignment_submit_seq Number         NOT NULL, -- 제출시퀀스
	fk_assignment_seq     Number         NOT NULL, -- 과제시퀀스
	title                 NVARCHAR2(200)  NOT NULL, -- 제목
	content               NVARCHAR2(800)  NOT NULL, -- 내용
	score                 Number         NULL,     -- 점수
	submit_datetime       DATE           NULL,     -- 제출시간
	attatched_file        NVARCHAR2(200) NULL,     -- 첨부파일
	fk_student_id         Number         NOT NULL  -- 학번
);

CREATE SEQUENCE assignment_submit_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
  ALTER TABLE tbl_assignment_submit
	ADD
		CONSTRAINT PK_tbl_assignment_submit -- 과제제출 기본키
		PRIMARY KEY (
			assignment_submit_seq -- 제출시퀀스
		);
        
        
ALTER TABLE tbl_assignment_submit
	ADD
		CONSTRAINT FK_tbl_assig_ass_submit -- 과제 -> 과제제출
		FOREIGN KEY (
			fk_assignment_seq -- 과제시퀀스
		)
		REFERENCES tbl_assignment ( -- 과제
			assignment_seq -- 과제시퀀스
		)
        ON DELETE cascade;
        
ALTER TABLE tbl_assignment_submit
	ADD
		CONSTRAINT FK_tbl_stut_assig_submit -- 학생 -> 과제제출
		FOREIGN KEY (
			fk_student_id -- 학번
		)
		REFERENCES tbl_student ( -- 학생
			student_id -- 학번
		);
    

desc tbl_student;
desc tbl_department;

insert into tbl_department( DEPARTMENT_SEQ, DEPARTMENT_NAME)
values (DEPARTMENT_SEQ.nextval, '컴퓨터공학과');
commit;

select *
from tbl_department;


select *
from tbl_student;

rollback;

SELECT * 
FROM tbl_professor 
WHERE student_id = 202400003 AND pwd = '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4';


INSERT INTO tbl_student (
    STUDENT_ID, 
    PWD, 
    NAME, 
    JUBUN, 
    TEL, 
    GRADE, 
    ADDRESS, 
    EMAIL, 
    STATUS, 
    FK_DEPARTMENT_SEQ
) VALUES (
    generate_student_id(), -- STUDENT_ID
    '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', -- PWD
    '강민정', -- NAME
    '9901011234567', -- JUBUN
    'k6AvvKD9cZaeKhlunBk9ew==', -- TEL
    1, -- GRADE
    '서울시 강남구 테헤란로 123', -- ADDRESS
    'Ebb5gKvx8ME4g2RXYMg/ouPkJeeKt3ECwIY/orYSMlE=', -- EMAIL
    1, -- STATUS
    2 -- FK_DEPARTMENT_SEQ
);

commit;
select * 
from tbl_student;

desc tbl_student;


INSERT INTO tbl_curriculum_type (curriculum_type_seq, curriculum_type_name)
VALUES (curriculum_type_seq.nextval, 'major');
INSERT INTO tbl_curriculum_type (curriculum_type_seq, curriculum_type_name)
VALUES (curriculum_type_seq.nextval, 'liberal_arts');

commit;

desc tbl_curriculum;

select * from 
tbl_department;

select * 
from tbl_curriculum_type;

ALTER TABLE tbl_curriculum
MODIFY fk_department_seq NUMBER NULL;

ALTER TABLE tbl_curriculum
MODIFY FK_CURRICULUM_TYPE_SEQ NUMBER NULL;


INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 3, 1, '국어학개론', 3, 1);
INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 4, 1, '거시경제학', 3, 1);

INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 5, 1, '화공입문 1', 3, 1);

INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 6, 1, '화성학 1', 3, 1);

INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 7, 1, '회계학원론', 3, 1);

INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 2, 1, '운영체제', 3, 1);

select *
from tbl_curriculum;
commit;


ALTER TABLE tbl_curriculum
ADD required Number(1);




