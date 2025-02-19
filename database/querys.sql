--1.Retrieve all projects:

SELECT * FROM Projects;

--2.Retrieve all users and their roles:

SELECT name, role FROM Users;

--3.Get projects awaiting approval:

SELECT * FROM Projects WHERE status = 'Pending';

--4.Assign a guide to a project:

UPDATE Projects SET guide_id = 2 WHERE project_id = 1;

--5.Approve a project request:

UPDATE Requests SET status = 'Approved', reviewed_at = NOW() WHERE request_id = 1;

--6. Fatch all details of a student:

SELECT 
    p.project_id, 
    p.title, 
    p.description, 
    p.status, 
    p.created_at, 
    p.project_link, 
    p.tech_stack, 
    d.department_name, 
    s.user_id AS student_id, 
    s.name AS student_name, 
    s.email AS student_email, 
    g.user_id AS guide_id, 
    g.name AS guide_name, 
    g.email AS guide_email,
    GROUP_CONCAT(DISTINCT t.tag_name) AS tags,
    GROUP_CONCAT(DISTINCT c.comment_text ORDER BY c.created_at DESC SEPARATOR ' || ') AS comments,
    GROUP_CONCAT(DISTINCT f.file_path ORDER BY f.uploaded_at DESC SEPARATOR ' || ') AS files
FROM Projects p
LEFT JOIN Users s ON p.student_id = s.user_id
LEFT JOIN Users g ON p.guide_id = g.user_id
LEFT JOIN Departments d ON p.department_id = d.department_id
LEFT JOIN Project_Tags pt ON p.project_id = pt.project_id
LEFT JOIN Tags t ON pt.tag_id = t.tag_id
LEFT JOIN Comments c ON p.project_id = c.project_id
LEFT JOIN Files f ON p.project_id = f.project_id
WHERE p.project_id = <PROJECT_ID> -- 🔥 Filter by
GROUP BY p.project_id, s.user_id, g.user_id, d.department_name;


-- 6.1 Fetch All Projects of a Specific Student
--To fetch all projects of a specific student, you need to filter by s.user_id
USE explorehub;

SELECT 
    p.project_id, 
    p.title, 
    p.description, 
    p.status, 
    p.created_at, 
    p.project_link, 
    p.tech_stack, 
    d.department_name, 
    s.user_id AS student_id, 
    s.name AS student_name, 
    s.email AS student_email, 
    g.user_id AS guide_id, 
    g.name AS guide_name, 
    g.email AS guide_email,
    GROUP_CONCAT(DISTINCT t.tag_name SEPARATOR ', ') AS tags,
    GROUP_CONCAT(DISTINCT c.comment_text ORDER BY c.created_at DESC SEPARATOR ' || ') AS comments,
    GROUP_CONCAT(DISTINCT f.file_path ORDER BY f.uploaded_at DESC SEPARATOR ' || ') AS files
FROM Projects p
LEFT JOIN Users s ON p.student_id = s.user_id
LEFT JOIN Users g ON p.guide_id = g.user_id
LEFT JOIN Departments d ON p.department_id = d.department_id
LEFT JOIN Project_Tags pt ON p.project_id = pt.project_id
LEFT JOIN Tags t ON pt.tag_id = t.tag_id
LEFT JOIN Comments c ON p.project_id = c.project_id
LEFT JOIN Files f ON p.project_id = f.project_id
WHERE s.user_id = <STUDENT_ID>   -- 🔥 Filter by student ID
GROUP BY p.project_id, s.user_id, g.user_id, d.department_name;


--6.2 To fetch projects of a specific student in a specific department:

WHERE s.user_id = <STUDENT_ID> AND d.department_id = <DEPT_ID>; -- 🔥 Filter by department


--6.3 To fetch only pending projects of a student:

WHERE s.user_id = <STUDENT_ID> AND p.status = 'Pending'; -- 🔥 Filter by panding status

--6.4 

USE explorehub;  
-- Replace with your actual database name
SELECT 
    p.project_id, 
    p.title, 
    p.description, 
    p.status, 
    p.created_at, 
    p.project_link, 
    p.tech_stack, 
    d.department_name, 
    s.user_id AS student_id, 
    s.name AS student_name, 
    s.email AS student_email, 
    g.user_id AS guide_id, 
    g.name AS guide_name, 
    g.email AS guide_email,
    GROUP_CONCAT(DISTINCT t.tag_name SEPARATOR ', ') AS tags,
    GROUP_CONCAT(DISTINCT c.comment_text ORDER BY c.created_at DESC SEPARATOR ' || ') AS comments,
    GROUP_CONCAT(DISTINCT f.file_path ORDER BY f.uploaded_at DESC SEPARATOR ' || ') AS files
