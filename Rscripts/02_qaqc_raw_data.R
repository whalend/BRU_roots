## Raw Minirhizotron Data QA/QC Checks
## Loads raw data combined into single file ('Rscripts/01_combine_raw_data.R')
## Checks for duplicate observations and wildly outrageous values.

library(tidyverse)
library(readxl)
# source("Rscripts/01_combine_raw_data.R")# outputs file at directory below
df <- read_csv("data/raw_data/all_raw_observations.csv")

## Make a function to check for duplicate observation identifiers
## Prints a message indicating whether duplicate observations are detected
## The function takes a data frame and a directory path for writing the file
dupe_check <- function(df, write_path){
  ## Create data frame of duplicated observations
  dup_oid = df %>% 
    filter(duplicated(obs_ID)) %>% 
    select(obs_ID) 
  if (nrow(dup_oid)==0) {
    print("No duplicate observations")
  }
  else {
    ## Write data frame of duplicated observations to file
    df %>% filter(obs_ID %in% dup_oid$obs_ID) %>% 
      write_csv(paste0(write_path, "duped_observations_", Sys.Date(), ".csv"))
    print("Duplicate observations detected! Check 'duped_observations.csv'")
  }
  
  ## Exclude any duplicated observations from the data
  # df = df %>%
  #   filter(!obs_ID%in%dup_oid$obs_ID)
  
  # return(df)
}

w_path <- "QAQC_intermediates/"
dupe_check(df, w_path)
## Send file of detected duplicates to Stacy for heads-up checking of photos

## Load checked duplicates file from Stacy
## Downloaded from Teams
## 2021-01-25
del_dupes <- read_csv("QAQC_intermediates/duped_observations_SAScomments.csv")
## Check 'notes' values to clue in on anything other than deleting rows
unique(del_dupes$notes)
# [3] "need to change data due to reconnecting broken segment link"
## deal with this one next

## Filter to only the rows that need deleted
del_dupes <- del_dupes %>% 
  filter(notes == "delete") %>% 
  select(-"notes")

## Keep only the 'good' rows
df <- anti_join(df, del_dupes)

## Now should have no more duplicate observations
dupe_check(df)


## Correct data for observations ####
## One note: [3] "need to change data due to reconnecting broken segment link"
## Stacy made a file with the correct data
correct_data <- read_xlsx("QAQC_intermediates/correct data for root 6_16_30_R16.xlsx", sheet = 1) %>% 
  select(-notes)

df <- df %>% 
  # First delete the observation(s)
  filter(!obs_ID %in% correct_data$obs_ID) %>% 
  # Then add the correct data
  union_all(., correct_data)

dupe_check(df)

## Check range of values for 'Alive', 'Dead', 'Gone'
## What are maximum acceptable root lengths within a location?
## If length is too long presumably SA, Volume, AvgDiam are also questionable
df %>% 
  select(AliveLength_mm, DeadLength_mm, GoneLength_mm) %>% 
  summary()

df %>% 
  filter(AliveLength_mm > 40) %>% # ~3x the diagonal viewing window
  write_csv(paste0(w_path, "Alive_over_40mm", Sys.Date(), ".csv"))
## send these data to Stacy to check if digitized values are correct


