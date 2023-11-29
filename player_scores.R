#Loading the required libraries to be used
library(readxl) #to read the excel file
library(tidyverse) #for cleaning and manipulation
library(openxlsx) #to save the cleaned data

#Loading the Copy of Adults_register_for_AI_ competition dataset and resavig it as Adults_register_for_AI_competition
player_scores <- read_excel("Lorem_excellentiam/Lorem_datasets/Copy of player_scores(60).xlsx")
#Using the summary function to summarize the dataset
summary(player_scores)
View(player_scores)

# Data cleaning
#Checking for missing values in the dataset
na_counts <- colSums(is.na(player_scores))
print(na_counts)

#Removing duplicate entries
player_scores <- distinct(player_scores)
# Printing and viewing the result
#9 duplicates were removed
View(player_scores)

# Writing the cleaned data to an Excel file and save
write.xlsx(player_scores, "player_scores_cleaned_data.xlsx", rowNames = FALSE)