FROM Projects p
LEFT JOIN Users s ON p.student_id = s.user_id
LEFT JOIN Users g ON p.guide_id = g.user_id
LEFT JOIN Departments d ON p.department_id = d.department_id
LEFT JOIN Project_Tags pt ON p.project_id = pt.project_id
LEFT JOIN Tags t ON pt.tag_id = t.tag_id
LEFT JOIN Comments c ON p.project_id = c.project_id
LEFT JOIN Files f ON p.project_id = f.project_id
WHERE s.user_id = 1
GROUP BY p.project_id, s.user_id, g.user_id, d.department_name;


--7.Fetch All Details of a Specific Project:
--(Includes project, student, guide, and department details):

SELECT 
    p.project_id, 
    p.title, 
    p.description, 
    p.status, 
    p.created_at, 
    p.project_link, 
    p.tech_stack, 
    s.name AS student_name, 
    g.name AS guide_name, 
    d.department_name
FROM Projects p
JOIN Users s ON p.student_id = s.user_id
LEFT JOIN Users g ON p.guide_id = g.user_id
JOIN Departments d ON p.department_id = d.department_id
WHERE p.project_id = 1;

--8.Fetch All Projects with Their Respective Tags:
-- Run without change
SELECT 
    p.project_id, 
    p.title, 
    GROUP_CONCAT(t.tag_name SEPARATOR ', ') AS tags
FROM Projects p
LEFT JOIN Project_Tags pt ON p.project_id = pt.project_id
LEFT JOIN Tags t ON pt.tag_id = t.tag_id
GROUP BY p.project_id, p.title;


--9.Retrieve All Students and Their Submitted Projects:
-- Run without change

SELECT 
    u.name AS student_name, 
    p.project_id, 
    p.title, 
    p.status
FROM Users u
JOIN Projects p ON u.user_id = p.student_id
WHERE u.role = 'Student';


--10.List All Pending Project Requests with Student and Guide Names

SELECT 
    r.request_id, 
    s.name AS student_name, 
    g.name AS guide_name, 
    p.title AS project_title, 
    r.status, 
    r.requested_at
FROM Requests r
JOIN Users s ON r.student_id = s.user_id
JOIN Users g ON r.guide_id = g.user_id
JOIN Projects p ON r.project_id = p.project_id
WHERE r.status = 'Pending';


--11.Count Projects by Status (Pending, Approved, Rejected):

SELECT 
    status, 
    COUNT(*) AS total_projects
FROM Projects
GROUP BY status;



--12.List Teachers with the Number of Projects They Have Approved:

SELECT 
    g.name AS guide_name, 
    COUNT(p.project_id) AS total_approved_projects
FROM Users g
JOIN Projects p ON g.user_id = p.guide_id
WHERE p.status = 'Approved'
GROUP BY g.name;




--13.Retrieve All Comments on a Specific Project:

SELECT 
    c.comment_text, 
    u.name AS commenter, 
    c.created_at
FROM Comments c
JOIN Users u ON c.user_id = u.user_id
WHERE c.project_id = 1
ORDER BY c.created_at DESC;

--14.Fetch All Files Uploaded for a Project:

SELECT 
    f.file_id, 
    f.file_path, 
    f.file_type, 
    f.uploaded_at
FROM Files f
WHERE f.project_id = 1;

--15.Fetch Specific Project Details (With Student & Guide Info):

SELECT 
    p.project_id, 
    p.title, 
    p.description, 
    p.status, 
    p.created_at, 
    p.project_link, 
    p.tech_stack, 
    d.department_name, 
    s.user_id AS student_id, 
    s.name AS student_name, 
    s.email AS student_email, 
    g.user_id AS guide_id, 
    g.name AS guide_name, 
    g.email AS guide_email,
    GROUP_CONCAT(DISTINCT t.tag_name SEPARATOR ', ') AS tags,
    GROUP_CONCAT(DISTINCT c.comment_text ORDER BY c.created_at DESC SEPARATOR ' || ') AS comments,
    GROUP_CONCAT(DISTINCT f.file_path ORDER BY f.uploaded_at DESC SEPARATOR ' || ') AS files
