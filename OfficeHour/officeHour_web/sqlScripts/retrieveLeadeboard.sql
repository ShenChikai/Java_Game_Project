USE OfficeHour;

SELECT s.attemptID, s.userID, u.username, s.score
	FROM Scores s
	RIGHT JOIN Users u ON s.userID = u.userID
	ORDER BY score DESC;