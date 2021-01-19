## Raw Minirhizotron Data QA/QC Checks
## Loads raw data combined into single file.
## Checks for duplicate observations and wildly outrageous values.

library(tidyverse)

df <- read_csv("raw_data/all_raw_observations.csv")
# source("Rscripts/01_combine_raw_data.R")

## Check for duplicate observation identifiers
dupe_check <- function(df){
  ## Create data frame of duplicated observations
  dup_oid = df %>% filter(duplicated(obs_ID)) %>% 
    select(obs_ID) 
  if (nrow(dup_oid)==0) {
    print("No duplicate observations")
  }
  else {
    ## Write data frame of duplicated observations to file
    df %>% filter(obs_ID%in%dup_oid$obs_ID) %>% 
      write_csv("QAQC_intermediates/duped_observations.csv")
    print("Duplicate observations detected! Check 'duped_observations.csv'")
  }
  
  ## Exclude any duplicated observations from the data
  df = df %>%
    filter(!obs_ID%in%dup_oid$obs_ID)
  
  return(df)
}

no_dupes <- dupe_check(df)

## 
