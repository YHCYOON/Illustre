Gallery Table

create table gallery(
	galleryID int,
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
	
	
GalleryLike Table

create table galleryLike(
	userID VARCHAR(20),
	galleryID int);
	
	
GalleryComment Table

create table galleryComment(
	galleryCommentID int,	
	galleryID int,	
	userID VARCHAR(20),
	galleryComment VARCHAR(2048),
	galleryCommentDate DATETIME,
	galleryCommentAvailable int,
	PRIMARY KEY (galleryCommentID));
	
	
	
	
	