FROM Projects p
LEFT JOIN Users s ON p.student_id = s.user_id
LEFT JOIN Users g ON p.guide_id = g.user_id
LEFT JOIN Departments d ON p.department_id = d.department_id
LEFT JOIN Project_Tags pt ON p.project_id = pt.project_id
LEFT JOIN Tags t ON pt.tag_id = t.tag_id
LEFT JOIN Comments c ON p.project_id = c.project_id
LEFT JOIN Files f ON p.project_id = f.project_id
WHERE p.project_id = <PROJECT_ID>
GROUP BY p.project_id, s.user_id, g.user_id, d.department_name;

--16. Fetch All Projects Submitted by a Specific Student:

SELECT 
    p.project_id, 
    p.title, 
    p.status, 
    p.created_at, 
    d.department_name, 
    g.name AS guide_name
FROM Projects p
LEFT JOIN Departments d ON p.department_id = d.department_id
LEFT JOIN Users g ON p.guide_id = g.user_id
WHERE p.student_id = <STUDENT_ID>;

--17. Fetch All Files Related to a Specific Project:

SELECT 
    file_id, 
    file_path, 
    file_type, 
    uploaded_at 
FROM Files 
WHERE project_id = <PROJECT_ID>;

--18. Fetch All Tags Associated with a Specific Project :

SELECT 
    t.tag_id, 
    t.tag_name 
FROM Tags t
JOIN Project_Tags pt ON t.tag_id = pt.tag_id
WHERE pt.project_id = <PROJECT_ID>;

--19.  Fetch All Comments on a Specific Project:

SELECT 
    c.comment_text, 
    u.name AS commenter_name, 
    c.created_at
FROM Comments c
JOIN Users u ON c.user_id = u.user_id
WHERE c.project_id = <PROJECT_ID>
ORDER BY c.created_at DESC;

-- 20.Fetch All Requests Waiting for Approval:

SELECT 
    r.request_id, 
    s.name AS student_name, 
    g.name AS guide_name, 
    p.title AS project_title, 
    r.status, 
    r.requested_at 
FROM Requests r
JOIN Users s ON r.student_id = s.user_id
JOIN Users g ON r.guide_id = g.user_id
JOIN Projects p ON r.project_id = p.project_id
WHERE r.status = 'Pending';

--21. Approve a Project Submission Request:

UPDATE Requests 
SET status = 'Approved', reviewed_at = NOW() 
WHERE request_id = <REQUEST_ID>;

--22.Reject a Project Submission Request:

UPDATE Requests 
SET status = 'Rejected', reviewed_at = NOW() 
WHERE request_id = <REQUEST_ID>;

--23. Count the Number of Projects by Department:

SELECT 
    d.department_name, 
    COUNT(p.project_id) AS total_projects 
FROM Departments d
LEFT JOIN Projects p ON d.department_id = p.department_id
GROUP BY d.department_name;


--24. Count the Number of Projects by Department:

 SELECT 
    d.department_name, 
    COUNT(p.project_id) AS total_projects 
FROM Departments d
LEFT JOIN Projects p ON d.department_id = p.department_id
GROUP BY d.department_name;

-- 25. Search for Projects by Keyword in Title or Description:

SELECT 
    project_id, 
    title, 
    description, 
    status 
FROM Projects 
WHERE title LIKE '%<KEYWORD>%' OR description LIKE '%<KEYWORD>%';

--26.  List All Teachers (Guides) in a Specific Department:

SELECT 
    user_id, 
    name, 
    email 
FROM Users 
WHERE role = 'Teacher' AND department_id = <DEPARTMENT_ID>;


--27. Fetch All Projects Along with Their Status:

SELECT 
    project_id, 
    title, 
    status, 
    created_at 
FROM Projects 
ORDER BY created_at DESC;

--28. Get Projects Without Any Guide Assigned:

SELECT 
    project_id, 
    title, 
    status 
FROM Projects 
WHERE guide_id IS NULL;

--29. Get All Projects Assigned to a Specific Guide

SELECT 
    p.project_id, 
    p.title, 
    p.status, 
    p.created_at, 
    s.name AS student_name
FROM Projects p
JOIN Users s ON p.student_id = s.user_id
WHERE p.guide_id = <GUIDE_ID>;

--30.  Fetch the Most Popular Projects (Based on Comments Count):

SELECT 
    p.project_id, 
    p.title, 
    COUNT(c.comment_id) AS total_comments 
FROM Projects p
LEFT JOIN Comments c ON p.project_id = c.project_id
GROUP BY p.project_id
ORDER BY total_comments DESC
LIMIT 5;


--31. Count of Projects by Status:

SELECT 
    status, 
    COUNT(*) AS total_projects 
FROM Projects 
GROUP BY status;

--32. Count of Students Per Department:

