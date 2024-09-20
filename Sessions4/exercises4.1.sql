CREATE DATABASE exercises4_1;
USE exercises4_1;

CREATE TABLE class(
  classId INT PRIMARY KEY AUTO_INCREMENT,
  className VARCHAR(100) NOT NULL,
  startDate VARCHAR(255) NOT NULL,
  status BIT
);

CREATE TABLE student(
	studentId INT PRIMARY KEY AUTO_INCREMENT,
    studentName VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(11),
    classId INT,
    FOREIGN KEY(classId) REFERENCES class(classId),
    status BIT
);
CREATE TABLE subject(
	subjectId INT PRIMARY KEY AUTO_INCREMENT,
    subjectName VARCHAR(100),
    credit INT,
    status BIT
);

CREATE TABLE mark(
	markId INT PRIMARY KEY AUTO_INCREMENT,
    studentId INT,
    FOREIGN KEY (studentId) REFERENCES student(studentId),
    subjectId INT,
    FOREIGN KEY(subjectId) REFERENCES subject(subjectId),
    mark DOUBLE,
    examTime DATETIME
);


INSERT INTO class(className, startDate, status)
VALUES ('HN-JV231103', '2023-11-03',TRUE),('HN-JV231229','2023-12-29',TRUE),('HN-JV230615','2023-06-15',TRUE);

INSERT INTO student(studentName, address, phone,classId, status)
VALUES ('Hồ Da Hùng','Hà Nội','0987654321',1,TRUE),('Phan Văn Giang','Đà Nẵng','0967811255',1,TRUE),('Dương Mỹ Huyền','Hà Nội','0385546611',2,TRUE),
('Hoàng Minh Hiếu','Nghệ An','0964425633',2,TRUE),('Nguyễn Vịnh','Hà Nội','0975123552',3,TRUE),('Nam Cao','Hà Tĩnh','0919191919',1,TRUE),('Nguyễn Du','Nghệ An','0353535353',3,TRUE);

INSERT INTO subject (subjectName, credit, status)
VALUES ('Toán',3,TRUE),('Văn',3,TRUE),('Anh',2,TRUE);

INSERT INTO mark(studentId, subjectId, mark, examTime)
VALUES (1,1,7,'2024-05-12'),(1,1,7,'2024-03-15'),(2,2,8,'2024-05-15'),(2,3,9,'2024-03-08'),(3,3,10,'2024-02-11');

SELECT address, COUNT(*) AS student_count
FROM student
GROUP BY address;

SELECT s.subjectId, s.subjectName, s.credit, m.mark
FROM subject s
JOIN mark m ON s.subjectId = m.subjectId
WHERE m.mark = (SELECT MAX(mark) FROM mark);

SELECT studentId, AVG(mark) AS avg_mark
FROM mark
GROUP BY studentId;

SELECT s.studentId, s.studentName, s.address, s.phone, AVG(m.mark) AS avg_mark
FROM student s
JOIN mark m ON s.studentId = m.studentId
GROUP BY s.studentId
ORDER BY avg_mark DESC
LIMIT 1;

SELECT s.studentId, s.studentName, s.address, s.phone, AVG(m.mark) AS avg_mark
FROM student s
JOIN mark m ON s.studentId = m.studentId
GROUP BY s.studentId
ORDER BY avg_mark DESC;

