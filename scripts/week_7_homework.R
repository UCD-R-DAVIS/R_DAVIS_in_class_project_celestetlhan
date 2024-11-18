#week_7_homework

library(tidyverse)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv") #ONLY change the "data" part of this path if necessary

newdf<- gapminder %>% 
  group_by(country, year) %>% 
  select(-gdpPercap, -lifeExp) %>% 
  filter(year == 2002 | year== 2007) %>% 
  pivot_wider(names_from = year, values_from = pop) 

newdf2<- newdf %>% 
  mutate(pop_change = `2007`-`2002`) %>% 
  filter(continent != "Oceania")

ggplot(data= newdf2, aes(x= country, y = pop_change)) + 
  geom_col(aes(fill = continent))+
  theme(axis.text.x= element_text(angle=45, hjust=1))+
  facet_wrap(~continent, scales="free")

