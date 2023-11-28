#Loading the required libraries to be used
library(readxl) #to read the excel file
library(tidyverse) #for cleaning and manipulation
library(lubridate) #for handling date and time data
library(openxlsx) #to save the cleaned data

#Loading the Copy of Adults_register_for_AI_ competition dataset and resavig it as Adults_register_for_AI_competition
Adults_register_for_AI_competition <- read_excel("Copy of Adults_register_for_AI_competition(59).xlsx", sheet = 2)
head(Adults_register_for_AI_competition)
View(Adults_register_for_AI_competition)

#Data Cleaning
# Checking for missing values in all columns
na_counts <- colSums(is.na(Adults_register_for_AI_competition))
# Printing the result f total missing values.
# detected a total of 250 values missing
print(na_counts)

# Remove duplicate rows
Adults_register_for_AI_competition <- distinct(Adults_register_for_AI_competition)
# Printing and viewing the result
#39 duplicates were removed
print(Adults_register_for_AI_competition)
View(Adults_register_for_AI_competition)

#Data wrangling
#renaming columns to shorten their names, and formatting all to small letters
Adults_register_for_AI_competition <- Adults_register_for_AI_competition %>% 
  rename(adult_id = `adult/id`, 
         adult_ticket_no = `adult_ticket_order_number`, 
         Number_of_children_registered = `adult/children_no`, 
         adult_id_date = `adult/createdAt`, 
         adult_id_updated_date = `adult/updatedAt`,
         is_owner = `isOwner`) %>% 
  rename_with(tolower, everything())
# Checking if columns have been renamed
colnames(Adults_register_for_AI_competition)

#Spliting the date and time in adult_id_date into two separate columns
Adults_register_for_AI_competition <- Adults_register_for_AI_competition %>%
  mutate(adult_id_date = ymd_hms(adult_id_date),  # Parse the date-time column
          date = as.Date(adult_id_date),           # Extract the date
          time = format(adult_id_date, "%H:%M:%S"))  # Extract the time
# Viewing the dataset
View(Adults_register_for_AI_competition)

#Spliting the date and time in adult_id_updated_date into two separate columns
Adults_register_for_AI_competition <- Adults_register_for_AI_competition %>%
  mutate(adult_id_updated_date = ymd_hms(adult_id_date),  # Parse the date-time column
         updated_date = as.Date(adult_id_date),           # Extract the date
         updated_time = format(adult_id_date, "%H:%M:%S"))  # Extract the time
#Viewing the dataset
View(Adults_register_for_AI_competition)


# Write the data to an Excel file and save
write.xlsx(Adults_register_for_AI_competition, "Adults_register_cleaned_data.xlsx", rowNames = FALSE)
