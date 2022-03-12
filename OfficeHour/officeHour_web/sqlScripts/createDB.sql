DROP DATABASE IF EXISTS OfficeHour;

CREATE DATABASE OfficeHour;
USE OfficeHour;

CREATE TABLE Users (
	userID INT(11) PRIMARY KEY NOT NULL auto_increment,
	username VARCHAR(45) NOT NULL,
    passwrd INT(11) NOT NULL
);

CREATE TABLE Scores (
	attemptID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    userID INT(11) NOT NULL,
    score INT(20) NOT NULL,
    FOREIGN KEY fk1(userID) REFERENCES Users(userID)
);

/**
CREATE UNIQUE INDEX ID_User
	ON User
    (
**/
