## Identify which roots are 'Gone' but then reappear

library(tidyverse)
source("Rscripts/02_qaqc_raw_data.R")

## Remove some unneeded columns
df <- no_dupes %>% 
  select(-starts_with("Tot"), -TipDiam:-Altitude, -Time, -DataGatherer)

gone <- df %>% 
  filter(GoneLength_mm > 0)

gone <- df %>% 
  filter(root_ID%in%gone$root_ID)
gone %>% 
  arrange(root_ID) %>% View()

## This chunk should flag any negative values the successive differences 
## between 'GoneLength_mm' values, indicating that the 'GoneLength_mm' changed
## from a value to either a smaller value or zero. The main intention is to 
## catch any of the changes back to zero that may indicate the root reappearing.
gone %>% 
  arrange(root_ID) %>% 
  group_by(root_ID) %>% 
  mutate(gdiff = GoneLength_mm - lag(GoneLength_mm),
         flag = ifelse(gdiff<0, "bad", "good")) %>% 
  select(root_ID, Session, AliveLength_mm, DeadLength_mm, 
         GoneLength_mm, gdiff, flag) %>% 
  View()


