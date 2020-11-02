#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from Democracy Fund + UCLA Nationscape (Full Data Set)
# Author: Kaan Gumrah
# Data: 2 Nov 2020
# Contact: kaan.gumrah@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)

setwd("/Users/kaangumrah/Desktop/ElectionPrediction")
raw_data <- read_dta("inputs/data/ns20200625.dta")


# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables
reduced_dataSurvey <- 
  raw_data %>% 
  select(vote_2020,
         education,
         age)


#### What else???? ####
# Maybe make some age-groups?
# Maybe check the values?
# Is vote a binary? If not, what are you going to do?

reduced_dataSurvey<-
  reduced_dataSurvey %>%
  mutate( DonaldTrumpVote = 
           ifelse(vote_2020=="Donald Trump", 1, 0))

reduced_dataSurvey<-
  reduced_dataSurvey %>%
  mutate(years_of_schooling = 
          ifelse(education == "3rd Grade or less", 2,
          ifelse(education == "Middle School - Grades 4 - 8", 6,
          ifelse(education == "Completed some high school", 10,
          ifelse(education == "High school graduate", 12,
          ifelse(education == "Other post high school vocational training", 12,
          ifelse(education == "Completed some college, but no degree", 14,
          ifelse(education == "Associate Degree", 14,
          ifelse(education == "College Degree (such as B.A., B.S.)", 16,
          ifelse(education == "Completed some graduate, but no degree", 17,
          ifelse(education == "Masters degree", 18,
          ifelse(education == "Doctorate degree", 22, 999999)
          )))))))))))

# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_dataSurvey, "survey_data.csv")