SELECT 
    d.department_name, 
    COUNT(u.user_id) AS total_students 
FROM Users u
JOIN Departments d ON u.department_id = d.department_id
WHERE u.role = 'Student'
GROUP BY d.department_name;


--33. Get the Total Number of Projects in Each Department:

SELECT 
    d.department_name, 
    COUNT(p.project_id) AS total_projects 
FROM Departments d
LEFT JOIN Projects p ON d.department_id = p.department_id
GROUP BY d.department_name;

--34. Get the Number of Comments Per Project:

SELECT 
    p.title, 
    COUNT(c.comment_id) AS total_comments 
FROM Projects p
LEFT JOIN Comments c ON p.project_id = c.project_id
GROUP BY p.project_id
ORDER BY total_comments DESC;

--35. Find the Most Active Students (Based on Project Submissions):

SELECT 
    s.name AS student_name, 
    COUNT(p.project_id) AS total_projects 
FROM Users s
JOIN Projects p ON s.user_id = p.student_id
WHERE s.role = 'Student'
GROUP BY s.user_id
ORDER BY total_projects DESC
LIMIT 5;

--36. Find the Most Active Teachers (Based on Project Approvals):

SELECT 
    g.name AS guide_name, 
    COUNT(p.project_id) AS total_approved_projects 
FROM Users g
JOIN Projects p ON g.user_id = p.guide_id
WHERE p.status = 'Approved'
GROUP BY g.user_id
ORDER BY total_approved_projects DESC
LIMIT 5;


--37.Search for Projects by Tags:

SELECT 
    p.project_id, 
    p.title, 
    GROUP_CONCAT(t.tag_name SEPARATOR ', ') AS tags
FROM Projects p
JOIN Project_Tags pt ON p.project_id = pt.project_id
JOIN Tags t ON pt.tag_id = t.tag_id
WHERE t.tag_name LIKE '%<TAG_NAME>%'
GROUP BY p.project_id;


--38. Get the Most Common Tags Used in Projects:

SELECT 
    t.tag_name, 
    COUNT(pt.project_id) AS total_projects 
FROM Tags t
JOIN Project_Tags pt ON t.tag_id = pt.tag_id
GROUP BY t.tag_name
ORDER BY total_projects DESC
LIMIT 10;


--39. Get All Projects With a Specific Tech Stack:

SELECT 
    project_id, 
    title, 
    tech_stack 
FROM Projects 
WHERE tech_stack LIKE '%<TECH_NAME>%';


--40. Get Trending Technologies (Most Used Tech Stacks):

SELECT 
    tech_stack, 
    COUNT(*) AS usage_count 
FROM Projects 
GROUP BY tech_stack 
ORDER BY usage_count DESC 
LIMIT 5;


--41. List All Files for a Given Project:

SELECT 
    file_id, 
    file_path, 
    file_type, 
    uploaded_at 
FROM Files 
WHERE project_id = <PROJECT_ID>;


--42.Get All Images Uploaded for a Project:

SELECT 
    file_path 
FROM Files 
WHERE project_id = <PROJECT_ID> AND file_type = 'Image';


--43.Get All Documents Uploaded for a Project:

SELECT 
    file_path 
FROM Files 
WHERE project_id = <PROJECT_ID> AND file_type = 'Document';


--44.Fetch a User's Profile by Email:

SELECT 
    user_id, 
    enroll_id, 
    name, 
    email, 
    role, 
    department_id 
FROM Users 
WHERE email = '<USER_EMAIL>';


--45.Fetch All Guides (Teachers) in the System:

SELECT 
    user_id, 
    name, 
    email 
FROM Users 
WHERE role = 'Teacher';


--46.Fetch Users by Role:

SELECT 
    user_id, 
    name, 
    email, 
    role 
FROM Users 
WHERE role = '<ROLE>'; -- Student, Teacher, or Admin


--47.Disable a User Account (Soft Delete):

UPDATE Users 
SET is_active = 0 
WHERE user_id = <USER_ID>;


--48.Get All Projects Submitted in the Last 30 Days:

SELECT 
    project_id, 
    title, 
    created_at 
FROM Projects 
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY);


--49.Get Pending Requests Older Than 7 Days:

SELECT 
    request_id, 
    student_id, 
    guide_id, 
    project_id, 
    status, 
    requested_at 
FROM Requests 
WHERE status = 'Pending' 
AND requested_at < DATE_SUB(NOW(), INTERVAL 7 DAY);


--50.Find Students Who Have Not Submitted Any Projects:

SELECT 
    u.user_id, 
    u.name, 
    u.email 
