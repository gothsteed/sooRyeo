CREATE TABLE tbl_department (
   department_seq  Number        NOT NULL, --  а  ڵ 
   department_name NVARCHAR2(200) NOT NULL  --  а   
);

--  а 
ALTER TABLE tbl_department
   ADD
      CONSTRAINT PK_tbl_department --  а   ⺻�?
      PRIMARY KEY (
         department_seq --  а  ڵ 
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
   , --  й 
   pwd               NVARCHAR2(100) NOT NULL, --   й ȣ
   name              NVARCHAR2(100) NOT NULL, --     
   jubun             NVARCHAR2(13)  NOT NULL, --  ֹι ȣ
   tel               NVARCHAR2(11)  NOT NULL, -- tel
   grade             SMALLINT      NOT NULL, --  г 
   address           NVARCHAR2(200) NOT NULL, --  ּ 
   email             NVARCHAR2(200) NOT NULL, --  ̸   
   register_date     DATE          NOT NULL, --    г�?
   status            SMALLINT      NOT NULL, --         
   fk_department_seq Number        NOT NULL  --  а  ڵ 


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
      CONSTRAINT PK_tbl_student --  л   ⺻�?
      PRIMARY KEY (
         student_id --  й 
      );

ALTER TABLE tbl_student
   ADD
      CONSTRAINT FK_tbl_depar_tbl_student --  а  ->  л 
      FOREIGN KEY (
         fk_department_seq --  а  ڵ 
      )
      REFERENCES tbl_department ( --  а 
         department_seq --  а  ڵ 
      );
        
ALTER TABLE tbl_student
MODIFY status DEFAULT 1;


CREATE TABLE tbl_professor (
   prof_id         Number        NOT NULL 
   , --       ȣ
   pwd             NVARCHAR2(100) NOT NULL, --   й ȣ
   name            NVARCHAR2(100) NOT NULL, --     
   jubun           NVARCHAR2(13)  NOT NULL, -- jubun
   tel             NVARCHAR2(11)  NOT NULL, --   ȭ  ȣ
   department_seq  Number        NOT NULL, --  а  ڵ 
   email           NVARCHAR2(200) NOT NULL, --  ̸   
   office_address  NVARCHAR2(200) NOT NULL, --        ּ 
   employment_stat SMALLINT      NOT NULL,
   employment_date DATE          NOT NULL  -- employment_date
);

ALTER TABLE tbl_professor MODIFY pwd NVARCHAR2(200);
ALTER TABLE tbl_professor MODIFY email NVARCHAR2(200);
ALTER TABLE tbl_professor MODIFY tel NVARCHAR2(200);

ALTER TABLE tbl_professor
   ADD
      CONSTRAINT PK_tbl_professor --       ⺻�?
      PRIMARY KEY (
         prof_id --       ȣ
      );

 ALTER TABLE tbl_professor
   MODIFY employment_stat DEFAULT 1;
    
    ALTER TABLE tbl_professor
   ADD
      CONSTRAINT FK_tbl_depart_tbl_professor --  а  ->     
      FOREIGN KEY (
         department_seq --  а  ڵ 
      )
      REFERENCES tbl_department ( --  а 
         department_seq --  а  ڵ 
      );
    
    CREATE TABLE tbl_admin (
   admin_seq Number        NOT NULL, --           ̵ 
   name      NVARCHAR2(100) NOT NULL, --     
   pwd       NVARCHAR2(100) NOT NULL, --   й ȣ
   jubun     NVARCHAR2(13)  NOT NULL, --  ֹι ȣ
   tel       NVARCHAR2(11)  NOT NULL, --   ȭ  ȣ
   email     NVARCHAR2(200) NOT NULL  --  ̸   
);

ALTER TABLE tbl_admin MODIFY pwd NVARCHAR2(200);
ALTER TABLE tbl_admin MODIFY email NVARCHAR2(200);
ALTER TABLE tbl_admin MODIFY tel NVARCHAR2(200);


ALTER TABLE tbl_admin
   ADD
      CONSTRAINT PK_tbl_admin --         ⺻�?
      PRIMARY KEY (
         admin_seq --           ̵ 
      );



--            
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

--  й        Լ 
CREATE OR REPLACE FUNCTION generate_student_id RETURN Number IS
  v_year VARCHAR2(4);
  v_seq  VARCHAR2(5);
BEGIN
  SELECT TO_CHAR(SYSDATE, 'YYYY') INTO v_year FROM DUAL;
  SELECT LPAD(student_seq.NEXTVAL, 5, '0') INTO v_seq FROM DUAL;
  RETURN v_year || v_seq;
END;
/

--       ȣ       Լ 
CREATE OR REPLACE FUNCTION generate_professor_id RETURN Number IS
  v_year VARCHAR2(4);
  v_seq  VARCHAR2(5);
BEGIN
  SELECT TO_CHAR(SYSDATE, 'YYYY') INTO v_year FROM DUAL;
  SELECT LPAD(professor_seq.NEXTVAL, 5, '0') INTO v_seq FROM DUAL;
  RETURN v_year || v_seq;
END;
/

--       ȣ       Լ 
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

--  л     ̺   й      
INSERT INTO tbl_student (student_id, pwd, name, jubun, tel, grade, address, email, register_date, status, fk_department_seq)
VALUES (generate_student_id(), 'password123', 'John Doe', '1234567890123', '01012345678', 1, 'Some address', 'john.doe@example.com', SYSDATE, 1, 1);

select * from tbl_student;

rollback;

CREATE TABLE tbl_announcement (
   announcement_seq Number        NOT NULL, --                
   a_title          NVARCHAR2(200) NOT NULL, --         
   a_content        NVARCHAR2(600) NULL,     --         
   attatched_file   NVARCHAR2(200) NULL      -- ÷      
);

drop table tbl_announcement;

ALTER TABLE tbl_announcement
   ADD
      CONSTRAINT PK_tbl_announcement --  л          ⺻�?
      PRIMARY KEY (
         announcement_seq --                
      );
        
CREATE SEQUENCE announcement_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
CREATE TABLE tbl_recruitment_notice (
   recruitment_notice_seq Number  NOT NULL, -- ä                
   r_title                NVARCHAR2(200)      NOT NULL, --          
   r_content              NVARCHAR2(600)      NOT NULL, --          
   attatched_file         NVARCHAR2(200)      NULL      --     ÷ 
); 

CREATE SEQUENCE recruitment_notice_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
ALTER TABLE tbl_recruitment_notice
   ADD
      CONSTRAINT PK_tbl_recruitment_notice -- ä           ⺻�?
      PRIMARY KEY (
         recruitment_notice_seq -- ä                
      );
  

CREATE TABLE tbl_curriculum_type (
   curriculum_type_seq  Number        NOT NULL, --     Ÿ Խ     
   curriculum_type_name NVARCHAR2 (100) NOT NULL  --     Ÿ  
);
CREATE SEQUENCE curriculum_type_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  ALTER TABLE tbl_curriculum_type
   ADD
      CONSTRAINT PK_tbl_curriculum_type --     Ÿ    ⺻�?
      PRIMARY KEY (
         curriculum_type_seq --     Ÿ Խ     
      );
        
CREATE TABLE tbl_curriculum (
   curriculum_seq         Number        NOT NULL, --           
   fk_curriculum_type_seq Number        NOT NULL, --     Ÿ Խ     
   fk_department_seq      Number        NOT NULL, --  а  ڵ 
   grade                  SMALLINT      NULL,     --  г 
   name                   NVARCHAR2(100) NOT NULL, --       
   credit                 SMALLINT      NOT NULL  --  ̼     (n    )
);

CREATE SEQUENCE curriculum_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
  ALTER TABLE tbl_curriculum
   ADD
      CONSTRAINT PK_tbl_curriculum --       ⺻�?
      PRIMARY KEY (
         curriculum_seq --           
      );
        
        
ALTER TABLE tbl_curriculum
   ADD
      CONSTRAINT FK_tbl_curri_type_tbl_curri --     Ÿ   ->     
      FOREIGN KEY (
         fk_curriculum_type_seq --     Ÿ Խ     
      )
      REFERENCES tbl_curriculum_type ( --     Ÿ  
         curriculum_type_seq --     Ÿ Խ     
      );
ALTER TABLE tbl_curriculum
   ADD
      CONSTRAINT FK_tbl_depart_TO_tbl_curri--  а  ->     
      FOREIGN KEY (
         fk_department_seq --  а  ڵ 
      )
      REFERENCES tbl_department ( --  а 
         department_seq --  а  ڵ 
      );
        
CREATE TABLE tbl_time (
   time_seq    Number   NOT NULL, --  ð       
   day_of_week SMALLINT NOT NULL, --     
   period      SMALLINT NOT NULL  --  ð 
);

CREATE SEQUENCE time_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  ALTER TABLE tbl_time
   ADD
      CONSTRAINT PK_tbl_time --  ð ǥ  ⺻�?
      PRIMARY KEY (
         time_seq --  ð       
      );


CREATE TABLE tbl_course (
   course_seq        Number NOT NULL, --               
   fk_professor_id  Number NOT NULL, --       ȣ
   fk_curriculum_seq Number NOT NULL, --           
   fk_time_seq       Number NOT NULL, --  ð       
   capacity          Number NOT NULL, --     
   semester_date     DATE   NOT NULL  --      �? б 
);

drop table tbl_course;

CREATE SEQUENCE course_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;


ALTER TABLE tbl_course
   ADD
      CONSTRAINT PK_tbl_course --           ⺻�?
      PRIMARY KEY (
         course_seq --               
      );


ALTER TABLE tbl_course
   ADD
      CONSTRAINT FK_tbl_prof_tbl_course --      ->         
      FOREIGN KEY (
         fk_professor_id --       ȣ
      )
      REFERENCES tbl_professor ( --     
         prof_id --       ȣ
);

ALTER TABLE tbl_course
   ADD
      CONSTRAINT FK_tbl_curri_TO_tbl_course --      ->         
      FOREIGN KEY (
         fk_curriculum_seq --           
      )
      REFERENCES tbl_curriculum ( --     
         curriculum_seq --           
      );

ALTER TABLE tbl_course
   ADD
      CONSTRAINT FK_tbl_time_TO_tbl_course --  ð ǥ ->         
      FOREIGN KEY (
         fk_time_seq --  ð       
      )
      REFERENCES tbl_time ( --  ð ǥ
         time_seq --  ð       
      );


CREATE TABLE tbl_lecture (
   lecture_seq       Number         NOT NULL, -- lecture_seq
   fk_course_seq     Number         NOT NULL, --               
   video_file_name   NVARCHAR2(200) NULL,     --    ǿ        ̸ 
   lecture_file_name NVARCHAR2(200) NULL,     --      ڷ      ̸ 
   lecture_title     NVARCHAR2(200) NOT NULL, --         
   lecture_content   NVARCHAR2(800)  NOT NULL  --     ÷ 
);
CREATE SEQUENCE lecture_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;


ALTER TABLE tbl_lecture
   ADD
      CONSTRAINT PK_tbl_lecture --       ⺻�?
      PRIMARY KEY (
         lecture_seq -- lecture_seq
      );
        
        
ALTER TABLE tbl_lecture
   ADD
      CONSTRAINT FK_tbl_cours_tbl_lecture --          ->     
      FOREIGN KEY (
         fk_course_seq --               
      )
      REFERENCES tbl_course ( --         
         course_seq --               
      );

CREATE TABLE tbl_attendance (
   attendance_seq Number NOT NULL, --  �?      
   fk_course_seq  Number             NOT NULL, --               
   fk_student_id  Number             NOT NULL, --  й 
   isAttended     CHAR(1)             NOT NULL, --  �?    
   attended_date  DATE               NOT NULL  --  �?  ¥
);

CREATE SEQUENCE attendance_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

ALTER TABLE tbl_attendance
   ADD
      CONSTRAINT PK_tbl_attendance --  �?  ⺻�?
      PRIMARY KEY (
         attendance_seq --  �?      
      );

ALTER TABLE tbl_attendance
   ADD
      CONSTRAINT FK_tbl_cours_tbl_atten --          ->  �?
      FOREIGN KEY (
         fk_course_seq --               
      )
      REFERENCES tbl_course ( --         
         course_seq --               
      );
        
ALTER TABLE tbl_attendance
   ADD
      CONSTRAINT FK_tbl_stud_tbl_attend --  л  ->  �?
      FOREIGN KEY (
         fk_student_id --  й 
      )
      REFERENCES tbl_student ( --  л 
         student_id --  й 
      );

CREATE TABLE tbl_registered_course (
   registered_course_seq Number NOT NULL, --       û      
   fk_student_id         Number NOT NULL, --  л    ̵ 
   fk_course_seq         Number NOT NULL, --               
   register_date         DATE   NOT NULL  --   û  ¥
);

CREATE SEQUENCE registered_course_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
  ALTER TABLE tbl_registered_course
   ADD
      CONSTRAINT PK_tbl_registered_course --       û  ⺻�?
      PRIMARY KEY (
         registered_course_seq --       û      
      );


ALTER TABLE tbl_registered_course
   ADD
      CONSTRAINT FK_tbl_stud_tbl_regist_course --  л  ->       û2
      FOREIGN KEY (
         fk_student_id --  л    ̵ 
      )
      REFERENCES tbl_student ( --  л 
         student_id --  й 
      );
  
CREATE TABLE tbl_grade (
   grade_seq                Number    NOT NULL, --           
   fk_registered_course_seq Number    NOT NULL, --       û      
   score                    NUMber    NOT NULL, --     
   mark                     CHARACTER NOT NULL  --     (A, B ...)
);
  
  
  


ALTER TABLE tbl_registered_course
   ADD
      CONSTRAINT FK_tbl_course_tbl_regist_cour --          ->       û
      FOREIGN KEY (
         fk_course_seq --               
      )
      REFERENCES tbl_course ( --         
         course_seq --               
      );
CREATE SEQUENCE grade_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
  
  ALTER TABLE tbl_grade
   ADD
      CONSTRAINT PK_tbl_grade --       ⺻�?
      PRIMARY KEY (
         grade_seq --           
      );




ALTER TABLE tbl_grade
   ADD
      CONSTRAINT FK_regist_course_tbl_grade --       û ->     
      FOREIGN KEY (
         fk_registered_course_seq --       û      
      )
      REFERENCES tbl_registered_course ( --       û
         registered_course_seq --       û      
      );



CREATE TABLE tbl_assignment (
   assignment_seq Number         NOT NULL, --           
   fk_course_seq  Number         NOT NULL, --               
   start_datetime DATE       NOT NULL, --   Ͻð 
   end_datetime   DATE       NOT NULL, --      ð 
   title          NVARCHAR2(200)  NOT NULL, --      ̸ 
   content        NVARCHAR2(800)  NOT NULL, --          
   attatched_file NVARCHAR2(200) NULL      -- ÷      
);

CREATE SEQUENCE assignment_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
ALTER TABLE tbl_assignment
   ADD
      CONSTRAINT PK_tbl_assignment --       ⺻�?
      PRIMARY KEY (
         assignment_seq --           
      );
        
        
ALTER TABLE tbl_assignment
   ADD
      CONSTRAINT FK_tbl_cour_tbl_assigt --          ->     
      FOREIGN KEY (
         fk_course_seq --               
      )
      REFERENCES tbl_course ( --         
         course_seq --               
      );
        
  DROP TABLE tbl_assignment_submit;      

CREATE TABLE tbl_assignment_submit (
   assignment_submit_seq Number         NOT NULL, --          
   fk_assignment_seq     Number         NOT NULL, --           
   title                 NVARCHAR2(200)  NOT NULL, --     
   content               NVARCHAR2(800)  NOT NULL, --     
   score                 Number         NULL,     --     
   submit_datetime       DATE           NULL,     --     ð 
   attatched_file        NVARCHAR2(200) NULL,     -- ÷      
   fk_student_id         Number         NOT NULL  --  й 
);

CREATE SEQUENCE assignment_submit_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
  ALTER TABLE tbl_assignment_submit
   ADD
      CONSTRAINT PK_tbl_assignment_submit --           ⺻�?
      PRIMARY KEY (
         assignment_submit_seq --          
      );
        
        
ALTER TABLE tbl_assignment_submit
   ADD
      CONSTRAINT FK_tbl_assig_ass_submit --      ->         
      FOREIGN KEY (
         fk_assignment_seq --           
      )
      REFERENCES tbl_assignment ( --     
         assignment_seq --           
      )
        ON DELETE cascade;
        
ALTER TABLE tbl_assignment_submit
   ADD
      CONSTRAINT FK_tbl_stut_assig_submit --  л  ->         
      FOREIGN KEY (
         fk_student_id --  й 
      )
      REFERENCES tbl_student ( --  л 
         student_id --  й 
      );
    

desc tbl_student;
desc tbl_department;

insert into tbl_department( DEPARTMENT_SEQ, DEPARTMENT_NAME)
values (DEPARTMENT_SEQ.nextval, '  ǻ Ͱ  а ');
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
    '      ', -- NAME
    '9901011234567', -- JUBUN
    'k6AvvKD9cZaeKhlunBk9ew==', -- TEL
    1, -- GRADE
    '                     123', -- ADDRESS
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

ALTER TABLE tbl_professor
MODIFY EXTRAADDRESS NVARCHAR2(200) NULL;


INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 3, 1, '     а   ', 3, 1);
INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 4, 1, ' Žð     ', 3, 1);

INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 5, 1, 'ȭ   Թ  1', 3, 1);

INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 6, 1, 'ȭ     1', 3, 1);

INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 7, 1, 'ȸ   п   ', 3, 1);

INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 2, 1, ' �?  ', 3, 1);

select *
from tbl_curriculum;
commit;


ALTER TABLE tbl_curriculum
ADD required Number(1);

desc tbl_curriculum;

ALTER TABLE tbl_curriculum
ADD EXIST NUMBER(1) default 1 not null;

ALTER TABLE tbl_curriculum
DROP COLUMN EXIST;




ALTER TABLE tbl_curriculum
DROP COLUMN fk_curriculum_type_seq;


-- Inserting data into tbl_curriculum for ȸ���а�
BEGIN
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 1, 'ȸ�����', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 1, '�繫ȸ��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 2, '����ȸ��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 2, '����ȸ��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 3, 'ȸ�谨��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 3, '����ȸ��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 4, '����ȸ��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 4, 'ȸ�������ý���', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 4, 'ȸ�迬��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 4, '����ȸ��', 3, 1);
    
    commit;
END;


select * from tbl_curriculum
where fk_department_seq = 6;

-- Inserting data into tbl_curriculum for �۰��
BEGIN
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 1, '�۰��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 1, 'ȭ����', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 2, '������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 2, '�Ǳ��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 3, '����', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 3, '�����̷�', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 4, '���Ǻм�', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 4, '���������۰�', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 4, '��������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 4, '�۰�̳�', 3, 1);
END;


