## Raw Minirhizotron Data QA/QC Checks
## Loads raw data combined into single file ('Rscripts/01_combine_raw_data.R')
## Checks for duplicate observations and extreme values.
## Assessing dupes and extreme values requires heads-up checking of the photos
## and processing - Stacy Smith

library(tidyverse)
library(readxl)

# source("Rscripts/01_combine_raw_data.R")# outputs file at directory below
df <- read_csv("data/raw_data/all_raw_observations.csv", trim_ws = TRUE)

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
    duped = df %>% filter(obs_ID %in% dup_oid$obs_ID) %>% 
      arrange(obs_ID)
    duped %>% 
      write_csv(paste0(write_path, "duped_observations_", Sys.Date(), ".csv"))
    ## Print message informing of duped observations
    print("Duplicate observations detected!")
    print(paste0("Check ", write_path, "duped_observations_", Sys.Date(), 
                 ".csv")
      )
    return(duped)
  }
  
  ## Exclude any duplicated observations from the data
  # df = df %>%
  #   filter(!obs_ID%in%dup_oid$obs_ID)
  
  # return(df)
}

## Munge to 'long' format ####
## Moves 'Alive', 'Dead', 'Gone' to a 'root_status' column, removing these as
## the prefix to the measurements columns.
## Then removes the 0 values in the measurement columns.

## not the most efficient implementation...

## Add root status column: Alive, Dead, Gone measurements
munge_long <- function(df){
  A = df %>% 
    # filter(AliveLength_mm > 0) %>% 
    select(-starts_with("Gone"), -starts_with("Dead")) %>% 
    mutate(root_status = "Alive")
  colnames(A) <- sub(c("Alive"), "", colnames(A))
  
  D = df %>% 
    select(-starts_with("Gone"), -starts_with("Alive")) %>% 
    mutate(root_status = "Dead")
  colnames(D) <- sub(c("Dead"), "", colnames(D))
  
  G = df %>% 
    select(-starts_with("Dead"), -starts_with("Alive")) %>% 
    mutate(root_status = "Gone")
  colnames(G) <- sub(c("Gone"), "", colnames(G))
  
  df = rbind(A,D,G)
  df = df %>% filter(Length_mm > 0)
  rm("A","D","G")
  
  return(df)
}
df <- munge_long(df)

df <- df %>% 
  mutate(rowID = paste0(obs_ID, Length_mm, ProjArea_mm2, SurfArea_mm2,
                        AvgDiam_mm, Volume_mm3, TipDiam, TipLivStatus,
                        HighestOrder, ExtPathLength, Altitude,
                        root_status))

## Check for Duplicated Observation IDs 'obs_ID'
## For 2020 data a root should have only one category
w_path <- "QAQC_intermediates/"
dupes <- dupe_check(df, w_path)
## Send file of detected duplicates to Stacy for heads-up checking of photos


## Make Data Corrections (initial iteration) ####
## Load checked duplicates file from Stacy
## Downloaded from Teams
qaqc_data <- read_xlsx("QAQC_intermediates/QAQC_notes_corr.xlsx", sheet = "original_notes", trim_ws = TRUE)

## Check 'notes' values to clue in on anything other than deleting rows
unique(qaqc_data$note)
# [3] "need to change data due to reconnecting broken segment link"
## deal with this one next

qaqc_data2 <- read_xlsx("QAQC_intermediates/duped_observations_2021-03-05_with_corrections.xlsx", sheet = "corrected data", trim_ws = TRUE)
unique(qaqc_data2$flag)
# view(qaqc_data2)

unique(names(qaqc_data)%in%names(qaqc_data2))

corrections2 <- qaqc_data2 %>% 
  filter(!flag%in%c("ok","delete"))

qaqc_data = qaqc_data %>% 
  rename(flag = note, 
         AvgDiam_mm = AvgDiam_cm,
         TotAvgDiam_mm = TotAvgDiam_cm) %>% 
  mutate(AvgDiam_mm = AvgDiam_mm/10,
         TotAvgDiam_mm = TotAvgDiam_mm/10)
# View(qaqc_data)

unique(names(qaqc_data)%in%names(qaqc_data2))
qaqc_data <- rbind(qaqc_data, qaqc_data2)

## Had a rounding/digits issue crop up in the file transfers/formatting
## of the qaqc_data2 that produced a bunch of trailing 9s for some of
## the AvgDiam_mm values, which messed up the matching for row deletion.
## My solution here is to round at least 'AvgDiam_mm' but perhaps
## numerics in general to fix this potential issue. Then I also add a
## 'rowID' column that is a concatenation of obsID and measurements
## through 'root_status'.

qaqc_data <- qaqc_data %>% 
  mutate(across(.cols = where(is.numeric),
                # rounded to 5 digits b/c raw data but thats a lot
                # of false precision I think
                .fns = ~ round(.x, digits = 5)
                )
         )
# View(qaqc_data)

