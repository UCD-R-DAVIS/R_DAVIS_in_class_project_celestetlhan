#WEEK 4 VIDEOS


#WEEK 4.1 : DATA MANIPULATION PART1A (SELECT, FILTER, AND PIPE)

#we're going to do:
#install.packages("tidyverse")
#you only need to do this once and not again

#why are we installing this tidyverse package?
#weve learned bracket subsetting- 
#it can be hard to read and easy to make mistakes esp with 2 dimensional data

#so instead, dply is a packacge that is great for data table manipulation!
#tidyr is a package that helps you switch between data formats

#packages in R are collections of additoinal functions
#tidyverse is an "umbrella package" that
#includes several packages we'll yse this quarter:
#tidyr, dplyr, ggplot2, tibble, etc

#benefits of tidyverse
#1. predictable results (base R functionality can vary by data type)
#2. good for new lerners, because syntax is consistent
#3. voids hidden arguments and default settings of base R functions

#to load the package type"
library(tidyverse)
#now lets work with a survey dataset
surveys <- read_csv("data/portal_data_joined.csv")

str(surveys)

#select columns
month_day_year <- select(surveys, month, day, year)

#filtering by equals
year_1981<- filter(surveys, year==1981)

#filtering by range
filter(surveys, year %in% c(1981:1983)) 
#the %in% is used for a bucket search, saying hey out of all the observations, i want everything where the year is found wihtin the 1981:1983
#results in: # A tibble: 5,033 × 13

#review: why should you NEVER do:
filter(surveys, year == c(1981, 1982, 1983))
#this only has:
## A tibble: 1,685 × 13
#which is less than A tibble: 5,033 × 13
#so this one goes to the first row and sees does this row equal to 1981? yes or no.. and then moves onto the second row and checks does this year equal to 1982? yes or no? and then the 3rd and then goes in a cycle from 1981, 1982, 1983, 1981, 1982, 1983 etc this is RECYLCING METHOD
#but the %in$ does BUCKET METHOD matching so which of the years is in the bucket of 1981-1983

#filtering by multiple conditions
weight <- filter(surveys, hindfoot_length>40 & !is.na(weight))

#multi-step process
small_animals <- filter(surveys, weight<5)
small_animals_ids <- select(small_animals, record_id, plot_id, species_id)

#same process as above but using nested functions
small_animals_ids <- select(filter(surveys, weight<5), record_id, plot_id, species_id)

#same process using a pipe
#cmd shift m (but this is function with tidyverse so youd have to load tidyverse)
#or |>
#note our select function no longer explocitly calls the tibble as its first element
small_animals_ids<- filter(surveys, weight<5) %>% 
  select(record_id, plot_id,species_id)
#same as
small_animals_ids <- surveys %>% filter(weight<5) %>% 
  select(record_id, plot_id, species_id)


#WEEK4.3: DATA MANIPULATION PART 1B (MUTATE, GROUPBY, AND SUMMARIZE)

surveys<-read_csv("data/portal_data_joined.csv")

###mutate
#there might be some cases to create a new column of data in your dataframe

surveys<-surveys %>% 
  mutate(weight_kg = weight/1000)
str(surveys)

#add multiple columns
surveys<- surveys %>% 
  mutate(weight_kg = weight/1000,
         weight_kg2 = weight_kg*2)
str(surveys)

#filter out na's
surveys<- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000,
         weight_kg2 = weight_kg*2)
str(surveys)
head(surveys)

##challenge in the tutorial
#Create a new data frame from the surveys data that meets the following criteria: contains only the species_id column and a new column called hindfoot_half containing values that are half the hindfoot_length values. In this hindfoot_half column, there are no NAs and all values are less than 30. Name this data frame surveys_hindfoot_half.

#surveys_hindfoot_half<- surveys %>% 
 # filter(!is.na(hindfoot_length)) %>% 
  #mutate(hindfoot_half = hindfoot_length/2 & hindfoot_half<30)

#^wrong

surveys_hindfoot_half<- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  mutate(hindfoot_half = hindfoot_length/2) %>% 
  filter(hindfoot_half<30) %>% 
  select(species_id, hindfoot_half)
surveys_hindfoot_half



###group_by and summarise
#a lot of data manipulation requires you to split the data into different groups and then perform some type of analysis and then bring the results of that analysis back together and these two functions do this- and theyre often used with one another
#groupby allows you to perform  analysis on certain groups and so by the nature of that, it requires some sort of categorical variable
surveys2<- surveys %>% 
  group_by (sex) %>% 
  mutate(mean_weight = mean(weight))
str(surveys2) #32,283 × 16

surveys3<- surveys %>% 
  group_by (sex) %>% 
  summarise(mean_weight = mean(weight))
str(surveys3) #3 × 2

surveys4<- surveys %>% 
  group_by (sex, species_id) %>% 
  summarise(mean_weight = mean(weight))
surveys4
str(surveys4) #64 × 3
surveys4
#the weight^ is not in like a specific order and you might want to look at weight in decsending on ascending order and so a useful function for this is the arrange function 

###arrange
surveys4_pt2<- surveys %>% 
  group_by (sex, species_id) %>% 
  summarise(mean_weight = mean(weight)) %>% 
  arrange(mean_weight)
surveys4_pt2
#this has the mean weight in ascending ordr^
#if you do   arrange(-mean_weight)
#then it would be decsending

###multiple columns
surveys4_pt3<- surveys %>% 
  group_by (sex, species_id) %>% 
  summarise(mean_weight = mean(weight),
            min_weight = min(weight)) %>% 
  arrange(mean_weight)
surveys4_pt3