-- Inserting data into tbl_curriculum for ȭ�а��а�
BEGIN
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 1, 'ȭ�а��а���', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 1, '����ȭ��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 2, '����ȭ��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 2, '������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 3, '��������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 3, '��������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 4, '����ڰ���', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 4, '�������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 4, '����������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 4, 'ȯ�����', 3, 1);
END;


-- Inserting data into tbl_curriculum for ��������а�
BEGIN
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 1, '������󰳷�', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 1, '�����ǹ�', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 2, '�����濵', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 2, '��������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 3, '����������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 3, '�����å', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 4, '��������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 4, '������󼼹̳�', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 4, '��������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 4, '�۷ι��濵', 3, 1);
END;


-- Inserting data into tbl_curriculum for ������а�
BEGIN
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 1, '�����а���', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 1, '�ѱ����л�', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 2, '���빮��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 2, '��������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 3, '�����', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 3, '���������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 4, '�����ǹ̷�', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 4, '�񱳹���', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 4, '�������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 4, '�����̷�', 3, 1);
END;


-- Inserting data into tbl_curriculum for ��ǻ�Ͱ��а�
BEGIN
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 1, '���α׷��ֱ���', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 1, '�ڷᱸ��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 2, '�˰���', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 2, '�ü��', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 3, '�����ͺ��̽�', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 3, '��Ʈ��ũ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 4, '�ΰ�����', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 4, '��ǻ�ͺ���', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 4, '������', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 4, '����Ʈ�������', 3, 1);
END;







