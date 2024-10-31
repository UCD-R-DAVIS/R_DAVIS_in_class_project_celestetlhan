#week_5_homework

library(tidyverse)
surveys<- read_csv("data/portal_data_joined.csv")


#1
surveys_wide<- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(plot_type,genus) %>% 
  summarise(hindfoot_length_mean = mean(hindfoot_length))
surveys_wide

?group_by



#  mutate(hindfoot_length_mean = mean(hindfoot_length)) %>% 
#  select(plot_type, genus, hindfoot_length_mean)
#surveys_wide
#mutate didnt work so i used summarise - mutate makes a new column with all the same means for each plot type genus, but summarise summarises it so that doesnt repeat

survey_wide<- surveys_wide %>% 
  pivot_wider(names_from = "plot_type", values_from = "hindfoot_length_mean")
survey_wide


#2
?quantile()
quantiles<- quantile(surveys$weight, prob=c(.25,.5,.75), na.rm = TRUE, type=1)

surveys %>% 
  mutate(weight_cat = case_when(
   weight > 48 ~ "big",
    weight > 37 ~ "medium",
   is.na(weight) ~ NA_character_,
    TRUE ~ "small")) %>% 
select(weight_cat, weight) %>% 
arrange(-weight) %>% 
  tail()


quantiles<- quantile(surveys$weight, prob=c(.25,.5,.75), na.rm = TRUE, type=1)

surveys %>% 
  mutate(weight_cat = case_when(
    weight > 48 ~ "big",
    weight > 37 ~ "medium",
    is.na(weight) ~ NA_character_,
    TRUE ~ "small")) %>% 
  select(weight_cat, weight) %>% 
  group_by(weight_cat) %>% 
  tally()





summary(surveys$weight)
