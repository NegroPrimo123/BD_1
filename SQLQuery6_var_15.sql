CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password_hash NVARCHAR(255) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()

);

CREATE TABLE Categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Posts (
    post_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    category_id INT NOT NULL,
    title NVARCHAR(255) NOT NULL,
    content NVARCHAR(MAX),
    is_deleted BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    deleted_at DATETIME NULL,
    deleted_by INT NULL, -- ������� ��� ������ ��� �������� �� ��� �������� �����
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);


CREATE TABLE Media (
    media_id INT IDENTITY(1,1) PRIMARY KEY,
    post_id INT NOT NULL,
    media_type NVARCHAR(10) CHECK (media_type IN ('image', 'video')) NOT NULL,
    media_url NVARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id) ON DELETE CASCADE
);




INSERT INTO Users (username, password_hash, email) VALUES 
('user1', 'hashed_password1', 'user1@example.com'),
('user2', 'hashed_password2', 'user2@example.com');

INSERT INTO Categories (name) VALUES 
('Technology'),
('Health'),
('Travel');

INSERT INTO Posts (user_id, category_id, title, content) VALUES 
(1, 1, 'First Post', 'This is the content of the first post.'),
(2, 2, 'Second Post', 'This is the content of the second post.');

INSERT INTO Media (post_id, media_type, media_url) VALUES 
(1, 'image', 'http://example.com/image1.jpg'),
(2, 'video', 'http://example.com/video1.mp4');

SELECT * FROM Users;
SELECT * FROM Categories;
SELECT * FROM Posts;
SELECT * FROM Media;

SELECT * FROM Users WHERE user_id = 1;
