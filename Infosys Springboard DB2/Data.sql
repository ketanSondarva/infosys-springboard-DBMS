

CREATE TABLE IF NOT EXISTS StudentDetail (
    StudentId INT PRIMARY KEY,
    Fname VARCHAR(14)
);

CREATE TABLE IF NOT EXISTS Course (
    COURSEID INT PRIMARY KEY,
    CNAME VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Marks_Details (
    StudentId INT,
    CourseId INT,
    Marks DECIMAL(5,2),
    CONSTRAINT Mrks_dtls_pk PRIMARY KEY (StudentId, CourseId),
    CONSTRAINT Mrks_dtls_stdid_fk FOREIGN KEY (StudentId) REFERENCES StudentDetail (StudentId),
    CONSTRAINT Mrks_dtls_crsid_fk FOREIGN KEY (CourseId) REFERENCES Course (COURSEID)
);


INSERT INTO StudentDetail VALUES(1001, 'Alex');
INSERT INTO StudentDetail VALUES(1002, 'John');
INSERT INTO StudentDetail VALUES(1003, 'Jack');


INSERT INTO Course VALUES(1, 'Maths');
INSERT INTO Course VALUES(2, 'Physics');


INSERT INTO Marks_Details VALUES(1001, 1, 60);
INSERT INTO Marks_Details VALUES(1001, 2, 70);
INSERT INTO Marks_Details VALUES(1002, 1, 80);


SELECT * FROM StudentDetail;
SELECT * FROM Course;
SELECT * FROM Marks_Details;

