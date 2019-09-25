-- Micro Uuiversity
create table course
	(course_id		varchar(8), 
	 title			varchar(50), 
	 dept_name		varchar(20),
	 credits		numeric(2,0) check (credits > 0),
	 primary key (course_id)
	);


create table prereq
	(course_id		varchar(8), 
	 prereq_id		varchar(8),
	 primary key (course_id, prereq_id)
	);


insert into course values ('BIO-301', 'Genetics', 'Biology', '4');
insert into course values ('CS-190', 'Game Design', 'Comp. Sci.', '4');
insert into course values ('CS-315', 'Robotics', 'Comp. Sci.', '3');
insert into prereq values ('BIO-301', 'BIO-101');
insert into prereq values ('CS-190', 'CS-101');
insert into prereq values ('CS-347', 'CS-101');
