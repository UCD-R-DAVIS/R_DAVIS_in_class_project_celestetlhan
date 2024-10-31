#midterm_han_celeste

#1
library(tidyverse)
library(dplyr)
runningdf<-read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv")

#2
runningdf2 <- runningdf %>% 
filter( sport == "running") 
runningdf2

#3
runningdf2<-runningdf2 %>% 
    filter(minutes_per_mile >5 & minutes_per_mile <10) 
runningdf2

#4
runningdf2<-runningdf2 %>% 
mutate(pace = case_when(
  minutes_per_mile > 8 ~ "slow",
  minutes_per_mile > 6 ~ "medium",
  TRUE ~ "fast")) 
runningdf2

runningdf2<-runningdf2 %>% 
  mutate(form = case_when(
    year == "2024" ~ "new",
    TRUE ~ "old"
   )) 
runningdf2

#5
runningdf3<-runningdf2 %>% 
  group_by (pace, form) %>% 
  summarise(mean_steps = mean(steps_per_minute))
runningdf3

runningdf3<-runningdf3 %>% 
  pivot_wider(names_from = "pace", values_from = "mean_steps")
runningdf3

