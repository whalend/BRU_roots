## Initial exploration of minirhizotron data
## 2021-01-13
## Whalen Dillon, whalendillon@gmail.com

## Treating Excel files prepared by Stacy Smith as raw data files.
## The Excel files are the output from the WinRhizo program rearranged into 
## something readable and useable for scripting.

library(tidyverse)
library(readxl)
library(tibble)

read_fn <- function(file_path, sheet_num){
  
  flist = list.files(file_path, pattern = "*.xlsx", full.names = TRUE)
  t = tibble()
  for(i in flist){
    j = read_xlsx(i, sheet = 3)
    t = rbind(t, j)
  }
  return(t)
}

df <- read_fn("raw_data", 3)
head(df)
summary(df)

df$SampleId[1:5]
n_distinct(df$SampleId)
## Appears to be picture file name.
## Repeated for roots; may be unique for location.

unique(df$ROOT)# delete because they are all roots
unique(df$RootName)# "Root ID" that is only unique to tube and location
## Distinct root ID would be: RootName+Location+Tube; add date or session for
## unique observation of that root.

unique(df$Experiment)# remove column, one repeated value that is non-critical

unique(df$Date)# ooh, fun date formatting, 2020.04.21; one visit per month
## Supposed to match up with the Session value where 1 = April & 8 = November
unique(df$`Session#`)

unique(df$Time); n_distinct(df$Time)# presumably time of picture, 24-h clock

unique(df$DataGatherer)# only SAS thus far (2021-01-13)

unique(df$TipLivStatus)
unique(df$Fungae)# no data, remove column
unique(df$nodule)# no data, remove column
unique(df$Undefined...37)# no data, remove column
unique(df$Undefined...38)# no data, remove column
unique(df$RootNotes)# Do we care about 8 records (thus far) with "nodule"
filter(df, RootNotes == "nodule")
unique(df$HighestOrder)# What does this mean?
unique(df$ExtPathLength)# What does this mean?
unique(df$Altitude)# What does this mean?

names(df)
## Remove and avoid special characters from column names
## Tube#, Location#, Session#
## Replace parentheses with simple underscore
## If its mm/10 for TotAvgDiam just call it cm

## Remove null and completely uninformative columns
df <- df %>% 
  select(-ROOT, -Experiment, -Fungae:-RootNotes) %>% 
  rename(Tube = `Tube#`, Location = `Location#`, Session = `Session#`,
         TotLength_mm = `TotLength(mm)`, TotProjArea_mm2 = `TotProjArea(mm2)`,
         TotSurfArea_mm2 = `TotSurfArea(mm2)`, 
         TotAvgDiam_cm = `TotAvgDiam(mm/10)`, TotVolume_mm3 = `TotVolume(mm3)`,
         
         AliveLength_mm = AliveLength, AliveProjArea_mm2 = AliveProjArea,
         AliveSurfArea_mm2 = AliveSurfArea, AliveAvgDiam_cm = AliveAvgDiam,
         AliveVolume_mm3 = AliveVolume,
         
         DeadLength_mm = DeadLength, DeadProjArea_mm2 = DeadProjArea,
         DeadSurfArea_mm2 = DeadSurfArea, DeadAvgDiam_cm = DeadAvgDiam,
         DeadVolume_mm3 = DeadVolume,
         
         GoneLength_mm = GoneLength, GoneProjArea_mm2 = GoneProjArea,
         GoneSurfArea_mm2 = GoneSurfArea, GoneAvgDiam_cm = GoneAvgDiam,
         GoneVolume_mm3 = GoneVolume
  )

## Add unique IDs for root and each observation of the root
df <- df %>% 
  mutate(root_ID = paste(Tube, Location, RootName, sep = "_"),
         obs_ID = paste(Session, root_ID, sep = "_")) %>% 
  select(obs_ID, root_ID, everything())
write_csv(df, "raw_data/all_raw_observations.csv")
