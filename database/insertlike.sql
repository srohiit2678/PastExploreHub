

-- 1. Insert into departments


INSERT INTO departments (department_id, department_name) VALUES 
(1, 'Computer Science'),
(2, 'Information Technology'),
(3, 'Artificial Intelligence & Machine Learning');


-- 2. Insert into users



INSERT INTO users (user_id, enroll_id, name, email, password, role, department_id) VALUES 
(1, 'CS2021001', 'Alice Johnson', 'alice@example.com', 'alice123', 'Student', 1),
(2, 'IT2021002', 'Bob Smith', 'bob@example.com', 'bob123', 'Teacher', 2),
(3, 'AIML2021003', 'Charlie Brown', 'charlie@example.com', 'charlie123', 'Admin', 3);


-- 3. Insert into projects

INSERT INTO projects (project_id, title, description, created_by, tech_stack) VALUES 
(1, 'AI Chatbot', 'An AI-powered chatbot for customer service.', 1, 'Python, TensorFlow'),
(2, 'E-Commerce Website', 'A fully functional e-commerce website.', 1, 'HTML, CSS, JavaScript, MySQL'),
(3, 'IoT Smart Home', 'A smart home automation system.', 2, 'Arduino, Python');


-- 4. Insert into files not this like this

INSERT INTO files (file_id, project_id, file_path) VALUES 
(1, 1, '/uploads/chatbot_doc.pdf'),
(2, 2, '/uploads/ecommerce_schema.png'),
(3, 3, '/uploads/smart_home_demo.mp4');

-- 5. Insert into tags

INSERT INTO tags (tag_id, tag_name) VALUES 
(1, 'Java'),
(2, 'Machine Learning'),
(3, 'Web Development'),
(4, 'Cybersecurity');


-- 6. Insert into project_tags



INSERT INTO project_tags (project_id, tag_id) VALUES 
(1, 2), -- AI Chatbot → Machine Learning
(2, 3), -- E-Commerce Website → Web Development
(3, 4); -- IoT Smart Home → Cybersecurity


-- 7. Insert into  project_team 

INSERT INTO project_team (team_id, project_id, user_id, role) VALUES 
(1, 1, 1, 'Leader'),
(2, 2, 1, 'Member'),
(3, 3, 2, 'Leader');




-- 8. Insert into requests


INSERT INTO requests (request_id, project_id, user_id, status) VALUES 
(1, 1, 2, 'Pending'),
(2, 2, 1, 'Approved'),
(3, 3, 3, 'Rejected');

INSERT INTO requests (project_id, user_id, status) VALUES (1, 2, 'Pending');




-- 9. Insert into comments


INSERT INTO comments (comment_id, project_id, user_id, comment_text) VALUES 
(1, 1, 2, 'Great AI chatbot concept!'),
(2, 2, 1, 'UI design looks great!'),
(3, 3, 3, 'Consider adding more security features.');




SET FOREIGN_KEY_CHECKS = 0;
-- Insert data here
SET FOREIGN_KEY_CHECKS = 1;



-- 1. Insert into departments
INSERT INTO departments (department_id, department_name) VALUES 
(1, 'Computer Science'),
(2, 'Information Technology'),
(3, 'Artificial Intelligence & Machine Learning');

-- 2. Insert into users
INSERT INTO users (user_id, enroll_id, name, email, password, role, department_id) VALUES 
(1, 'CS2021001', 'Alice Johnson', 'alice@example.com', 'alice123', 'Student', 1),
(2, 'IT2021002', 'Bob Smith', 'bob@example.com', 'bob123', 'Teacher', 2),
(3, 'AIML2021003', 'Charlie Brown', 'charlie@example.com', 'charlie123', 'Admin', 3);

-- 3. Insert into projects
INSERT INTO projects (project_id, title, description, created_by, tech_stack) VALUES 
(1, 'AI Chatbot', 'An AI-powered chatbot for customer service.', 1, 'Python, TensorFlow'),
(2, 'E-Commerce Website', 'A fully functional e-commerce website.', 1, 'HTML, CSS, JavaScript, MySQL'),
(3, 'IoT Smart Home', 'A smart home automation system.', 2, 'Arduino, Python');

-- 4. Insert into tags
INSERT INTO tags (tag_id, tag_name) VALUES 
(1, 'Java'),
(2, 'Machine Learning'),
(3, 'Web Development'),
(4, 'Cybersecurity');

-- 5. Insert into project_tags
INSERT INTO project_tags (project_id, tag_id) VALUES 
(1, 2), -- AI Chatbot → Machine Learning
(2, 3), -- E-Commerce Website → Web Development
(3, 4); -- IoT Smart Home → Cybersecurity

-- 6. Insert into project_team
INSERT INTO project_team (team_id, project_id, user_id, role) VALUES 
(1, 1, 1, 'Leader'),
(2, 2, 1, 'Member'),
(3, 3, 2, 'Leader');

-- 7. Insert into files
INSERT INTO files (file_id, project_id, file_path) VALUES 
(1, 1, '/uploads/chatbot_doc.pdf'),
(2, 2, '/uploads/ecommerce_schema.png'),
(3, 3, '/uploads/smart_home_demo.mp4');

-- 8. Insert into requests (without duplicate entries)
INSERT INTO requests (request_id, project_id, user_id, status) VALUES 
(1, 1, 2, 'Pending'),
(2, 2, 1, 'Approved'),
(3, 3, 3, 'Rejected');

-- 9. Insert into comments
INSERT INTO comments (comment_id, project_id, user_id, comment_text) VALUES 
(1, 1, 2, 'Great AI chatbot concept!'),
(2, 2, 1, 'UI design looks great!'),
(3, 3, 3, 'Consider adding more security features.');

-- Disable foreign key checks before insert
SET FOREIGN_KEY_CHECKS = 0;

-- Insert additional data if needed

-- Enable foreign key checks after insert
SET FOREIGN_KEY_CHECKS = 1;
