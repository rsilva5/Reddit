-- 1: Write queries to select the rows from each table. 
SELECT * FROM users
LIMIT 10;

SELECT * FROM posts
LIMIT 10;

SELECT * FROM subreddits
LIMIT 10;

SELECT subreddit_id, COUNT(*) AS "total"
FROM posts
GROUP BY subreddit_id
ORDER BY 2 DESC;

-- 3: Write a query to count how many different subreddits there are.

SELECT COUNT(*) AS 'subreddit_count'
FROM subreddits;
-- There are 20 different subreddits.

SELECT user_id, score
FROM posts 
ORDER BY score DESC
LIMIT 5;

-- 4: Write a few more queries to figure out the following information: 

-- What user has the highest score?
SELECT id, username, score
FROM users 
ORDER BY score DESC 
LIMIT 1; 
-- The username that has the highest score is ctills1w

-- What post has the highest score?
SELECT title, score 
FROM posts 
ORDER BY score DESC 
LIMIT 5;
-- The posts with the highest score is Picture of a kitten 

-- What are the top 5 subreddits with the highest subscriber_count?
SELECT name, subscriber_count
FROM subreddits 
ORDER BY subscriber_count DESC
LIMIT 5;
-- The top 5 subreddits with the highest subscriber_count are AskReddit, gaming, aww, pics, and science 

-- 5: Now let’s join the data from the different tables to find out some more information.

SELECT users.username, COUNT(posts.id) AS 'posts_made'
FROM users 
LEFT JOIN posts 
  ON users.id = posts.user_id 
GROUP BY users.id
ORDER BY 2 DESC;

-- 6: Over time, posts may be removed and users might delete their accounts. We only want to see existing posts where the users are still active

SELECT *
FROM posts
INNER JOIN users
  ON posts.user_id = users.id;

-- 7: Some new posts have been added to Reddit! Stack the new posts2 table under the existing posts table to see them.

SELECT * FROM posts2
UNION 
SELECT * FROM posts;

-- 8: Now you need to find out which subreddits have the most popular posts. We’ll say that a post is popular if it has a score of at least 5000. 
WITH popular_posts AS (
  SELECT *
  FROM posts
  WHERE score >= 5000
)
SELECT subreddits.name, popular_posts.score, popular_posts.title
FROM subreddits
INNER JOIN popular_posts
  ON subreddits.id = popular_posts.subreddit_id
ORDER BY popular_posts.score DESC
LIMIT 5;

SELECT posts.score, posts.title, subreddits.name
FROM posts
INNER JOIN subreddits 
  ON posts.subreddit_id = subreddits.id
WHERE posts.score >=5000
ORDER BY posts.score DESC
LIMIT 5;

-- 9: Next, you need to find out the highest scoring post for each subreddit.

SELECT 
  posts.title, 
  subreddits.name AS 'subreddit_name', 
  MAX(score) AS 'highest_score'
FROM posts
INNER JOIN subreddits
  ON posts.subreddit_id = subreddits.id
GROUP BY subreddits.id
ORDER BY 3 DESC;

-- 10: Finally, you need to write a query to calculate the average score of all the posts for each subreddit.

SELECT 
  subreddits.id, 
  AVG(posts.score) AS 'average_score'
FROM subreddits
INNER JOIN posts
GROUP BY subreddits.name
ORDER BY 2 DESC;

SELECT subreddit_id, title, COUNT(*) AS "total"
FROM posts
GROUP BY subreddit_id
ORDER BY 3 DESC;
