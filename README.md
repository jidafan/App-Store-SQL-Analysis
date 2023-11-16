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
