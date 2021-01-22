## Raw Minirhizotron Data QA/QC Checks
## Loads raw data combined into single file.
## Checks for duplicate observations and wildly outrageous values.

library(tidyverse)

## Make a function to check for duplicate observation identifiers
## Prints a message if duplicate observations are detected
## Returns a data frame without duplicate observations regardless

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

## Check range of values for 'Alive', 'Dead', 'Gone'
## What are maximum acceptable root lengths within a location?
## If length is too long presumably SA, Volume, AvgDiam are also questionable
no_dupes %>% 
  select(AliveLength_mm, DeadLength_mm, GoneLength_mm) %>% 
  summary()

no_dupes %>% 
  filter(AliveLength_mm > 40) %>% # ~3x the diagonal viewing window
  write_csv("QAQC_intermediates/Alive_over_40mm.csv")
## send these data to Stacy to check if digitized values are correct

# no_dupes %>% 
#   filter(AliveLength_mm > 28.3)# ~2x the diagonal viewing window