select *
from tbl_curriculum
where fk_department_seq = 5;

desc tbl_curriculum;

ALTER TABLE tbl_professor
MODIFY EXTRAADDRESS NVARCHAR2(200) NULL;


desc tbl_professor;


desc tbl_course;

ALTER TABLE tbl_course
DROP COLUMN FK_TIME_SEQ;

ALTER TABLE tbl_time
ADD fk_course_seq NUMBER;


ALTER TABLE tbl_time
ADD CONSTRAINT fk_course_seq
FOREIGN KEY (fk_course_seq)
REFERENCES tbl_course(course_seq);

desc tbl_time;


CREATE TABLE tbl_schedule (
	schedule_seq  Number        NOT NULL, -- �� �÷�
	title         NVARCHAR2(300) NOT NULL, -- �� �÷�4
	schedule_type SMALLINT      NOT NULL, -- �� �÷�5
	start_date    DATE          NOT NULL, -- �� �÷�2
	end_date      DATE          NOT NULL  -- �� �÷�3
);

ALTER TABLE tbl_schedule
	ADD
		CONSTRAINT PK_tbl_schedule -- �� ���̺�2 �⺻Ű
		PRIMARY KEY (
			schedule_seq -- �� �÷�
		);

create sequence schedule_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


drop table tbl_assignment;


