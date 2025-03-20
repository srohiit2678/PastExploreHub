CREATE DATABASE IF NOT EXISTS ExploreHub;
USE ExploreHub;

-- Departments table (Created first to avoid reference errors)
CREATE TABLE IF NOT EXISTS Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE );

-- Users table (Students, Teachers, Admins)
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    enroll_id VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('Student', 'Teacher', 'Admin') NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE SET NULL );

-- Projects table
CREATE TABLE IF NOT EXISTS Projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    student_id INT NOT NULL,
    guide_id INT,
    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    department_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    project_link VARCHAR(255),
    tech_stack VARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (guide_id) REFERENCES Users(user_id) ON DELETE SET NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE SET NULL
);

-- Requests table (Tracking project submissions for approval)
CREATE TABLE IF NOT EXISTS Requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    guide_id INT NOT NULL,
    project_id INT NOT NULL,
    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reviewed_at TIMESTAMP NULL,
    FOREIGN KEY (student_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (guide_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE
);

-- Tags table
CREATE TABLE IF NOT EXISTS Tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(50) UNIQUE NOT NULL
);

-- Project_Tags table (Many-to-Many relationship between Projects & Tags)
CREATE TABLE IF NOT EXISTS Project_Tags (
    project_id INT,
    tag_id INT,
    PRIMARY KEY (project_id, tag_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES Tags(tag_id) ON DELETE CASCADE
);

-- Comments table (For feedback/discussions)
CREATE TABLE IF NOT EXISTS Comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Files table (Project-related documents and images)
CREATE TABLE Files (
    file_id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT NOT NULL,
    file_data LONGBLOB NOT NULL,   -- Store actual file content
    file_name VARCHAR(255) NOT NULL,   -- Store original filename
    file_type VARCHAR(50) NOT NULL,    -- Store MIME type (e.g., image/png, application/pdf)
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Store upload time
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS Project_Team (
    project_id INT NOT NULL,
    student_id INT NOT NULL,
    PRIMARY KEY (project_id, student_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES Users(user_id) ON DELETE CASCADE
);


ALTER TABLE Projects ADD COLUMN enroll_id VARCHAR(50) NOT NULL;ALTER TABLE Requests ADD COLUMN enroll_id VARCHAR(50) NOT NULL;ALTER TABLE Project_Team ADD COLUMN enroll_id VARCHAR(50) NOT NULL;ALTER TABLE Project_Team ADD CONSTRAINT fk_enroll FOREIGN KEY (enroll_id) REFERENCES Users(enroll_id);