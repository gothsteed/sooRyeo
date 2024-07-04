CREATE TABLE tbl_department (
   department_seq  Number        NOT NULL, --  Ð°  Úµ 
   department_name NVARCHAR2(200) NOT NULL  --  Ð°   
);

--  Ð° 
ALTER TABLE tbl_department
   ADD
      CONSTRAINT PK_tbl_department --  Ð°   âº»Å°
      PRIMARY KEY (
         department_seq --  Ð°  Úµ 
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
   , --  Ð¹ 
   pwd               NVARCHAR2(100) NOT NULL, --   Ð¹ È£
   name              NVARCHAR2(100) NOT NULL, --     
   jubun             NVARCHAR2(13)  NOT NULL, --  Ö¹Î¹ È£
   tel               NVARCHAR2(11)  NOT NULL, -- tel
   grade             SMALLINT      NOT NULL, --  Ð³ 
   address           NVARCHAR2(200) NOT NULL, --  Ö¼ 
   email             NVARCHAR2(200) NOT NULL, --  Ì¸   
   register_date     DATE          NOT NULL, --    Ð³âµµ
   status            SMALLINT      NOT NULL, --         
   fk_department_seq Number        NOT NULL  --  Ð°  Úµ 


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
      CONSTRAINT PK_tbl_student --  Ð»   âº»Å°
      PRIMARY KEY (
         student_id --  Ð¹ 
      );

ALTER TABLE tbl_student
   ADD
      CONSTRAINT FK_tbl_depar_tbl_student --  Ð°  ->  Ð» 
      FOREIGN KEY (
         fk_department_seq --  Ð°  Úµ 
      )
      REFERENCES tbl_department ( --  Ð° 
         department_seq --  Ð°  Úµ 
      );
        
ALTER TABLE tbl_student
MODIFY status DEFAULT 1;


CREATE TABLE tbl_professor (
   prof_id         Number        NOT NULL 
   , --       È£
   pwd             NVARCHAR2(100) NOT NULL, --   Ð¹ È£
   name            NVARCHAR2(100) NOT NULL, --     
   jubun           NVARCHAR2(13)  NOT NULL, -- jubun
   tel             NVARCHAR2(11)  NOT NULL, --   È­  È£
   department_seq  Number        NOT NULL, --  Ð°  Úµ 
   email           NVARCHAR2(200) NOT NULL, --  Ì¸   
   office_address  NVARCHAR2(200) NOT NULL, --        Ö¼ 
   employment_stat SMALLINT      NOT NULL,
   employment_date DATE          NOT NULL  -- employment_date
);

ALTER TABLE tbl_professor MODIFY pwd NVARCHAR2(200);
ALTER TABLE tbl_professor MODIFY email NVARCHAR2(200);
ALTER TABLE tbl_professor MODIFY tel NVARCHAR2(200);

ALTER TABLE tbl_professor
   ADD
      CONSTRAINT PK_tbl_professor --       âº»Å°
      PRIMARY KEY (
         prof_id --       È£
      );

 ALTER TABLE tbl_professor
   MODIFY employment_stat DEFAULT 1;
    
    ALTER TABLE tbl_professor
   ADD
      CONSTRAINT FK_tbl_depart_tbl_professor --  Ð°  ->     
      FOREIGN KEY (
         department_seq --  Ð°  Úµ 
      )
      REFERENCES tbl_department ( --  Ð° 
         department_seq --  Ð°  Úµ 
      );
    
    CREATE TABLE tbl_admin (
   admin_seq Number        NOT NULL, --           Ìµ 
   name      NVARCHAR2(100) NOT NULL, --     
   pwd       NVARCHAR2(100) NOT NULL, --   Ð¹ È£
   jubun     NVARCHAR2(13)  NOT NULL, --  Ö¹Î¹ È£
   tel       NVARCHAR2(11)  NOT NULL, --   È­  È£
   email     NVARCHAR2(200) NOT NULL  --  Ì¸   
);

ALTER TABLE tbl_admin MODIFY pwd NVARCHAR2(200);
ALTER TABLE tbl_admin MODIFY email NVARCHAR2(200);
ALTER TABLE tbl_admin MODIFY tel NVARCHAR2(200);


ALTER TABLE tbl_admin
   ADD
      CONSTRAINT PK_tbl_admin --         âº»Å°
      PRIMARY KEY (
         admin_seq --           Ìµ 
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

--  Ð¹        Ô¼ 
CREATE OR REPLACE FUNCTION generate_student_id RETURN Number IS
  v_year VARCHAR2(4);
  v_seq  VARCHAR2(5);
BEGIN
  SELECT TO_CHAR(SYSDATE, 'YYYY') INTO v_year FROM DUAL;
  SELECT LPAD(student_seq.NEXTVAL, 5, '0') INTO v_seq FROM DUAL;
  RETURN v_year || v_seq;
END;
/

--       È£       Ô¼ 
CREATE OR REPLACE FUNCTION generate_professor_id RETURN Number IS
  v_year VARCHAR2(4);
  v_seq  VARCHAR2(5);
BEGIN
  SELECT TO_CHAR(SYSDATE, 'YYYY') INTO v_year FROM DUAL;
  SELECT LPAD(professor_seq.NEXTVAL, 5, '0') INTO v_seq FROM DUAL;
  RETURN v_year || v_seq;
END;
/

--       È£       Ô¼ 
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

--  Ð»     Ìº   Ð¹      
INSERT INTO tbl_student (student_id, pwd, name, jubun, tel, grade, address, email, register_date, status, fk_department_seq)
VALUES (generate_student_id(), 'password123', 'John Doe', '1234567890123', '01012345678', 1, 'Some address', 'john.doe@example.com', SYSDATE, 1, 1);

select * from tbl_student;

rollback;

CREATE TABLE tbl_announcement (
   announcement_seq Number        NOT NULL, --                
   a_title          NVARCHAR2(200) NOT NULL, --         
   a_content        NVARCHAR2(600) NULL,     --         
   attatched_file   NVARCHAR2(200) NULL      -- Ã·      
);

drop table tbl_announcement;

ALTER TABLE tbl_announcement
   ADD
      CONSTRAINT PK_tbl_announcement --  Ð»          âº»Å°
      PRIMARY KEY (
         announcement_seq --                
      );
        
CREATE SEQUENCE announcement_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
CREATE TABLE tbl_recruitment_notice (
   recruitment_notice_seq Number  NOT NULL, -- Ã¤                
   r_title                NVARCHAR2(200)      NOT NULL, --          
   r_content              NVARCHAR2(600)      NOT NULL, --          
   attatched_file         NVARCHAR2(200)      NULL      --     Ã· 
); 

CREATE SEQUENCE recruitment_notice_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
ALTER TABLE tbl_recruitment_notice
   ADD
      CONSTRAINT PK_tbl_recruitment_notice -- Ã¤           âº»Å°
      PRIMARY KEY (
         recruitment_notice_seq -- Ã¤                
      );
  

CREATE TABLE tbl_curriculum_type (
   curriculum_type_seq  Number        NOT NULL, --     Å¸ Ô½     
   curriculum_type_name NVARCHAR2 (100) NOT NULL  --     Å¸  
);
CREATE SEQUENCE curriculum_type_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  ALTER TABLE tbl_curriculum_type
   ADD
      CONSTRAINT PK_tbl_curriculum_type --     Å¸    âº»Å°
      PRIMARY KEY (
         curriculum_type_seq --     Å¸ Ô½     
      );
        
CREATE TABLE tbl_curriculum (
   curriculum_seq         Number        NOT NULL, --           
   fk_curriculum_type_seq Number        NOT NULL, --     Å¸ Ô½     
   fk_department_seq      Number        NOT NULL, --  Ð°  Úµ 
   grade                  SMALLINT      NULL,     --  Ð³ 
   name                   NVARCHAR2(100) NOT NULL, --       
   credit                 SMALLINT      NOT NULL  --  Ì¼     (n    )
);

CREATE SEQUENCE curriculum_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
  ALTER TABLE tbl_curriculum
   ADD
      CONSTRAINT PK_tbl_curriculum --       âº»Å°
      PRIMARY KEY (
         curriculum_seq --           
      );
        
        
ALTER TABLE tbl_curriculum
   ADD
      CONSTRAINT FK_tbl_curri_type_tbl_curri --     Å¸   ->     
      FOREIGN KEY (
         fk_curriculum_type_seq --     Å¸ Ô½     
      )
      REFERENCES tbl_curriculum_type ( --     Å¸  
         curriculum_type_seq --     Å¸ Ô½     
      );
ALTER TABLE tbl_curriculum
   ADD
      CONSTRAINT FK_tbl_depart_TO_tbl_curri--  Ð°  ->     
      FOREIGN KEY (
         fk_department_seq --  Ð°  Úµ 
      )
      REFERENCES tbl_department ( --  Ð° 
         department_seq --  Ð°  Úµ 
      );
        
CREATE TABLE tbl_time (
   time_seq    Number   NOT NULL, --  Ã°       
   day_of_week SMALLINT NOT NULL, --     
   period      SMALLINT NOT NULL  --  Ã° 
);

CREATE SEQUENCE time_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  ALTER TABLE tbl_time
   ADD
      CONSTRAINT PK_tbl_time --  Ã° Ç¥  âº»Å°
      PRIMARY KEY (
         time_seq --  Ã°       
      );


CREATE TABLE tbl_course (
   course_seq        Number NOT NULL, --               
   fk_professor_id  Number NOT NULL, --       È£
   fk_curriculum_seq Number NOT NULL, --           
   fk_time_seq       Number NOT NULL, --  Ã°       
   capacity          Number NOT NULL, --     
   semester_date     DATE   NOT NULL  --      âµµ Ð± 
);

drop table tbl_course;

CREATE SEQUENCE course_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;


ALTER TABLE tbl_course
   ADD
      CONSTRAINT PK_tbl_course --           âº»Å°
      PRIMARY KEY (
         course_seq --               
      );


ALTER TABLE tbl_course
   ADD
      CONSTRAINT FK_tbl_prof_tbl_course --      ->         
      FOREIGN KEY (
         fk_professor_id --       È£
      )
      REFERENCES tbl_professor ( --     
         prof_id --       È£
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
      CONSTRAINT FK_tbl_time_TO_tbl_course --  Ã° Ç¥ ->         
      FOREIGN KEY (
         fk_time_seq --  Ã°       
      )
      REFERENCES tbl_time ( --  Ã° Ç¥
         time_seq --  Ã°       
      );


CREATE TABLE tbl_lecture (
   lecture_seq       Number         NOT NULL, -- lecture_seq
   fk_course_seq     Number         NOT NULL, --               
   video_file_name   NVARCHAR2(200) NULL,     --    Ç¿        Ì¸ 
   lecture_file_name NVARCHAR2(200) NULL,     --      Ú·      Ì¸ 
   lecture_title     NVARCHAR2(200) NOT NULL, --         
   lecture_content   NVARCHAR2(800)  NOT NULL  --     Ã· 
);
CREATE SEQUENCE lecture_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;


ALTER TABLE tbl_lecture
   ADD
      CONSTRAINT PK_tbl_lecture --       âº»Å°
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
   attendance_seq Number NOT NULL, --  â¼®      
   fk_course_seq  Number             NOT NULL, --               
   fk_student_id  Number             NOT NULL, --  Ð¹ 
   isAttended     CHAR(1)             NOT NULL, --  â¼®    
   attended_date  DATE               NOT NULL  --  â¼®  Â¥
);

CREATE SEQUENCE attendance_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

ALTER TABLE tbl_attendance
   ADD
      CONSTRAINT PK_tbl_attendance --  â¼®  âº»Å°
      PRIMARY KEY (
         attendance_seq --  â¼®      
      );

ALTER TABLE tbl_attendance
   ADD
      CONSTRAINT FK_tbl_cours_tbl_atten --          ->  â¼®
      FOREIGN KEY (
         fk_course_seq --               
      )
      REFERENCES tbl_course ( --         
         course_seq --               
      );
        
ALTER TABLE tbl_attendance
   ADD
      CONSTRAINT FK_tbl_stud_tbl_attend --  Ð»  ->  â¼®
      FOREIGN KEY (
         fk_student_id --  Ð¹ 
      )
      REFERENCES tbl_student ( --  Ð» 
         student_id --  Ð¹ 
      );

CREATE TABLE tbl_registered_course (
   registered_course_seq Number NOT NULL, --       Ã»      
   fk_student_id         Number NOT NULL, --  Ð»    Ìµ 
   fk_course_seq         Number NOT NULL, --               
   register_date         DATE   NOT NULL  --   Ã»  Â¥
);

CREATE SEQUENCE registered_course_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
  ALTER TABLE tbl_registered_course
   ADD
      CONSTRAINT PK_tbl_registered_course --       Ã»  âº»Å°
      PRIMARY KEY (
         registered_course_seq --       Ã»      
      );


ALTER TABLE tbl_registered_course
   ADD
      CONSTRAINT FK_tbl_stud_tbl_regist_course --  Ð»  ->       Ã»2
      FOREIGN KEY (
         fk_student_id --  Ð»    Ìµ 
      )
      REFERENCES tbl_student ( --  Ð» 
         student_id --  Ð¹ 
      );
  
CREATE TABLE tbl_grade (
   grade_seq                Number    NOT NULL, --           
   fk_registered_course_seq Number    NOT NULL, --       Ã»      
   score                    NUMber    NOT NULL, --     
   mark                     CHARACTER NOT NULL  --     (A, B ...)
);
  
  
  


ALTER TABLE tbl_registered_course
   ADD
      CONSTRAINT FK_tbl_course_tbl_regist_cour --          ->       Ã»
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
      CONSTRAINT PK_tbl_grade --       âº»Å°
      PRIMARY KEY (
         grade_seq --           
      );




ALTER TABLE tbl_grade
   ADD
      CONSTRAINT FK_regist_course_tbl_grade --       Ã» ->     
      FOREIGN KEY (
         fk_registered_course_seq --       Ã»      
      )
      REFERENCES tbl_registered_course ( --       Ã»
         registered_course_seq --       Ã»      
      );



CREATE TABLE tbl_assignment (
   assignment_seq Number         NOT NULL, --           
   fk_course_seq  Number         NOT NULL, --               
   start_datetime DATE       NOT NULL, --   Ï½Ã° 
   end_datetime   DATE       NOT NULL, --      Ã° 
   title          NVARCHAR2(200)  NOT NULL, --      Ì¸ 
   content        NVARCHAR2(800)  NOT NULL, --          
   attatched_file NVARCHAR2(200) NULL      -- Ã·      
);

CREATE SEQUENCE assignment_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
ALTER TABLE tbl_assignment
   ADD
      CONSTRAINT PK_tbl_assignment --       âº»Å°
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
   submit_datetime       DATE           NULL,     --     Ã° 
   attatched_file        NVARCHAR2(200) NULL,     -- Ã·      
   fk_student_id         Number         NOT NULL  --  Ð¹ 
);

CREATE SEQUENCE assignment_submit_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
  
  
  ALTER TABLE tbl_assignment_submit
   ADD
      CONSTRAINT PK_tbl_assignment_submit --           âº»Å°
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
      CONSTRAINT FK_tbl_stut_assig_submit --  Ð»  ->         
      FOREIGN KEY (
         fk_student_id --  Ð¹ 
      )
      REFERENCES tbl_student ( --  Ð» 
         student_id --  Ð¹ 
      );
    

desc tbl_student;
desc tbl_department;

insert into tbl_department( DEPARTMENT_SEQ, DEPARTMENT_NAME)
values (DEPARTMENT_SEQ.nextval, '  Ç» Í°  Ð° ');
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

ALTER TABLE tbl_curriculum
MODIFY FK_CURRICULUM_TYPE_SEQ NUMBER NULL;


INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 3, 1, '     Ð°   ', 3, 1);
INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 4, 1, ' Å½Ã°     ', 3, 1);

INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 5, 1, 'È­   Ô¹  1', 3, 1);

INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 6, 1, 'È­     1', 3, 1);

INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 7, 1, 'È¸   Ð¿   ', 3, 1);

INSERT INTO tbl_curriculum (curriculum_seq, fk_curriculum_type_seq, fk_department_seq, grade, name, credit, Required)
VALUES (curriculum_seq.nextval, 1, 2, 1, ' î¿µÃ¼  ', 3, 1);

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


-- Inserting data into tbl_curriculum for È¸°èÇÐ°ú
BEGIN
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 1, 'È¸°è¿ø¸®', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 1, 'Àç¹«È¸°è', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 2, '°ü¸®È¸°è', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 2, '¼¼¹«È¸°è', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 3, 'È¸°è°¨»ç', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 3, '¿ø°¡È¸°è', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 4, '±¹Á¦È¸°è', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 4, 'È¸°èÁ¤º¸½Ã½ºÅÛ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 4, 'È¸°è¿¬±¸', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 7, 4, 'Àü»êÈ¸°è', 3, 1);
    
    commit;
END;


select * from tbl_curriculum
where fk_department_seq = 6;

-- Inserting data into tbl_curriculum for ÀÛ°î°ú
BEGIN
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 1, 'ÀÛ°î°³·Ð', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 1, 'È­¼ºÇÐ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 2, '´ëÀ§¹ý', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 2, '¾Ç±â·Ð', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 3, 'Æí°î¹ý', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 3, 'À½¾ÇÀÌ·Ð', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 4, 'À½¾ÇºÐ¼®', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 4, 'Çö´ëÀ½¾ÇÀÛ°î', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 4, 'ÀüÀÚÀ½¾Ç', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 6, 4, 'ÀÛ°î¼¼¹Ì³ª', 3, 1);
END;


