## Ancillary plot-level data

library(tidyverse)
library(readxl)

## Tube plot treatments ####
trt <- read_xlsx("data/treatments.xlsx") %>% 
  filter(!is.na(rhizotron_tube)) %>% 
  mutate(plot_id = paste0(plot, subplot))


## Above-ground biomass ####
ag_bio <- read_xlsx("data/ag_biomass/AG_wt_2020.xlsx")
# summary(ag_bio)
ag_bio <- ag_bio %>% 
  select(block:dead_wt_g) %>% 
  mutate(plot_id = paste0(plot, subplot))
unique(ag_bio$month)
month_num <- tibble(month = unique(ag_bio$month), 
                    month_num = seq(3,11,1))
ag_bio <- left_join(ag_bio, month_num)
ag_bio <- left_join(ag_bio, trt)
ag_bio <- ag_bio %>% filter(!is.na(rhizotron_tube))
## control plots (uncut) don't have values for weights

## Soils ####
soils20 <- left_join(
  read_xlsx("data/soil_temp_vwc/2020_temp_vwc/soil_temp2020.xlsx", sheet = 3) %>%
    select(-notes),
  read_xlsx("data/soil_temp_vwc/2020_temp_vwc/soil_vwc2020.xlsx", sheet = 3) %>%
    select(-notes)
)

## MR sampling is once per month, soil temp & vwc appears to be once per week
## How to use these data?
## a. previous month environment --> following month measurements

ggplot(soils20, aes(date, temp)) +
  geom_point(color = "red", alpha = .2)
## What happened to temperature values in April?


ggplot(soils20, aes(as.Date(date), vwc)) +
  geom_point(color = "deepskyblue", size = 3) +
  geom_point(aes(y = temp), color = "red", alpha = .2) +
  ylab("VWC (blue) & Temperature (red)") +
  xlab("") +
  scale_x_date(date_breaks = "1 month")
## Overall 1107 NA values for VWC
## Wider sampling gaps in April and August
## Looks like late-April and May temperatures are the exact same values as vwc

## Need to make some corrections for these data to be usable
## Add 20 to the values that are less than 10?

## Look at soil vwc data Chris sent
soil_vwc <- read_csv("data/soil_vwc2020.csv") %>% 
  select(block:vwc)
soil_vwc <- soil_vwc %>% 
  mutate(Date = lubridate::mdy(date),
         month_num = lubridate::month(Date),
         plot_id = paste0(plot, loc))
summary(soil_vwc)# No missing data in this set
ggplot(soil_vwc, aes(Date, vwc)) +
  geom_point()

soil_vwc_month <- soil_vwc %>% 
  group_by(plot_id, month_num) %>% 
  summarise(avg_vwc = mean(vwc))

mr_soil_vwc <- left_join(soil_vwc_month, trt) %>% 
  filter(!is.na(rhizotron_tube))

soil_temp <- read_xlsx("data/soil_temp_vwc/2020_temp_vwc/soil_temp2020.xlsx", sheet = 3) %>% select(-notes)
soil_temp <- soil_temp %>% 
  mutate(Date = as.Date(date),
         temp2 = ifelse(temp<10, temp+17, temp),
         plot_id = paste0(plot, loc),
         month_num = lubridate::month(Date))
summary(soil_temp)

ggplot() +
  geom_point(data = soil_vwc, aes(Date, vwc), color = "deepskyblue", size = 3) +
  geom_point(data = soil_temp, aes(Date, temp), color = "red", alpha = .5) +
  ylab("Value for VWC and temperature") +
  geom_point(data = soil_temp, aes(Date, temp2), color = "orange", alpha = .1)

soil_temp_month <- soil_temp %>% 
  group_by(plot_id, month_num) %>% 
  summarise(avg_temp = mean(temp),
            avg_temp2 = mean(temp2),
            max_temp = max(temp),
            max_temp2 = max(temp2),
            min_temp = min(temp),
            min_temp2 = min(temp2))

mr_soil_temp <- left_join(soil_temp_month, trt) %>% 
  filter(!is.na(rhizotron_tube))

ggplot(mr_soil_temp, aes(month_num, avg_temp2)) +
  geom_point()


## LAI ####
lai_data <- read_csv("data/BRU_LAI_2020_full.csv")
summary(lai_data)
unique(lai_data$Notes)
unique(lai_data$`Notes 2`)
unique(lai_data$Composition)
unique(lai_data$Treatment)
lai_data %>% filter(is.na(LAI))

lai_data <- lai_data %>% 
  rename(date = Date,
         days_since_cut = `Days after clipping`,
         plot_id = Plot
         ) %>% 
  select(-Notes, -`Notes 2`) %>% 
  mutate(Date = lubridate::mdy(date),
         composition = ifelse(Composition == "BG", "bahia", "mixed"),
         treatment = case_when(
           Treatment == "UC" ~ "control",
           Treatment == "C" ~ "cut",
           Treatment == "CM" ~ "cut+manure"
         ),
         month_num = lubridate::month(Date)
         )
summary(lai_data)

lai_data_month <- lai_data %>% 
  group_by(plot_id, month_num) %>% 
  summarise(avg_lai = mean(LAI, na.rm = T),
            avg_sem = mean(SEM, na.rm = T))

mr_lai <- left_join(lai_data_month, trt) %>% 
  filter(!is.na(rhizotron_tube))

## Combine plot-level data
mr_plot_data <- plyr::join_all(
  list(ag_bio, mr_soil_vwc, mr_soil_temp, mr_lai)
)
summary(mr_plot_data)

write_csv(mr_plot_data, "data/processed_data/mr_plots_monthly_data.csv")
