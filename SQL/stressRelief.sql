-- Checks if table already exists
DROP TABLE IF EXISTS user_activity;
DROP TABLE IF EXISTS fidget_toys;
DROP TABLE IF EXISTS users;




CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    registration_date DATETIME NOT NULL
);


CREATE TABLE fidget_toys (
    toy_id INT PRIMARY KEY AUTO_INCREMENT,
    toy_name VARCHAR(255) NOT NULL,
    description TEXT,
    toy_type ENUM('Fidget Spinner', 'Coloring Page', 'Color-Changing Page') NOT NULL
);


CREATE TABLE user_activity (
    activity_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    toy_id INT,
    start_time DATETIME NOT NULL,
    end_time DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (toy_id) REFERENCES fidget_toys(toy_id)
);



INSERT INTO users (username, email, password_hash, registration_date)
VALUES ('john_doe', 'john.doe@email.com', 'hashed_password', '2023-10-31 08:00:00');

INSERT INTO users (username, email, password_hash, registration_date)
VALUES ('jane_smith', 'jane.smith@email.com', 'hashed_password', '2023-10-31 09:15:00');




INSERT INTO fidget_toys (toy_name, description, toy_type)
VALUES ('Fidget Spinner', 'A spinning toy to relieve stress and anxiety', 'Fidget Spinner');

INSERT INTO fidget_toys (toy_name, description, toy_type)
VALUES ('Coloring Page', 'A relaxing coloring page for creativity', 'Coloring Page');

INSERT INTO fidget_toys (toy_name, description, toy_type)
VALUES ('Color-Changing Page', 'A page with color-changing effects to reduce stress', 'Color-Changing Page');




INSERT INTO user_activity (user_id, toy_id, start_time, end_time)
VALUES (1, 1, '2023-10-31 10:00:00', '2023-10-31 10:15:00');

INSERT INTO user_activity (user_id, toy_id, start_time, end_time)
VALUES (2, 2, '2023-10-31 11:30:00', '2023-10-31 12:00:00');