CREATE TABLE tbl_assignment (
	schedule_seq_assignment Number         NOT NULL, -- �� �÷�
	fk_course_seq           Number         NOT NULL, -- ��������������
	content                 NVARCHAR2(1000)  NOT NULL, -- ���� ����
	attatched_file          NVARCHAR2(200) NULL      -- ÷������
);




ALTER TABLE tbl_assignment
	ADD
		CONSTRAINT PK_tbl_assignment -- ���� �⺻Ű
		PRIMARY KEY (
			schedule_seq_assignment -- �� �÷�
		);
        
ALTER TABLE tbl_assignment
	ADD
		CONSTRAINT FK_tbl_cour_tbl_assig -- �������� -> ����
		FOREIGN KEY (
			fk_course_seq -- ��������������
		)
		REFERENCES tbl_course ( -- ��������
			course_seq -- ��������������
		);

ALTER TABLE tbl_assignment
	ADD
		CONSTRAINT FK_tbl_sche_tbl_assign -- �� ���̺�2 -> ����
		FOREIGN KEY (
			schedule_seq_assignment -- �� �÷�
		)
		REFERENCES tbl_schedule ( -- �� ���̺�2
			schedule_seq -- �� �÷�
		);

desc tbl_assignment;

CREATE TABLE tbl_assignment_submit (
    assignment_submit_seq      Number          NOT NULL, -- ���������
    fk_schedule_seq_assignment Number          NULL,     -- �� �÷�
    fk_student_id              Number          NOT NULL, -- �й�
    title                      NVARCHAR2(200)  NOT NULL, -- ����
    content                    NVARCHAR2(1000) NOT NULL, -- ����
    score                      Number          NULL,     -- ����
    submit_datetime            DATE            DEFAULT SYSDATE NOT NULL, -- ����ð�
    attatched_file             NVARCHAR2(200)  NULL      -- ÷������
);

