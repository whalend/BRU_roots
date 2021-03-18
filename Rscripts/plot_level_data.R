## Ancillary plot-level data

library(tidyverse)
library(readxl)

## Above-ground biomass
ag_bio <- read_xlsx("data/ag_biomass/AG_wt_2020.xlsx")
# summary(ag_bio)
ag_bio <- ag_bio %>% 
  select(block:dead_wt_g)
month_num <- tibble(month = unique(ag_bio$month), 
                    month_num = seq(3,11,1))
ag_bio <- left_join(ag_bio, month_num)


## Soils
soils19 <- read_csv("data/soil_temp_vwc/2019__temp_vwc/soil_temp_vwc.csv")
soils19 <- soils19 %>% 
  select(block = block_1, composition:vwc)

soils20 <- left_join(
  read_xlsx("data/soil_temp_vwc/2020_temp_vwc/soil_temp2020.xlsx", sheet = 3) %>% 
    select(-notes),
  read_xlsx("data/soil_temp_vwc/2020_temp_vwc/soil_vwc2020.xlsx", sheet = 3) %>% 
    select(-notes)
)

## Tube plot treatments
trt <- read_xlsx("data/treatments.xlsx") %>% 
  filter(!is.na(rhizotron_tube))

## Flag tube plots in soils data and aboveground data
ag_bio %>% View()
