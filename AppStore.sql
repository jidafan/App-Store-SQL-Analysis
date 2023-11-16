-- Check the number of unique apps in both tables
SELECT COUNT(DISTINCT id) as UniqueAppIDs
From AppleStore

SELECT COUNT(DISTINCT id) as UniqueAppIDs
From appleStore_descriptions

-- Check for any missing values in key fields

SELECT COUNT(*) AS MissingValues
FROM AppleStore
WHERE track_name IS NULL OR user_rating IS NULL OR prime_genre IS NULL

SELECT COUNT(*) AS MissingValues
FROM appleStore_descriptions
WHERE app_desc is NULL

-- Find out the number of apps per genre

SELECT prime_genre, COUNT(*) AS NumApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApps DESC

-- Get an overview of the apps' ratings

SELECT min(user_rating) as MinRating,
	   max(user_rating) as MaxRating,
	   avg(user_rating) as AvgRating
From AppleStore

-- Get the distribution of app prices

SELECT
	(price / 2) *2 AS PriceBinStart,
	((price /2 ) *2) +2 As PriceBinEnd,
	COUNT(*) AS NumApps
From AppleStore

Group BY (price / 2) *2 
Order BY PriceBinStart

-- Data Analysis 

-- Determine whether paid apps have higher ratings than free apps

SELECT CASE
			WHEN price > 0 THEN 'PAID'
			ELSE 'FREE'
		END AS App_Type,
		avg(user_rating) as Avg_Rating
From AppleStore
GROUP BY CASE
			WHEN price > 0 THEN 'PAID'
			ELSE 'FREE'
		 END

-- Check if apps with more supported languages have higher ratings

SELECT CASE
			WHEN lang_num < 10 THEN '<10 languages'
			WHEN lang_num BETWEEN 10 AND 30 THEN '10-30 languages'
			ELSE '>30 languages'
		END AS language_bucket,
		avg(user_rating) as Avg_Rating
From AppleStore
GROUP BY CASE
			WHEN lang_num < 10 THEN '<10 languages'
			WHEN lang_num BETWEEN 10 AND 30 THEN '10-30 languages'
			ELSE '>30 languages'
		END 
ORDER BY Avg_Rating DESC

-- Check genres with low ratings

SELECT TOP 10 prime_genre,
	   avg(user_rating) as Avg_Rating
From AppleStore
Group By prime_genre
Order By Avg_Rating ASC

-- Check if there is correlation between the length of app description and rating

SELECT CASE
		WHEN len(b.app_desc) <500 THEN 'Short'
		WHEN len(b.app_desc) BETWEEN 500 AND 1000 THEN 'Medium'
		ELSE 'Long'
	   END AS description_length_bucket,
	   avg(a.user_rating) AS average_rating
FROM AppleStore AS A
JOIN
		appleStore_descriptions as b
ON
		a.id = b.id

GROUP BY CASE
			WHEN len(b.app_desc) <500 THEN 'Short'
			WHEN len(b.app_desc) BETWEEN 500 AND 1000 THEN 'Medium'
			ELSE 'Long'
	     END
ORDER BY average_rating DESC

-- Check the top rated apps for each genre

SELECT
	prime_genre,
	track_name,
	user_rating
FROM (
			SELECT
			prime_genre,
			track_name,
			user_rating,
			RANK() OVER(PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) AS RANK
			FROM AppleStore
	)AS A
WHERE
a.rank = 1

