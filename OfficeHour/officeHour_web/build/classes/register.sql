
INSERT INTO Users (username, passwrd)
SELECT * FROM (SELECT 'Jacob', 2000) AS usr
WHERE NOT EXISTS (
    SELECT username FROM Users WHERE username='Jacob'
);
                
-- SELECT * FROM OfficeHour.Users;
