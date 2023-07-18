#Rewarding Most Loyal User 

SELECT username, id, created_at
FROM ig_clone.users
ORDER BY created_at;

#Reminding inactive users to start posting 

SELECT username
FROM ig_clone.users
LEFT JOIN ig_clone.photos
ON users.id=photos.user_id
WHILE photos.user_id is null
ORDER BY username;

#Declaring Contest Winner 

SELECT username, photo_id, count(likes.user_id) as t_likes
FROM ig_clone.likes
JOIN ig_clone.photos
ON likes.photo_id=photos.id
JOIN ig_clone.users
ON photos.user_id=users.id
GROUP BY likes.photo_id,users.username
ORDER BY t_likes DESC
LIMIT 1;

#Hashtag Researching 

SELECT tag_id, tag_name
COUNT(*) AS tagcount
FROM ig_clone.photo_tags
JOIN ig_clone.tags
ON photo_tags.tag_id=tags.id
GROUP BY tag_name
ORDER BY tagcount DESC
LIMIT 1;

#Launch AD Campaign

SELECT id,username,created_at,DAYNAME(created_at) AS weekday,COUNT(*) AS totalcount
FROM ig_clone.users
GROUP BY 1
ORDER BY 2 DESC;

#Users Engagement 

WITH CTE AS (
SELECT users.id AS u_id, COUNT(photos.is) as p_id
FROM ig_clone.users 
LEFT JOIN ig_clone.photos
ON users.id=photos.user_id
GROUP BY users.id
)
SELECT SUM(p_id)/COUNT(u_id)
FROM CTE WHERE p_id>0;

#Bots And Fake Accounts

SELECT username,COUNT(*) AS num_likes
FROM ig_clone.users
INNER JOIN ig_clone.likes
ON users.id=likes.user_id
GROUP BY likes.user_id
HAVING num_likes=(SELECT COUNT(*) FROM ig_clone.photos)

