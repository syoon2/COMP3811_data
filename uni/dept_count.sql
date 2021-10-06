CREATE OR REPLACE FUNCTION dept_count(dept_name VARCHAR(20))
RETURNS INTEGER LANGUAGE plpgsql
AS
$sep$
DECLARE d_count INTEGER;
BEGIN
  SELECT count(*) INTO d_count FROM instructor
  WHERE instructor.dept_name = dept_count.dept_name;
  RETURN d_count;
END;
$sep$
