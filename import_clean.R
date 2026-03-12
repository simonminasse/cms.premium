library(tidyverse)
library("readxl")

# Import Excel workbook
premiums <- read_excel("/Users/simonminasse/Documents/Data/CMS Program Statistics - Medicare Premiums/2023/MDCR PREMIUMS_CPS04PRM_2023.xlsx")

# Define file path
path <- "/Users/simonminasse/Documents/Data/CMS Program Statistics - Medicare Premiums/2023/MDCR PREMIUMS_CPS04PRM_2023.xlsx"

# Get all sheet names from the workbook
premiums <- excel_sheets(path = path); premiums

# Read all sheets into a list of data frames
df_list2 <- excel_sheets(path) %>% 
  set_names() %>% # Use sheet names as list names
  map(~ read_excel(path = path, sheet = .x, col_names = TRUE, skip = 3)) # NOTE: changing skip number for this sheet

# getting medicare premium part B demographic info 
# selecting only needed rows (removing blank rows and caption rows)
partB_demog <- df_list2$`MDCR PREMIUMS 5_CPS_04PRM`[c(2,5,6,8:17,20,21,24:30,33,34),]

# exporting dataset as csv to use in Tableau
write_csv(partB_demog, "/Users/simonminasse/Documents/Data/CMS_Data/partB_demog.csv")
