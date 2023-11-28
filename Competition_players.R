#Loading the required libraries to be used
library(readxl) #to read the excel file
library(tidyverse) #for cleaning and manipulation
library(lubridate) #for handling date and time data
library(openxlsx) #to save the cleaned data

#Loading the Copy of Adults_register_for_AI_ competition dataset and resavig it as Adults_register_for_AI_competition
competition_players <- read_excel("Lorem_excellentiam/Lorem_datasets/Copy of competition_players(58).xlsx", sheet = 2)
#Using the summary function to summarize the dataset
summary(competition_players)
View(competition_players)

# Data cleaning
#Checking for missing values in the dataset
na_counts <- colSums(is.na(competition_players))
print(na_counts)

#Removing duplicate entries
competition_players <- distinct(competition_players)
# Printing and viewing the result
#9 duplicates were removed
View(competition_players)

#Removing NA using the child_id column
competition_players <- competition_players[complete.cases(competition_players$child_id), ]
View(competition_players)

#Renaming male and boy with Male; and female and girl with Female in the child/gender column
competition_players <- competition_players %>%
  mutate(`child/gender` = case_when(
    tolower(`child/gender`) %in% c("male", "boy") ~ "Male",
    tolower(`child/gender`) %in% c("female", "girl") ~ "Female",
    TRUE ~ `child/gender`  # Keep other values as is
  ))
#Viewing the dataset
View(competition_players)

#Data wrangling
#Spliting the date and time in child/createdAt into two separate columns
competition_players <- competition_players %>%
  mutate(`child/createdAt` = ymd_hms(`child/createdAt`),  # Parse the date-time column
         date = as.Date(`child/createdAt`),           # Extract the date
         time = format(`child/createdAt`, "%H:%M:%S"))  # Extract the time
# Viewing the dataset
View(competition_players)

#Spliting the date and time in child/updatedAt into two separate columns
competition_players <- competition_players %>%
  mutate(`child/updatedAt` = ymd_hms(`child/updatedAt`),  # Parse the date-time column
         updated_date = as.Date(`child/updatedAt`),           # Extract the date
         updated_time = format(`child/updatedAt`, "%H:%M:%S"))  # Extract the time
#Viewing the dataset
View(competition_players)

# Writing the cleaned data to an Excel file and save
write.xlsx(Adults_register_for_AI_competition, "Adults_register_cleaned_data.xlsx", rowNames = FALSE)