-- Inserting data into tbl_curriculum for È­ÇÐ°øÇÐ°ú
BEGIN
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 1, 'È­ÇÐ°øÇÐ°³·Ð', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 1, 'À¯±âÈ­ÇÐ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 2, '¹°¸®È­ÇÐ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 2, '¿­¿ªÇÐ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 3, '¹ÝÀÀ°øÇÐ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 3, '°øÁ¤Á¦¾î', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 4, '°íºÐÀÚ°øÇÐ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 4, '³ª³ë°øÇÐ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 4, '¿¡³ÊÁö°øÇÐ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 5, 4, 'È¯°æ°øÇÐ', 3, 1);
END;


-- Inserting data into tbl_curriculum for ±¹Á¦Åë»óÇÐ°ú
BEGIN
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 1, '±¹Á¦Åë»ó°³·Ð', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 1, '¹«¿ª½Ç¹«', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 2, '±¹Á¦°æ¿µ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 2, '¹«¿ª¹ý±Ô', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 3, '±¹Á¦¸¶ÄÉÆÃ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 3, 'Åë»óÁ¤Ã¥', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 4, '±¹Á¦±ÝÀ¶', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 4, '±¹Á¦Åë»ó¼¼¹Ì³ª', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 4, '¹«¿ª°ü¸®', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 4, 4, '±Û·Î¹ú°æ¿µ', 3, 1);
END;


