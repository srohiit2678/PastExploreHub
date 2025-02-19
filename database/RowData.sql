-- Insert into Departments
INSERT INTO Departments (department_name) VALUES
('Computer Science'),
('Information Technology'),
('Artificial Intelligence');

-- Insert into Users (Students, Teachers, Admins)
INSERT INTO Users (enroll_id, name, email, password, role, department_id) VALUES
('0832cs221001', 'Aarav Sharma', 'aaravsharma@gmail.com', 'password1', 'Student', 1),
('0832cs221004', 'Priya Verma', 'priyaverma@gmail.com', 'password2', 'Student', 1),
('0832IT221001', 'Vikram Singh', 'vikramsingh@gmail.com', 'password3', 'Student', 2),
('0832IT221009', 'Neha Patil', 'nehapatil@gmail.com', 'password4', 'Student', 2),
('0832AI221010', 'Rajesh Kumar', 'rajeshkumar@gmail.com', 'password5', 'Student', 3),
('TCH001', 'Dr. Sanjay Mehta', 'sanjaymehta@gmail.com', 'password6', 'Teacher', 1),
('TCH002', 'Prof. Anjali Rao', 'anjalirao@gmail.com', 'password7', 'Teacher', 1),
('TCH003', 'Dr. Karan Malhotra', 'karanmalhotra@gmail.com', 'password8', 'Teacher', 2),
('TCH004', 'Prof. Ritu Sharma', 'ritusharma@gmail.com', 'password9', 'Teacher', 2),
('TCH005', 'Dr. Amit Joshi', 'amitjoshi@gmail.com', 'password10', 'Teacher', 3),
('ADM001', 'Admin User', 'admin@explorehub.com', 'adminpass', 'Admin', NULL);

-- Insert into Projects
INSERT INTO Projects (title, description, student_id, guide_id, status, department_id, project_link, tech_stack) VALUES
('Smart Traffic Management System', 'AI-based traffic control system to reduce congestion.', 1, 6, 'Pending', 1, 'https://github.com/aarav/traffic-ai', 'Python, TensorFlow'),
('IoT-Based Smart Home', 'A smart home automation system using IoT.', 2, 7, 'Approved', 1, 'https://github.com/priya/home-iot', 'Arduino, Node.js'),
('AI Chatbot for College Queries', 'A chatbot that answers students’ queries using AI.', 3, 8, 'Pending', 2, 'https://github.com/vikram/ai-chatbot', 'Python, NLP, Flask'),
('E-Voting System using Blockchain', 'Secure online voting system using blockchain technology.', 4, 9, 'Rejected', 2, 'https://github.com/neha/blockchain-voting', 'Ethereum, Solidity'),
('AI-Powered Resume Screener', 'An AI-based system to evaluate resumes and shortlist candidates.', 5, 10, 'Approved', 3, 'https://github.com/rajesh/resume-ai', 'Machine Learning, Python');

-- Insert into Requests (Tracking project submissions for approval)
INSERT INTO Requests (student_id, guide_id, project_id, status, requested_at) VALUES
(1, 6, 1, 'Pending', NOW()),
(2, 7, 2, 'Approved', NOW()),
(3, 8, 3, 'Pending', NOW()),
(4, 9, 4, 'Rejected', NOW()),
(5, 10, 5, 'Approved', NOW());

-- Insert into Tags
INSERT INTO Tags (tag_name) VALUES
('Artificial Intelligence'),
('IoT'),
('Blockchain'),
('Machine Learning'),
('Automation');

-- Insert into Project_Tags (Many-to-Many mapping between Projects & Tags)
INSERT INTO Project_Tags (project_id, tag_id) VALUES
(1, 1), -- AI for Traffic
(2, 2), -- IoT for Smart Home
(3, 1), -- AI Chatbot
(4, 3), -- Blockchain E-Voting
(5, 4); -- AI Resume Screener

-- Insert into Comments (User feedback on projects)
INSERT INTO Comments (project_id, user_id, comment_text, created_at) VALUES
(1, 2, 'Great initiative! AI in traffic management is much needed.', NOW()),
(2, 1, 'IoT automation is the future. Well done!', NOW()),
(3, 3, 'Chatbots can really help students with FAQs.', NOW()),
(4, 4, 'Blockchain voting can bring more transparency.', NOW()),
(5, 5, 'AI-based resume screening can streamline hiring!', NOW());

-- Insert into Files (Project-related documents and images)
INSERT INTO Files (project_id, file_path, file_type, uploaded_at) VALUES
(1, '/uploads/traffic_ai_doc.pdf', 'Document', NOW()),
(2, '/uploads/iot_home_img1.jpg', 'Image', NOW()),
(3, '/uploads/ai_chatbot_doc.pdf', 'Document', NOW()),
(4, '/uploads/blockchain_voting_img2.jpg', 'Image', NOW()),
(5, '/uploads/resume_ai_doc.pdf', 'Document', NOW());
S