#week6_videos
#WEEK 6.1 DATA VISUALIZATION PT1A. (INTRO TO GGPLOT, BOXPLOTS)

library(tidyverse)
install.packages("ggplot2")
library(ggplot2)

surveys_complete <- read.csv("data/portal_data_joined.csv") %>% 
  filter(complete.cases(.))

#syntax for ggplot
##ggplot(data = <DATAFRAME NAME> , mapping = aes(<MAPPING of which COL NAMES>))+ <GEOM_FUNCTION>()

#example
ggplot(data= surveys_complete)
#this produces just a blank white

#need to add aes argument
ggplot(data = surveys_complete, mapping = aes(x=weight, y = hindfoot_length))
#still nothing is appearing after this because we need to include how the data shld be graphed

#add geom_function
ggplot(data = surveys_complete, mapping = aes(x=weight, y = hindfoot_length)) +
  geom_point()

#add more plot elements
# add transparency to the points #alpha between 0-1
ggplot(data = surveys_complete, mapping = aes(x=weight, y = hindfoot_length)) +
  geom_point(alpha= 0.1)

#add colour to the points
ggplot(data = surveys_complete, mapping = aes(x=weight, y = hindfoot_length)) +
  geom_point(colour = "blue")

#colour by group
ggplot(data = surveys_complete, mapping = aes(x=weight, y = hindfoot_length)) +
  geom_point(aes(colour = genus)) + 
  geom_smooth() # to add a line
#you can see that this prints a line for the overall points trend and not a line per genus 
#so if we want a line per genus....
ggplot(data = surveys_complete, mapping = aes(x=weight, y = hindfoot_length)) +
  geom_point(aes(colour = genus)) + 
  geom_smooth(aes(colour=genus)) 

#universal plot setting
ggplot(data = surveys_complete, mapping = aes(x=weight, y = hindfoot_length,
  colour = genus)) +
  geom_point() + 
  geom_smooth() 

#boxplot: categorical x continuous data 
ggplot(data = surveys_complete, mapping = aes(x= species_id, y = weight)) +
  geom_boxplot(colour = "orange")

#if you dont want the outline to be orange but the inside to:
ggplot(data = surveys_complete, mapping = aes(x= species_id, y = weight)) +
  geom_boxplot(fill = "orange")

#you  can also change different things
ggplot(data = surveys_complete, mapping = aes(x= species_id, y = weight)) +
  geom_boxplot(colour = "orange") +
  geom_jitter(colour = "black", alpha = 0.1)

#change the order of plot construction
ggplot(data = surveys_complete, mapping = aes(x= species_id, y = weight)) +
  geom_jitter(colour = "black", alpha = 0.1) +
  geom_boxplot(colour = "orange")

# you can also play around with making the boxplot transparent as well
ggplot(data = surveys_complete, mapping = aes(x= species_id, y = weight)) +
  geom_jitter(colour = "black", alpha = 0.1) +
  geom_boxplot(colour = "orange", alpha = 0.5)


###WEEK 6.2: DATA VISUALIZATION PT 1B (TIMESERIES, FACETS)

library(tidyverse)

surveys_complete <- read_csv("data/portal_data_joined.csv") %>% 
  filter(complete.cases(.))


#first thing we want to do is make a scatterplot of yearly counts of species id for each year 
yearly_counts <- surveys_complete %>%  count(year, species_id)
?count #way of counting how many times you see observations that have a particular combination of variables and this also produces the identical result of groupby and tally:
surveys_complete %>%  group_by(year, species_id) %>%  tally()

yearly_counts<- surveys_complete %>% count(year,species_id)
head(yearly_counts)
#we want to keep this long format when using ggplot

ggplot(data=yearly_counts, mapping = aes(x= year, y=n)) +
  geom_point()

#can turn into a line plot
ggplot(data=yearly_counts, mapping = aes(x= year, y=n)) +
  geom_line()
#this looks pretty bad.. tracing through all the dots and doesnt make sense because its all connected

#so we want to add a grouping variable:
ggplot(data=yearly_counts, mapping = aes(x= year, y=n, group=species_id)) +
  geom_line()


#now we have lines that make sense but we can add colour but then we dont need the "group=species_id" in the aes then
ggplot(data=yearly_counts, mapping = aes(x= year, y=n, colour = species_id)) +
  geom_line()

#so this is not an intelligible plot still bc way too many lines of diff shades so its hard to differentiate between one green to another green etc

#so we can facet instead(to make each line have its own plot)
ggplot(data=yearly_counts, mapping = aes(x= year, y=n)) +
  geom_line() + 
  facet_wrap(~species_id)

ggplot(data=yearly_counts, mapping = aes(x= year, y=n)) +
  geom_line() + 
  facet_wrap(~species_id)

#u can set number of rows or cols
ggplot(data=yearly_counts, mapping = aes(x= year, y=n)) +
  geom_line() + 
  facet_wrap(~species_id, nrow = 4)

ggplot(data=yearly_counts, mapping = aes(x= year, y=n)) +
  geom_line() + 
  facet_wrap(~species_id, ncol = 2)


#u can also adjust the scale 
ggplot(data=yearly_counts, mapping = aes(x= year, y=n)) +
  geom_line() + 
  facet_wrap(~species_id, scales = 'free')

