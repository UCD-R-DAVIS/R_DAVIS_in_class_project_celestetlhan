#week_6_homework

library(tidyverse)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv") #ONLY change the "data" part of this path if necessary

#1, 2
mean_lifeex <- gapminder %>% 
  group_by(continent, year) %>% 
  summarise(mean_life=mean(lifeExp)) %>% 
  ggplot(mapping = aes(x=year, y=mean_life, colour = continent))+
           geom_point() + geom_smooth()  + scale_x_log10() 
mean_lifeex         

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()


#3

#, aes(color = as.factor(plot_id)
gapminder %>% 
  filter(country == "Brazil" | country == "China" | country == "El Salvador" | country == "Niger" | country == "United States") %>% 
    ggplot(mapping = aes(x= country, y = lifeExp)) + 
  geom_jitter(alpha = 0.3) +
  geom_boxplot() +
  ggtitle("Life Expectancy of Five Countries") +
  xlab("Country") + ylab("Life Expectancy")
