#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from https://usa.ipums.org/
# Author: Kaan Gumrah
# Data: 22 October 2020
# Contact: kaan.gumrah@mail.utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data.
setwd("/Users/kaangumrah/Desktop/ElectionPrediction")
raw_data <- read_dta("inputs/data/usa_00001.dta")


# Add the labels
raw_data <- labelled::to_factor(raw_data)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
reduced_dataPOST <- 
  raw_data %>% 
  select(region,
         stateicp, 
         race, 
         hispan,
         bpl,
         educ,
         educd,)
rm(reduced_data)
         

#### What's next? ####
head(reduced_data)
## Here I am only splitting cells by age, but you 
## can use other variables to split by changing
## count(age) to count(age, sex, ....)

reduced_dataPOST<-
  reduced_dataPOST %>%
  mutate(years_of_schooling = 
            ifelse(educ == "nursery school to grade 4", 2,
            ifelse(educ == "grade 5, 6, 7, or 8", 6,
            ifelse(educ == "grade 9", 9,
            ifelse(educ == "grade 10", 10,
            ifelse(educ == "grade 11", 11,
            ifelse(educ == "grade 12", 12,
            ifelse(educ == "1 year of college", 13,
            ifelse(educ == "2 years of college", 14,
            ifelse(educ == "3 years of college", 15,
            ifelse(educ == "4 years of college", 16,
            ifelse(educ == "5+ years of college", 18,
            ifelse(educd == "doctoral degree", 22, 0)))))))))))))

reduced_dataPOST <-
  reduced_dataPOST %>%
  count(years_of_schooling)%>%
  group_by(years_of_schooling)

reduced_dataPOST$years_of_schooling <- as.integer(reduced_dataPOST$years_of_schooling)

# Saving the census data as a csv file in my
# working directory
write_csv(reduced_dataPOST, "census_data.csv")



         