FROM Users u
LEFT JOIN Projects p ON u.user_id = p.student_id
WHERE p.project_id IS NULL AND u.role = 'Student';

--51.Get Students with Rejected Projects:

SELECT 
    u.user_id, 
    u.name, 
    u.email, 
    COUNT(p.project_id) AS rejected_projects 
FROM Users u
JOIN Projects p ON u.user_id = p.student_id
WHERE p.status = 'Rejected'
GROUP BY u.user_id;










--not for Know do not Execute this

































--52. Delete a Specific User (Student, Teacher, or Admin):

DELETE FROM Users WHERE user_id = <USER_ID>;

--53.Delete a Project (Including Its Dependencies):

DELETE FROM Projects WHERE project_id = <PROJECT_ID>;


--54.This will fail if the project is referenced in Requests, Tags, Comments, or Files. To ensure a cascade delete::

DELETE FROM Comments WHERE project_id = <PROJECT_ID>;
DELETE FROM Files WHERE project_id = <PROJECT_ID>;
DELETE FROM Project_Tags WHERE project_id = <PROJECT_ID>;
DELETE FROM Requests WHERE project_id = <PROJECT_ID>;
DELETE FROM Projects WHERE project_id = <PROJECT_ID>;


--55.Delete a Request for Project Approval:

DELETE FROM Requests WHERE request_id = <REQUEST_ID>;


--56.Delete a Comment by ID:

DELETE FROM Comments WHERE comment_id = <COMMENT_ID>;


--57.Delete All Comments for a Specific Project:

DELETE FROM Comments WHERE project_id = <PROJECT_ID>;


--58.Delete All Requests from a Specific Student:

DELETE FROM Requests WHERE student_id = <STUDENT_ID>;


--59.Delete a Tag from the Database:

DELETE FROM Tags WHERE tag_id = <TAG_ID>;


--60.Remove a Tag from a Project (Many-to-Many Table):

DELETE FROM Project_Tags WHERE project_id = <PROJECT_ID> AND tag_id = <TAG_ID>;


--61.Delete a File Associated with a Project:

DELETE FROM Files WHERE file_id = <FILE_ID>;


--62.Delete All Data of a Specific Department (Including Users & Projects):

DELETE FROM Users WHERE department_id = <DEPARTMENT_ID>;
DELETE FROM Projects WHERE department_id = <DEPARTMENT_ID>;
DELETE FROM Departments WHERE department_id = <DEPARTMENT_ID>;

-- UPDATE Queries (Modifying Data)::


--63. Update a User's Role (Change Student to Teacher, etc.):

UPDATE Users 
SET role = 'Teacher' 
WHERE user_id = <USER_ID>;


--64.Update a User’s Email Address:

UPDATE Users 
SET email = 'newemail@example.com' 
WHERE user_id = <USER_ID>;


--65.Update a User’s Password (After Encryption):

UPDATE Users 
SET password = 'newencryptedpassword' 
WHERE user_id = <USER_ID>;


--66.Update a Project’s Status (Approve or Reject):

UPDATE Projects 
SET status = 'Approved' 
WHERE project_id = <PROJECT_ID>;


--67. Assign a Guide to a Project:

UPDATE Projects 
SET guide_id = <GUIDE_ID> 
WHERE project_id = <PROJECT_ID>;


--68.Change the Date When a Project Was Created (For Testing):

UPDATE Projects 
SET created_at = '2024-01-15 10:30:00' 
WHERE project_id = <PROJECT_ID>;


--69. Rename a Tag in the System:

UPDATE Tags 
SET tag_name = 'Updated Tag Name' 
WHERE tag_id = <TAG_ID>;


--70.Edit a Project's Description:

UPDATE Projects 
SET description = 'Updated project description goes here' 
WHERE project_id = <PROJECT_ID>;

--71.Change a Request's Status:

UPDATE Requests 
SET status = 'Approved', reviewed_at = NOW() 
WHERE request_id = <REQUEST_ID>;


--72.Change a Comment’s Text:

UPDATE Comments 
SET comment_text = 'Updated comment content' 
WHERE comment_id = <COMMENT_ID>;


--73. Update a File Path:

UPDATE Files 
SET file_path = '/new/path/to/file.pdf' 
WHERE file_id = <FILE_ID>;


--74.Update the Tech Stack Used in a Project:

UPDATE Projects 
SET tech_stack = 'Java, Spring Boot, React' 
WHERE project_id = <PROJECT_ID>;


--75.:



--76.:



--77.:



--78.:



--79.:



--80.:





