# App Store Analysis

## Table of Contents
* [Introduction](#introduction)
* [Data Review](#data-review)
* [SQL Exploration](#sql-exploration)
* [Tableau Dashboard](#tab;eau=dashboard)
* [Conclusion](#conclusion)

## Introduction

In this project, we will be using SQL to do data analysis on a dataset that contains information from the iOS app store. In this analysis, we will be identifying a stakeholder, who is an aspiring app developer who wants to create an app that stands out from the rest on the app store. To do so, he needs data-related insights. So, we will be targeting our analysis towards this goal. The questions we will be attempting to answer in our data analysis are: What app categories are the most popular, what price should the app be set at, how can user reviews be maximized, is there a relationship between description length and user rating, and is there a relationship between supported languages and user rating. In the end, we will be creating a tableau dashboard to visualize our findings.

## Data Review

The data used in the project was sourced from [Kaggle](https://www.kaggle.com/datasets/ramamet4/app-store-apple-data-set-10k-apps), which includes information from the iOS app store. This data set contains more than 7000 Apple iOS mobile application details.

There were two files used from the Kaggle dataset. The first of which is [AppleStore.xlsm](https://github.com/jidafan/App-Store-SQL-Analysis/blob/main/Data/AppleStore.xlsm). The file contains 16 variables and information on 7197 apps in the iOS store.

| Variable      | Description           | 
| ------------- |:---------------------| 
| `id`     | The unique id that belongs to the app |
| `track_name`     | The name of the app     |   
| `size_bytes` | The file size of the app in bytes                                        |
| `currency`  | The type of currency needed                              |
| `price`  | The amount of money the app costs                     |
| `rating_count_tot`  | The total amount of reviews for the app for all versions                            |
| `rating_count_ver`  | The total amount of reviews for the app for the current version                                 |
| `user_rating`  | The average user rating for the app for all versions                           |
| `user_rating_ver`  | The average user rating for the app for the current version                                   |
| `ver`  | The latest version code for the app                                      |
| `cont_rating` | The content rating the app falls under                                   |
| `prime_genre`  | The primary genre that the app falls under                            |
| `price`  | The amount of money the app costs                     |
| `sub_devices.num`  | Number of supported devices for the app                          |
| `ipadSc_urls.num`  | Number of screenshots shown on the page for display                           |
| `lang.num`  | Number of supported languages for the app                  |
| `vpp_lic`  | Boolean variable showing whether or not VPP licensing is enabled or not                            |

The second and last file that this program will be using is [appleStore_description.xlsm](https://github.com/jidafan/App-Store-SQL-Analysis/blob/main/Data/appleStore_description.xlsm). The file contains 4 variables and information on 7197 apps in the iOS store.

| Variable      | Description           | 
| ------------- |:---------------------| 
| `id`     | The unique id that belongs to the app |
| `track_name`     | The name of the app     |   
| `size_bytes` | The file size of the app in bytes                                        |
| `app_desc`  | The description of the app present on the page on the iOS store                   |

## SQL Exploration
To view the full SQL code for this project, [click here](https://github.com/jidafan/App-Store-SQL-Analysis/blob/main/AppStore.sql).

The code exploration will be split into two parts, one showing the exploratory data analysis that was performed, and the other showing the data analysis process.

### Exploratory Data Analysis

In this section, we will be performing exploratory data analysis, which will help us identify errors, understand patterns, find anomalous data, and find interesting relations between variables.

**Counting the apps in the data set**
```sql
SELECT COUNT(DISTINCT id) as UniqueAppIDs
From [Portfolio Project]..AppleStore

SELECT COUNT(DISTINCT id) as UniqueAppIDs
From [Portfolio Project]..appleStore_descriptions
```
The number of apps is the same for both tables, so the tables do not have any missing rows.

**Checking for missing values in the data set**
```sql
SELECT COUNT(*) AS MissingValues
FROM [Portfolio Project]..AppleStore
WHERE track_name IS NULL OR user_rating IS NULL OR prime_genre IS NULL

SELECT COUNT(*) AS MissingValues
FROM [Portfolio Project]..appleStore_descriptions
WHERE app_desc is NULL
```
There were no missing values in either table, so we do not need to clean the data and remove rows

**Finding the distribution of apps per genre**
```sql
SELECT prime_genre, COUNT(*) AS NumApps
FROM [Portfolio Project]..AppleStore
GROUP BY prime_genre
ORDER BY NumApps DESC
```
![image](https://github.com/jidafan/App-Store-SQL-Analysis/assets/141703009/53eaaed9-c772-456d-a6f9-037ea92c5edf)

**Finding the min, max and average rating**
```sql
SELECT min(user_rating) as MinRating,
	   max(user_rating) as MaxRating,
	   avg(user_rating) as AvgRating
From [Portfolio Project]..AppleStore
```
![image](https://github.com/jidafan/App-Store-SQL-Analysis/assets/141703009/c7f7f9e7-487b-467f-aae3-f7d3d28664a7)

**Finding the distribution of apps per price range**
```sql
SELECT
	(price / 2) *2 AS PriceBinStart,
	((price /2 ) *2) +2 As PriceBinEnd,
	COUNT(*) AS NumApps
From [Portfolio Project]..AppleStore

Group BY (price / 2) *2 
Order BY PriceBinStart
```
![image](https://github.com/jidafan/App-Store-SQL-Analysis/assets/141703009/2dbb9918-a835-4e05-bafc-7fac751047ca)

### Data Analysis 

In this section, we will perform data analysis, which we will use to answer the questions posed in the introduction and help our shareholder develop his app.

**Determine whether paid apps have higher ratings than free apps**
```sql
SELECT CASE
		WHEN price > 0 THEN 'PAID'
		ELSE 'FREE'
       END AS App_Type,
		avg(user_rating) as Avg_Rating
From [Portfolio Project]..AppleStore
GROUP BY CASE
		WHEN price > 0 THEN 'PAID'
		ELSE 'FREE'
         END

```
![image](https://github.com/jidafan/App-Store-SQL-Analysis/assets/141703009/2700d63e-f526-483f-83d4-2313b7f9a18f)

We see here that paid apps generally have a higher user rating than free apps

**Check whether supported languages influence user ratings**
```sql
ELECT CASE
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
```
![image](https://github.com/jidafan/App-Store-SQL-Analysis/assets/141703009/b17d4854-6a77-459a-8231-0a91493ec8f8)

Executing this code shows that apps with 10-30 languages supported have higher user ratings.

**Checking the 10 genres with the lowest ratings**
```sql
SELECT TOP 10 prime_genre,
	   avg(user_rating) as Avg_Rating
From [Portfolio Project]..AppleStore
Group By prime_genre
Order By Avg_Rating ASC
```
![image](https://github.com/jidafan/App-Store-SQL-Analysis/assets/141703009/603fd2ca-5a00-4325-a0bc-2028f4b9b809)

**Seeing if there is a correlation with length of description and rating**
```sql
SELECT CASE
		WHEN len(b.app_desc) <500 THEN 'Short'
		WHEN len(b.app_desc) BETWEEN 500 AND 1000 THEN 'Medium'
		ELSE 'Long'
	   END AS description_length_bucket,
	   avg(a.user_rating) AS average_rating
FROM [Portfolio Project]..AppleStore AS A
JOIN
		[Portfolio Project]..appleStore_descriptions as b
ON
		a.id = b.id

GROUP BY CASE
			WHEN len(b.app_desc) <500 THEN 'Short'
			WHEN len(b.app_desc) BETWEEN 500 AND 1000 THEN 'Medium'
			ELSE 'Long'
	     END
ORDER BY average_rating DESC
```
![image](https://github.com/jidafan/App-Store-SQL-Analysis/assets/141703009/69331c01-f358-4b35-a497-1cba8db125a5)

We see that apps with a description above 1000 words have a higher rating on average compared to those with lesser word counts

**Checking the top 10 apps for each genre**
```sql
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
			FROM [Portfolio Project]..AppleStore
	)AS A
WHERE
a.rank = 1
```
![image](https://github.com/jidafan/App-Store-SQL-Analysis/assets/141703009/2cabd416-7985-4386-83b4-17e1864b78ec)

## Tableau Dashboard

To view the full dashboard for this project, click [here](https://public.tableau.com/app/profile/scott.duong8287/viz/AppStore_17001998317110/Dashboard2?publish=yes)

![image](https://github.com/jidafan/App-Store-SQL-Analysis/assets/141703009/1dcb20c4-5f85-49a3-b960-6218111fe3ac)


## Conclusion

Yep
