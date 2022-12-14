CREATE DATABASE IF NOT EXISTS usof;
USE usof;

-- TO RESET DATABASE UNCOMMENT COMMENTED ROWS AND EXECUTE SCRIPT

-- SET foreign_key_checks = 0;
-- DROP TABLE IF EXISTS users;
-- DROP TABLE IF EXISTS roles;
-- DROP TABLE IF EXISTS posts;
-- DROP TABLE IF EXISTS categories;
-- DROP TABLE IF EXISTS post_categories;
-- DROP TABLE IF EXISTS comments;
-- DROP TABLE IF EXISTS posts_likes;
-- DROP TABLE IF EXISTS comments_likes;

CREATE TABLE IF NOT EXISTS users(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    login VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    avatar VARCHAR(255) NOT NULL DEFAULT 'avatar.png',
    rating INT NOT NULL DEFAULT 0,
    role ENUM('ADMIN', 'USER') NOT NULL DEFAULT 'USER',
    activated BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE IF NOT EXISTS posts(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    author_id INT,
    title VARCHAR(255) NOT NULL,
    publish_date BIGINT NOT NULL,
    status BOOLEAN NOT NULL DEFAULT false,
    content TEXT NOT NULL,
    content_image TEXT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS categories(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS post_categories(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    post_id BIGINT NOT NUll,
    category_id INT NOT NUll,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS comments(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    author_id INT,
    publish_date BIGINT NOT NULL,
    content TEXT NOT NULL,
    post_id BIGINT,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS posts_likes(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    author_id INT,
    publish_date BIGINT NOT NULL,
    post_id BIGINT NOT NULL,
    type BOOLEAN NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS comments_likes(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    author_id INT,
    publish_date BIGINT NOT NULL,
    comment_id BIGINT NOT NULL,
    type BOOLEAN NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- SET foreign_key_checks = 1;
