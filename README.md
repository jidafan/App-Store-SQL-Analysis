# App Store Analysis

## Table of Contents
* [Introduction](#introduction)
* [Data Review](#data-review)
* [SQL Exploration](#sql-exploration)
* [Tableau Dashboard](#tab;eau=dashboard)

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

## Code Exploration
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
