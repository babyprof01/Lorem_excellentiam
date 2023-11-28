#Loading the required libraries to be used
library(readxl)
library(tidyverse)
library(lubridate)
library(openxlsx)

Adults_register_for_AI_competition <- read_excel("Copy of Adults_register_for_AI_competition(59).xlsx", sheet = 2)
head(Adults_register_for_AI_competition)
View(Adults_register_for_AI_competition)

#Data Cleaning
# Check for missing values in all columns
na_counts <- colSums(is.na(Adults_register_for_AI_competition))
# Print the result
print(na_counts)
# Remove duplicate rows
Adults_register_for_AI_competition <- distinct(Adults_register_for_AI_competition)
# Print the result
print(Adults_register_for_AI_competition)
View(Adults_register_for_AI_competition)

#Data wrangling
#rename columns
Adults_register_for_AI_competition <- Adults_register_for_AI_competition %>% 
  rename(adult_id = `adult/id`, 
         adult_ticket_no = `adult_ticket_order_number`, 
         Number_of_children_registered = `adult/children_no`, 
         adult_id_date = `adult/createdAt`, 
         adult_id_updated_date = `adult/updatedAt`,
         is_owner = `isOwner`) %>% 
  rename_with(tolower, everything())
colnames(Adults_register_for_AI_competition)


library(lubridate)
# Assuming adult_id_date is in the format "2023-07-20T14:46:59.000Z"
Adults_register_for_AI_competition <- Adults_register_for_AI_competition %>%
  mutate(adult_id_date = ymd_hms(adult_id_date),  # Parse the date-time column
          date = as.Date(adult_id_date),           # Extract the date
          time = format(adult_id_date, "%H:%M:%S"))  # Extract the time

# Print the result
View(Adults_register_for_AI_competition)

Adults_register_for_AI_competition <- Adults_register_for_AI_competition %>%
  mutate(adult_id_updated_date = ymd_hms(adult_id_date),  # Parse the date-time column
         updated_date = as.Date(adult_id_date),           # Extract the date
         updated_time = format(adult_id_date, "%H:%M:%S"))  # Extract the time
View(Adults_register_for_AI_competition)


# Write the data to an Excel file
write.xlsx(Adults_register_for_AI_competition, "Adults_register_cleaned_data.xlsx", rowNames = FALSE)
