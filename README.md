# App Store Analysis

## Table of Contents
* [Introduction](#introduction)
* [Data Review](#data-review)
* [SQL Exploration](#sql-exploration)
* [Tableau Dashboard](#tab;eau=dashboard)

## Introduction

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