ALTER TABLE tbl_assignment_submit
	ADD
		CONSTRAINT PK_tbl_assignment_submit -- �������� �⺻Ű
		PRIMARY KEY (
			assignment_submit_seq -- ���������
		);

ALTER TABLE tbl_assignment_submit
	ADD
		CONSTRAINT FK_student_TO_assig_submit -- �л� -> ��������
		FOREIGN KEY (
			fk_student_id -- �й�
		)
		REFERENCES tbl_student ( -- �л�
			student_id -- �й�
		);


ALTER TABLE tbl_assignment_submit
	ADD
		CONSTRAINT FK_assign_TO_assign_submit -- ���� -> ��������
		FOREIGN KEY (
			fk_schedule_seq_assignment -- �� �÷�
		)
		REFERENCES tbl_assignment ( -- ����
			schedule_seq_assignment -- �� �÷�
		);


CREATE TABLE tbl_todo (
	schedule_seq Number         NOT NULL, -- �� �÷�
	content      NVARCHAR2(500) NULL      -- �� �÷�2
);


ALTER TABLE tbl_todo
	ADD
		CONSTRAINT PK_tbl_todo -- tbl_todo �⺻Ű
		PRIMARY KEY (
			schedule_seq -- �� �÷�
		);
        
        
        ALTER TABLE tbl_time
