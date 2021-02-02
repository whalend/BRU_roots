## Generate figures

# 1. Length, Production, Turnover by Depth

# 2. Length, Production, Turnover by Day of Year

library(tidyverse)
df <- read_csv("data/processed_data/mr_roots_data_corrected.csv")

## Make size class groupings of root length
df <- df %>% 
  # group_by(root_status) %>% 
  mutate(length_bin = 
           case_when(
             Length_mm < 1 ~ "<1 mm",
             between(Length_mm, 1, 2) ~ "1 - 2 mm",
             between(Length_mm, 2.0001, 3) ~ ">2 - 3 mm",
             between(Length_mm, 3.0001, 4) ~ ">3 - 4 mm",
             between(Length_mm, 4.0001, 5) ~ ">4 - 5 mm",
             between(Length_mm, 5.0001, 6) ~ ">5 - 6 mm",
             between(Length_mm, 6.0001, 7) ~ ">6 - 7 mm",
             between(Length_mm, 7.0001, 8) ~ ">7 - 8 mm",
             between(Length_mm, 8.0001, 9) ~ ">8 - 9 mm",
             between(Length_mm, 9.0001, 10) ~ ">9 - 10 mm",
             Length_mm > 10 ~ ">10 mm"
           ) %>% 
           factor(levels = c("<1 mm","1 - 2 mm", ">2 - 3 mm", ">3 - 4 mm", 
                             ">4 - 5 mm", ">5 - 6 mm", ">6 - 7 mm", ">7 - 8 mm",
                             ">8 - 9 mm", ">9 - 10 mm", ">10 mm"))
  )



ggplot(df, aes(length_bin, Length_mm, fill = root_status)) +
  geom_col(position = "dodge") +
  theme_minimal()

ggplot(df) +
  geom_density(aes(Length_mm, color = root_status)) +
  scale_x_continuous(breaks = c(seq(0,10, 2), 10, 20, 30, 40, 50, 60),
                     labels = c(seq(0,10, 2), 10, 20, 30, 40, 50, 60),
                     expand = c(.01,.01)) +
  scale_y_continuous(expand = c(.001,.001)) +
  theme_minimal()

ggplot(df, aes(Location*-1, Length_mm) +
  geom_point(alpha = .2) +
  # stat_summary(fun.data = "mean_se", color = "deepskyblue", size = .2) +
  geom_smooth() +
  coord_flip() +
  facet_grid(~root_status) +
  xlab("Relative depth")
