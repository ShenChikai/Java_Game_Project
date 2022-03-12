USE OfficeHour;


INSERT INTO Scores (userID, score)
SELECT * FROM (SELECT 3, 0) AS s
WHERE EXISTS (
	SELECT userID FROM Users WHERE userID=3
);