qaqc_data <- qaqc_data %>% 
  mutate(rowID = paste0(obs_ID, Length_mm, ProjArea_mm2, SurfArea_mm2,
                      AvgDiam_mm, Volume_mm3, TipDiam, TipLivStatus,
                      HighestOrder, ExtPathLength, Altitude,
                      root_status))

## Filter to duped rows that simply need deleted
del_dupes <- qaqc_data %>% 
  filter(flag == "delete") %>% 
  select(-flag)
# view(del_dupes)

## Keep only the 'good' rows
nrow(df) - nrow(del_dupes)
df <- anti_join(df, del_dupes, by = "rowID")# drops rows in 'del_dupes'

# dftmp %>% filter(duplicated(obs_ID)) %>% view
# tmp <- dftmp %>% filter(duplicated(obs_ID))
# dftmp %>% filter(obs_ID%in%tmp$obs_ID) %>% view()


## Correct data for erroneous observations ####
## Stacy made a sheet with corrected data, handling extreme values and any
## errors discovered while checking the duplicated 'obs_ID'
correct_data <- read_xlsx("QAQC_intermediates/QAQC_notes_corr.xlsx", sheet = "corrections")
correct_data <- correct_data %>% 
  select(-corr_date, AvgDiam_mm = AvgDiam_cm, TotAvgDiam_mm = TotAvgDiam_cm) %>% 
  mutate(AvgDiam_mm = AvgDiam_mm/10,
         TotAvgDiam_mm = TotAvgDiam_mm/10)

corrections2
correct_data
correct_data <- rbind(select(corrections2, -flag),
                      correct_data)

df <- df %>% 
  # First delete the observation(s)
  filter(!obs_ID %in% correct_data$obs_ID) %>% 
  # Then add the correct data
  union_all(., correct_data)


## Ultimately should have no more duplicate observations, but this is iterative
## b/c not all data is present yet. Will need to rerun code above when new data
## is added.
dupes <- dupe_check(df, w_path)
dupes
# qaqc_data %>% filter(obs_ID%in%dupes$obs_ID) %>% View

## Check range of values for 'Alive', 'Dead', 'Gone' ####
## What are maximum acceptable root lengths and diameters within a location?
## If length or diameter is too long, SA and Volume are also questionable
summary(df)

df %>% 
  filter(Length_mm > 40) %>% # ~3x the diagonal viewing window
  write_csv(paste0(w_path, "Length_over_40mm", Sys.Date(), ".csv"))
## send these data to Stacy to check if digitized values are correct

df %>% 
  filter(AvgDiam_mm>2) %>% 
  write_csv(paste0(w_path, "AvgDiam_over_2mm", Sys.Date(), ".csv"))


## Add Date formatting ####
df <- df %>% 
  mutate(Date = lubridate::as_date(Date),
         Month = lubridate::month(Date))

## Export Corrected Data ####
# write_csv(df, "data/processed_data/mr_roots_data_corrected.csv")


## Correct Nonsensical Status Changes? ####
## Zombies and Wanderers and Wandering Zombies

## Find status changes
df2 <- df %>% 
  select(root_ID, root_status, Session:DeathSession, Length_mm, Date, obs_ID,
         SampleId) %>% 
  arrange(root_ID, Session) %>% 
  group_by(root_ID) %>% 
  mutate(flag = case_when(
    # captures changing from Dead/Gone to Alive - zombies or wanderers
    root_status %in% c("Dead","Gone") & lead(root_status == "Alive") ~ "bad",
    # also need change from Gone to anything - wanderers
    root_status == "Gone" & lead(root_status %in% c("Alive", "Dead")) ~ "bad",
    TRUE ~ "good"
    ) 
  )

b <- df2 %>% filter(flag=="bad")
b <- b$root_ID

df2 %>% 
  filter(root_ID%in%b) %>% 
  select(flag, everything()) %>% 
  writexl::write_xlsx(., "QAQC_intermediates/zombies_wanderers.xlsx")
  # write_csv(., "QAQC_intermediates/zombies_wanderers.csv")

d <- df2 %>% 
  mutate(root_status = case_when(
    root_status %in% c('Dead', 'Gone') & lead(root_status == 'Alive') ~ 'Alive',
    # also need change from Gone to anything - wanderers
    root_status == 'Gone' & lead(root_status %in% c('Alive', 'Dead')) ~ lead(root_status),
    TRUE ~ root_status
    ),
    flag = case_when(
      # captures changing from Dead/Gone to Alive - zombies or wanderers
      root_status %in% c("Dead","Gone") & lead(root_status == "Alive") ~ "bad",
      # also need change from Gone to anything - wanderers
      root_status == "Gone" & lead(root_status %in% c("Alive", "Dead")) ~ "bad",
      TRUE ~ "good"
    )
  )
b <- d %>% filter(flag=="bad")
b <- b$root_ID

d %>% filter(root_ID%in%b) %>% 
  select(flag, everything()) %>% 
  View()
