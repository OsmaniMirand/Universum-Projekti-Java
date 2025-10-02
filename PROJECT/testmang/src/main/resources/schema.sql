-- Schema për Test Management System

CREATE TABLE IF NOT EXISTS test (
    id VARCHAR(36) PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    subject VARCHAR(100) NOT NULL,
    duration_minutes INT,
    total_questions INT,
    passing_score DECIMAL(5,2),
    difficulty_level ENUM('EASY', 'MEDIUM', 'HARD') NOT NULL,
    status ENUM('DRAFT', 'ACTIVE', 'INACTIVE', 'ARCHIVED') DEFAULT 'DRAFT',
    created_by VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS question (
    id VARCHAR(36) PRIMARY KEY,
    question_text TEXT NOT NULL,
    question_type ENUM('MULTIPLE_CHOICE', 'TRUE_FALSE', 'SHORT_ANSWER', 'ESSAY') NOT NULL,
    points INT DEFAULT 1,
    test_id VARCHAR(36),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (test_id) REFERENCES test(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS answer (
    id VARCHAR(36) PRIMARY KEY,
    answer_text VARCHAR(500) NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    question_id VARCHAR(36),
    order_index INT,
    FOREIGN KEY (question_id) REFERENCES question(id) ON DELETE CASCADE
);

-- Indekset për performancë më të mirë
CREATE INDEX idx_test_subject ON test(subject);
CREATE INDEX idx_test_status ON test(status);
CREATE INDEX idx_test_difficulty ON test(difficulty_level);
CREATE INDEX idx_question_test_id ON question(test_id);
CREATE INDEX idx_answer_question_id ON answer(question_id);