DROP COLUMN period;

ALTER TABLE tbl_time
ADD (
    start_period SMALLINT,
    end_period SMALLINT
);

desc tbl_time;


select *
from tbl_time;

DELETE FROM tbl_time;
commit;

ALTER TABLE tbl_time
MODIFY (
    start_period SMALLINT NOT NULL,
    end_period SMALLINT NOT NULL
);


select *
from tbl_time
where fk_course_seq = 4;



select *
from tbl_course
where fk_professor_id = 202400002;

desc tbl_time;

desc tbl_course;

select *
from tbl_curriculum;

ALTER TABLE tbl_COURSE ADD register_count NUMBER DEFAULT 0;


UPDATE tbl_COURSE C
SET register_count = (
    SELECT COUNT(*)
    FROM tbl_registered_course E
    WHERE E.fk_COURSE_SEQ = C.COURSE_SEQ
);




ALTER TABLE tbl_course
ADD (EXIST Number(1) default 1);

desc tbl_professor;



		select *
		from tbl_curriculum v0
		join tbl_course v1 on v0.curriculum_seq = v1.fk_curriculum_seq
		join tbl_professor v2 on v1.fk_professor_id = v2.prof_id


select
		v0.curriculum_seq as curriculum_seq,
		v0.fk_department_seq as curriculum_fk_department_seq,
		v0.grade as curriculum_grade,
		v0.name as curriculum_name,
		v0.credit as curriculum_credit,
		v0.required as curriculum_required,
		v0.exist as curriculum_exist,
		v1.course_seq as course_seq,
		v1.fk_professor_id as course_fk_professor_id,
		v1.fk_curriculum_seq as course_fk_curriculum_seq,
		v1.capacity as course_capacity,
		v1.semester_date as course_semester_date,
		v1.exist as course_exist,
		v1.register_count as course_register_count,
		v2.prof_id as professor_id,
		v2.pwd as professor_pwd,
		v2.name as professor_name,
		v2.jubun as professor_jubun,
		v2.tel as professor_tel,
		v2.department_seq as professor_department_seq,
		v2.email as professor_email,
		v2.office_address as professor_office_address,
		v2.employment_stat as professor_employment_stat,
		v2.employment_date as professor_employment_date,
		v2.img_name as professor_img_name
		from

		(
		select *
		from tbl_registered_course
		where fk_student_id = 202400003
		) t1
		join tbl_course v1 on t1.fk_course_seq = v1.course_seq
		join tbl_curriculum v0 on v1.fk_curriculum_seq = v0.curriculum_seq
		join tbl_professor v2 on v1.fk_professor_id = v2.prof_id;
        
        
        
UPDATE tbl_COURSE C
SET register_count = (
    SELECT COUNT(*)
    FROM tbl_registered_course E
    WHERE E.fk_COURSE_SEQ = C.COURSE_SEQ
); 

rollback;


select *
from tbl_course;

desc tbl_exam


select * 
from tbl_registered_course;

delete  tbl_registered_course where registered_course_Seq = 6;
commit;

		UPDATE tbl_course
		SET register_count = register_count-1
		WHERE course_seq = 22;
        
        
commit;


