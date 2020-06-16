DROP DATABASE IF EXISTS my_at;
CREATE DATABASE my_at;
USE my_at;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    username VARCHAR(250),
    email VARCHAR(120) UNIQUE,
    phone BIGINT,
    isDeleted BIT DEFAULT 0,

    INDEX users_name_idx(username)
);

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
    user_id SERIAL PRIMARY KEY,
    gender BIT,
    birthday DATE,
	photo_id BIGINT UNSIGNED DEFAULT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW(),

    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS books;
CREATE TABLE books(
    id SERIAL PRIMARY KEY,
    name varchar(100),
    series_name varchar(200),
    author_1_id BIGINT UNSIGNED NOT NULL,
    author_1_name VARCHAR(200) NOT NULL,
    author_2_id BIGINT UNSIGNED DEFAULT NULL,
    author_2_name VARCHAR(200) DEFAULT NULL,
    author_3_id BIGINT UNSIGNED DEFAULT NULL,
    author_3_name VARCHAR(200) DEFAULT NULL,
    cover_pic_id BIGINT UNSIGNED DEFAULT NULL,
    annotation TEXT,
    isDeleted BIT DEFAULT 0,

    FOREIGN KEY (author_1_id) REFERENCES users(id),
    FOREIGN KEY (author_1_name) REFERENCES users(username),
    FOREIGN KEY (author_2_id) REFERENCES users(id),
    FOREIGN KEY (author_2_name) REFERENCES users(username),
    FOREIGN KEY (author_3_id) REFERENCES users(id),
    FOREIGN KEY (author_3_name) REFERENCES users(username),

    INDEX bookname_idx(name),
    INDEX author1_idx(author_1_name),
    INDEX author2_idx(author_2_name),
    INDEX author3_idx(author_3_name)
);

DROP TABLE IF EXISTS chapters;
CREATE TABLE chapters(
    id SERIAL PRIMARY KEY,
    chapter_name VARCHAR(100) NOT NULL,
    book_id BIGINT UNSIGNED NOT NULL,
    content LONGTEXT,
    num_symbols BIGINT NOT NULL,
    isDeleted BIT DEFAULT 0,
    
    FOREIGN KEY (book_id) REFERENCES books(id)
);

DROP TABLE IF EXISTS comments;
CREATE TABLE comments(
    id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    book_id BIGINT UNSIGNED NOT NULL,
    content TEXT,
    isDeleted BIT DEFAULT 0,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

DROP TABLE IF EXISTS rewards; -- Награды в АТ - своего рода пожертвования с пояснительной запиской, например, "спасибо за книгу", "ждём продолжение" итд.
CREATE TABLE rewards(
    id SERIAL PRIMARY KEY,
    value INT COMMENT 'сумма награды в рублях',
    book_id BIGINT UNSIGNED NOT NULL,
    author_id BIGINT UNSIGNED NOT NULL,
    reward_name VARCHAR(150) COMMENT 'название награды'
);

DROP TABLE IF EXISTS likes_books;
CREATE TABLE likes_books(
    id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    book_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (user_id, book_id),

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

DROP TABLE IF EXISTS likes_comments;
CREATE TABLE likes_comments(
    id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    comment_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (user_id, comment_id),

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (comment_id) REFERENCES comments(id)
);