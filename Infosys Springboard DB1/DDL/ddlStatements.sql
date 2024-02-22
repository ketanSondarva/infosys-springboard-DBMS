-- Active: 1708238809852@@127.0.0.1@3306@infosyssb

-- this wont work for MySql:
-- In MySQL, you don't need to specify CONSTRAINT stud_sid_pk for the primary key constraint as it can be included directly after the column definition.
CREATE TABLE Student ( 
    Studentid INTEGER CONSTRAINT stud_sid_pk PRIMARY KEY,
    FName VARCHAR2(10), 
    ContactNo NUMBER (10)
);

-- so instead:

-- Approach 1: MySql will autogenerate name for you:
CREATE TABLE IF NOT EXISTS Student ( 
    Studentid INT PRIMARY KEY,
    FName VARCHAR(10), 
    ContactNo INT(10)
);

-- Approach 2: write the all constraints after all datatype declaration:

CREATE TABLE IF NOT EXISTS Student (
    Studentid INT,
    FName VARCHAR(10),
    ContactNo INT(10),
    CONSTRAINT stud_sid_pk PRIMARY KEY (Studentid)
);


-- In MySQL, when defining foreign key constraints, you need to explicitly specify the column(s) that the 
-- foreign key constraint references using the FOREIGN KEY keyword. Here's the corrected syntax:
-- FOREIGN KEY constraint references the Studentid column of the Student table:
CREATE TABLE IF NOT EXISTS Marks (
    CourseId INTEGER,
    Studentid INTEGER,
    MarksScored DECIMAL(5,2),
    CONSTRAINT marks_sid_fk FOREIGN KEY (Studentid) REFERENCES Student (Studentid)
);

DROP TABLE  IF EXISTS student;


-- CASCADE CONSTRAINTS clause should be added to the DROP statement to drop all the referential integrity constraints that refer to primary and unique keys in the table.
-- This wont work for the MySql:
DROP TABLE Student CASCADE CONSTRAINTS;

-- for MySql Specific you have to use these two commands in order to delete the constraints along with the table:

ALTER TABLE Marks DROP FOREIGN KEY marks_sid_fk;
DROP TABLE IF EXISTS Student;

-- CONSTRAINTS: (REFERENCIAL INTIGRITY CONTSTRINT ALREADY SEEN)

-- 1. NOT NULL | CHECK:

CREATE TABLE IF NOT EXISTS Student (
    StudentId INTEGER,
    FName VARCHAR(10) NOT NULL,
    LName VARCHAR(20),
    Gender CHAR(1),
    CONSTRAINT Stud_sid_nn CHECK (StudentId IS NOT NULL),
    CONSTRAINT Stud_gender_ck1 CHECK(Gender IN ('M', 'F'))
);


-- COMPOSITE PRIMARY KEY:

CREATE TABLE IF NOT EXISTS Marks (
    StudentId INTEGER,
    MarksId INTEGER,
    MarksScored DECIMAL(5,2),
    CONSTRAINT Marks_stid_fk FOREIGN KEY (StudentId) REFERENCES Student (StudentId),
    CONSTRAINT Stud_stid_pk PRIMARY KEY(StudentId, MarksId) -- this is called composite primary key.
);

DESC Student;

DESC Marks;

-- ALL CONSTRAINTS AT ONCE:

CREATE TABLE IF NOT EXISTS Test (
    TestId INTEGER,
    TestName VARCHAR(20) UNIQUE,
    TestCode INTEGER,
    TestDuration DECIMAL(3,1), -- Duration will be denoted in hour i.e. 3.5 hours, 2.4 hours etc.
    -- SubjectName VARCHAR(20) CHECK(TestName <> SubjectName), -- not needed, can be retrived by the SubjectCode
    SubjectCode VARCHAR(6),
    CONSTRAINT Test_pk PRIMARY KEY(TestId, TestCode, SubjectCode),
    CONSTRAINT Test_subcode_fk FOREIGN KEY (SubjectCode) REFERENCES TestSubject (SubjectCode),
    CONSTRAINT Test_chk_dursn CHECK(TestDuration <= 3.5)
);

CREATE TABLE IF NOT EXISTS TestSubject (
    SubjectCode VARCHAR(6),
    SubName VARCHAR(20),
    SubContents BLOB, -- will be PDF or other document file to display curriculum.
    CONSTRAINT Test_subcode_chk CHECK(LENGTH(SubjectCode) = 6),
    CONSTRAINT Testsub_pk PRIMARY KEY (SubjectCode)
);

DROP TABLE IF EXISTS TestSubject;

-- WE HAVE SEEN : CREATE AND DROP COMMANDS
-- ===========================================================================================================================

-- ALTER TABLE:

--- drop one column:
ALTER TABLE student DROP Gender;

--- drop two column: (mysql*)
ALTER TABLE Student DROP COLUMN FName, DROP COLUMN LName;

--- Add one column:
ALTER TABLE Student ADD Address VARCHAR(30);

--- Add two columns:
ALTER TABLE Student ADD (FName VARCHAR(15), LName VARCHAR(20));

--- modify column (Dtype):
ALTER TABLE student MODIFY FName VARCHAR(20);

--- rename column:
ALTER TABLE Student RENAME COLUMN FName to FirstName, RENAME COLUMN LName to LastName;

DESC Student;

-- ===========================================================================================================================

