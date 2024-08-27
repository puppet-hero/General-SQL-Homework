CREATE DATABASE Lab5
use Lab5

CREATE TABLE ZipCodes
(ZipCode varchar(10), 
City varchar(20),
StateAbbr char NOT NULL,
CONSTRAINT pk_zipcodes PRIMARY KEY (ZipCode))

select * from ZipCodes
exec sp_help ZipCodes

CREATE TABLE Courses
(CourseID int,
CoursePrefix varchar(5),
CourseNumber char(3),
CourseName varchar(30),
CONSTRAINT pk_courses PRIMARY KEY (CourseID))

select * from Courses
exec sp_help Courses

CREATE TABLE Campuses
(CampusID int, 
CampusName varchar(20),
CONSTRAINT pk_campuses PRIMARY KEY (CampusID))

select * from Campuses
exec sp_help Campuses
--end of those without foreign keys

CREATE TABLE Buildings
(BuildingID int,
Address varchar(40),
BuildingName varchar (40),
CampusID int NOT NULL,
ZipCode varchar(10) NOT NULL,
CONSTRAINT pk_buildings PRIMARY KEY (BuildingID),
CONSTRAINT fk_buildings_campuses FOREIGN KEY (CampusID) REFERENCES Campuses,
CONSTRAINT fk_buildings_zip FOREIGN KEY (ZipCode) REFERENCES ZipCodes)

select * from Buildings
exec sp_help Buildings

CREATE TABLE ClassRooms
(RoomNumber int,
BuildingID int NOT NULL,
Occupancy int,
CONSTRAINT pk_classrooms PRIMARY KEY (RoomNumber, BuildingID),
CONSTRAINT fk_classrooms FOREIGN KEY (BuildingID) REFERENCES Buildings)

select * from ClassRooms
exec sp_help ClassRooms

CREATE TABLE FacultyOffices
(OfficeNumber int,
BuildingID int NOT NULL,
CONSTRAINT pk_facultyoffices PRIMARY KEY (OfficeNumber, BuildingID),
CONSTRAINT fk_facultyoffices FOREIGN KEY (BuildingID) REFERENCES Buildings)

select * from FacultyOffices
exec sp_help FacultyOffices

CREATE TABLE Faculty
(FacultyID int,
FirstName varchar(30),
LastName varchar(30),
Address varchar(40),
Rank text,
Salary int,				--this is in cents
Specialty varchar(20),
OfficeNumber int,		
BuildingID int,
ZipCode varchar(10) NOT NULL,
CONSTRAINT pk_faculty PRIMARY KEY (FacultyID),
CONSTRAINT fk_faculty_office FOREIGN KEY (OfficeNumber, BuildingID) REFERENCES FacultyOffices,
CONSTRAINT fk_faculty_zip FOREIGN KEY (ZipCode) REFERENCES ZipCodes)

select * from Faculty
exec sp_help Faculty

CREATE TABLE Sections
(SectionID int,
SectionNumber char(3),
Term varchar(8),
Year char(4),	--i don't see math being performed here and i want exactly 4 digits
CourseID int NOT NULL,
RoomNumber int,
BuildingID int,
FacultyID int NOT NULL,
CONSTRAINT pk_sections PRIMARY KEY (SectionID),
CONSTRAINT fk_sections_course FOREIGN KEY (CourseID) REFERENCES Courses,
CONSTRAINT fk_sections_classroom FOREIGN KEY (RoomNumber, BuildingID) REFERENCES ClassRooms,
CONSTRAINT fk_sections_faculty FOREIGN KEY (FacultyID) REFERENCES Faculty)

select * from Sections
exec sp_help Sections

CREATE TABLE Students
(StudentID int,
FirstName varchar(30),
LastName varchar(30),
StreetAddress varchar(40),
Phone char(13),
Birthdate date,
Mentor int,
Advisor int NOT NULL,
ZipCode varchar(10) NOT NULL,
CONSTRAINT pk_students PRIMARY KEY (StudentID),
CONSTRAINT fk_students_mentor FOREIGN KEY (Mentor) REFERENCES Students(StudentID),
CONSTRAINT fk_students_advisor FOREIGN KEY (Advisor) REFERENCES Faculty(FacultyID),
CONSTRAINT fk_students_zip FOREIGN KEY (ZipCode) REFERENCES ZipCodes)

select * from Students
exec sp_help Students

CREATE TABLE Enrolled
(SectionID int,
StudentID int NOT NULL,
EnrollID int,
StartDate Date,
Grade varchar(2),
EndDate Date,
CONSTRAINT pk_enrolled PRIMARY KEY (EnrollID, StudentID, SectionID),
CONSTRAINT fk_enrolled_student FOREIGN KEY (StudentID) REFERENCES Students,
CONSTRAINT fk_enrolled_section FOREIGN KEY (SectionID) REFERENCES Sections)

select * from Enrolled
exec sp_help Enrolled