-- Inserting data into tbl_curriculum for ±¹¾î±¹¹®ÇÐ°ú
BEGIN
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 1, '±¹¾îÇÐ°³·Ð', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 1, 'ÇÑ±¹¹®ÇÐ»ç', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 2, 'Çö´ë¹®ÇÐ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 2, '°íÀü¹®ÇÐ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 3, '±¹¾î¹®¹ý', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 3, '±¹¾îÀ½¿î·Ð', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 4, '±¹¾îÀÇ¹Ì·Ð', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 4, 'ºñ±³¹®ÇÐ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 4, '±¹¾î±³À°·Ð', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 3, 4, '¹®ÇÐÀÌ·Ð', 3, 1);
END;


-- Inserting data into tbl_curriculum for ÄÄÇ»ÅÍ°øÇÐ°ú
BEGIN
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 1, 'ÇÁ·Î±×·¡¹Ö±âÃÊ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 1, 'ÀÚ·á±¸Á¶', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 2, '¾Ë°í¸®Áò', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 2, '¿î¿µÃ¼Á¦', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 3, 'µ¥ÀÌÅÍº£ÀÌ½º', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 3, '³×Æ®¿öÅ©', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 4, 'ÀÎ°øÁö´É', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 4, 'ÄÄÇ»ÅÍºñÀü', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 4, 'ºòµ¥ÀÌÅÍ', 3, 1);
    
    INSERT INTO tbl_curriculum (curriculum_seq, fk_department_seq, grade, name, credit, required)
    VALUES (curriculum_seq.nextval, 2, 4, '¼ÒÇÁÆ®¿þ¾î°øÇÐ', 3, 1);
END;







select *
from tbl_curriculum
where fk_department_seq = 3;

desc tbl_curriculum;






