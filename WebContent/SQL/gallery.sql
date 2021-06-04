GRANT ALL PRIVILEGES ON *.* TO 'yhcyoon'@'localhost' IDENTIFIED BY 'gmlcks5631!';

create database illustre;

use illustre;

create table user(
	userID VARCHAR(20),
	userPassword VARCHAR(20),
	userName VARCHAR(20),
	userNickname VARCHAR(50),
	userEmail VARCHAR(50),
	PRIMARY KEY (userID));

create table gallery(
	galleryID int,
	userID VARCHAR(20),
	userNickname VARCHAR(20),
	galleryCategory VARCHAR(20),
	galleryTitle VARCHAR(50),
	galleryContent VARCHAR(2048),
	galleryDate DATETIME,
	fileName VARCHAR(50),
	fileRealName VARCHAR(50),
	galleryLikeCount int,
	galleryAvailable int,
	PRIMARY KEY (galleryID));
	
create table galleryLike(
	userID VARCHAR(20),
	galleryID int);
	
create table galleryComment(
	galleryCommentID int,	
	galleryID int,	
	userID VARCHAR(20),
	galleryComment VARCHAR(2048),
	galleryCommentDate DATETIME,
	galleryCommentAvailable int,
	PRIMARY KEY (galleryCommentID));
	
CREATE TABLE bbs(
	bbsID INT,
	bbsTitle VARCHAR(50),
	bbsContent VARCHAR(2048),
	userID VARCHAR(20),
	bbsDate DATETIME,
	bbsLikeCount INT,
	bbsAvailable INT,
	PRIMARY KEY (bbsID));
	
CREATE TABLE bbsComment(
	bbsCommentID INT,
	bbsID INT,
	userID VARCHAR(20),
	bbsComment VARCHAR(2048),
	bbsCommentDate DATETIME,
	bbsAvailable INT,
	PRIMARY KEY (bbsCommentID));
	
	
	
	
	