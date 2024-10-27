#week_4_homework

###remember to load tidyverse

surveys <- read_csv('data/portal_data_joined.csv')
surveys # A tibble: 34,786 × 13

####ask why this didnt work
surveys_30to60 <- filter(surveys, weight %in% 30:60) %>% # A tibble: 15,281 × 13
  head(surveys, n=6)
surveys_30to60

biggest_critters <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by (species_id, sex) %>% 
  summarise(max_weight = max(weight)) %>% 
  arrange(-max_weight)
head(biggest_critters)

biggest_critters_test <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by (species_id, sex) %>% 
  summarise(max_weight = max(weight)) %>% 
  arrange(max_weight)
head(biggest_critters_test)
###ask abt this q4
?tally

tally(biggest_critters_test)


surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(weight_avg = mean(weight)) %>% 
  select(species_id, sex, weight, weight_avg)
surveys_avg_weight

surveys_avg_weight2 <- surveys_avg_weight %>% 
  group_by(species_id, sex) %>% 
  mutate(above_average = weight==weight_avg) 
surveys_avg_weight2











