DROP DATABASE IF EXISTS my_at;
CREATE DATABASE my_at;
USE my_at;

DROP DATABASE IF EXISTS users;
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(100),
    lastname VARCHAR(100) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE,
    phone BIGINT,

    INDEX users_firstname_lastname_idx(firstname, lastname)
);