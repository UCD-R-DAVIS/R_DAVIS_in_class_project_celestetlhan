#week 4 lecture

# Homework 3 Review -----
#Load your survey data frame with the read.csv() function.
surveys <- read.csv("data/portal_data_joined.csv")

#Create a new data frame called surveys_base with only the species_id, 
#the weight, and the plot_type columns. 
surveys_base <- surveys[, c(6,9,13)]
#or
surveys_base<- surveys[, c("species_id", "weight", "plot_type")]
#or
surveys_base <- select(surveys, species_id, weight, plot)

#Have this data frame only be the first 5,000 rows. 
surveys_base<- surveys[1:5000, c("species_id", "weight", "plot_type")]

#Convert both species_id and plot_type to factors.
#Remove all rows where there is an NA in the weight column. 
surveys_base$species_id <- factor(surveys_base$species_id)
#doing surveys_base$species_id up there^ replaces the species_id column in the surveys_base df
#to check:
class(surveys_base$species_id)
str(surveys_base)

#Explore these variables and try to explain why a factor is different from a character.
#Why might we want to use factors? Can you think of any examples?



##LECTURE

#learning dplyr and tidyr: select, filter, and pipes
#only do this once ever:
install.packages("tidyverse")
  #We've learned bracket subsetting
  #It can be hard to read and prone to error
  #dplyr is great for data table manipulation!
  #tidyr helps you switch between data formats
  
  #Packages in R are collections of additional functions
  #tidyverse is an "umbrella package" that
  #includes several packages we'll use this quarter:
  #tidyr, dplyr, ggplot2, tibble, etc.
  
  #benefits of tidyverse
  #1. Predictable results (base R functionality can vary by data type) 
  #2. Good for new learners, because syntax is consistent. 
  #3. Avoids hidden arguments and default settings of base R functions
  
  #To load the package type:
  library(tidyverse) #needs to be done every single time
    #now let's work with a survey dataset
    surveys <- read_csv("data/portal_data_joined.csv")
      
      
  str(surveys)
        
        
        
        
        
        
        
        
        
#select columns
month_day_year <- select(surveys, month, day, year)
month_day_year
length(month_day_year)
          
#filtering by equals
year_1981 <- filter(surveys, year==1981)
year_1981
year_1981_baser <- surveys[surveys$year == 1981,]
#year_198 and year_1981_baser are same


sum(year_1981$year != 1981, na.rm = T) #how many times is year 
            
#filtering by range
the80s <- surveys[surveys&year %in% 1981:1983,] #this is the old way

th80stidy<- filter(surveys, year %in% 1981:1983)
#5033 results
                   
                   
 #review: why should you NEVER do:
the80srecycle<- filter(surveys, year == c(1981:1983))
 #1685 results
 nrow(the80srecycle)
 
                          
#This recycles the vector 
#(index-matching, not bucket-matching)
#If you ever really need to do that for some reason,
#comment it ~very~ clearly and explain why you're 
#recycling!
                          
#filtering by multiple conditions
bigfoot_with_weight <- filter(surveys, hindfoot_length >40 & !is.na(weight))
                                                        
#multi-step process
small_animals <- filter(surveys, weight < 5)
small_animals                        
#this is slightly dangerous because you have to remember 
#to select from small_animals, not surveys in the next step
small_animal_ids <- select(small_animals, record_id, plot_id, species_id)
                                                                                                           
#same process, using nested functions
small_animal_ids <- select(filter(surveys, weight < 5), record_id, 
                           plot_id, species_id)
                                                                                                             
#same process, using a pipe
#Cmd Shift M
#the above^ gives %>% 
#or |>
#note our select function no longer explicitly calls the tibble
#as its first element
small_animal_ids <- surveys %>% filter(.,weight<5) %>% 
select(., record_id, plot_id, species_id)
                                                                                                                 
#same as
small_animal_ids <- surveys %>% filter(.,weight<5)
                                                                                                                   
                                                                                                                   
                                                                                                                   
#how to do line breaks with pipes
surveys %>% filter(month==1)

#you can do this
surveys %>% filter(
  month==1)



#good:
surveys %>% 
  filter(month==1)
                                                                                                                     
#not good:
surveys 
 %>% filter(month==1)
#what happened here?
#the pipe shld be after the surveys
                                                                                                                     
#line break rules: after open parenthesis, pipe,
#commas, 
#or anything that shows the line is not complete yet
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
#check out cute_rodent_photos!
#will be updated throughout the quarter
#as a bonus for checking out these videos
#and visiting the code demos on my repository
                                                                                                                     
                                                                                                                     
#one final review of an important concept we learned last week
#applied to the tidyverse
                                                                                                                     
mini <- surveys[190:209,]
table(mini$species_id)
#how many rows have a species ID that's either DM or NL?
nrow(mini)

test<- mini %>% filter(species_id == c("DM", "NL"))
nrow(test)
#it recycled so theres only 10
#so == is not good
                                                                                                                     
test2<- mini %>% filter(species_id %in% c("DM", "NL"))
nrow(test2)                                                                                                                 



###### Data Manipulation Part 1b ----
# Goals: learn about mutate, group_by, and summarize
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)


# Adding a new column
# mutate: adds a new column
surveys <- surveys %>%
  mutate(., weight_kg = weight/1000)

str(surveys) #shows us that the new column has been added


# Add other columns
surveys <- surveys %>%
  mutate(., 
         weight_kg = weight/1000,
         weight_kg2 = weight_kg*2)
str(surveys)

surveys$weight_kg2 = as.character(surveys$weight_kg2)
str(surveys) #shows lots of NAs in the weight columns


# Filter out the NA's
ave_weight<- surveys %>%
  filter(!is.na(weight)) %>%
  mutate(mean_weight = mean(weight))

str(ave_weight)
nrow(ave_weight) #32283 outputted
ave_weight$mean_weight
#the mean is the same avg weight for all of them. so it took of avg of everything


ave_weight<- surveys %>%
 filter(complete.cases(.)) 
nrow(ave_weight) #30738 shld be outputted...



# Group_by and summarize ----
# A lot of data manipulation requires us to split the data into groups,
#apply some analysis to each group, and then combine the results
# group_by and summarize functions are often used together to do this
# group_by works for columns with categorical variables 
# we can calculate mean by certain groups
surveys %>%
  group_by(sex) %>%
  mutate(mean_weight = mean(weight, na.rm = TRUE)) 

#table(df$mean_weight)

surveys %>%
  group_by(sex) %>%
summarise(mean_weight = mean(weight, na.rm = TRUE))


# multiple groups
df<- surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

summary(df)

# remove na's


# sort/arrange order a certain way
surveys %>%
  group_by(sex, species_id) %>%
  filter(sex != "") %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>%
  arrange()
  
surveys %>%
  group_by(sex, species_id) %>%
  filter(sex != "") %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>%
  arrange(mean_weight) #ascending

surveys %>%
  group_by(sex, species_id) %>%
  filter(sex != "") %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>%
  arrange(-mean_weight) #descending



# Challenge
#What was the weight of the heaviest animal measured in each year? Return a table with
#three columns: year, weight of the heaviest animal in grams, and weight in kilograms, 
#arranged (arrange()) in descending order, from heaviest to lightest. (This table should have 
#26 rows, one for each year)

#my attempt
surveys %>%
  mutate(.,
         weight_g = weight_kg*1000) %>%
  group_by(year, weight_kg, weight_g) %>%
  filter(year != "") %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>%
  arrange(-mean_weight) #descending

#
d<- surveys %>%
  select(year, record_id, weight) %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight/1000) %>%
  group_by(year) %>%
  summarize(max_weight_g = max(weight)
            max_weight_kg = max(weight)) %>%
  arrange()
  
  nrow(d)

  ?dplyr
  #gives
  #Useful links:
  # https://dplyr.tidyverse.org
  # https://github.com/tidyverse/dplyr
  #Report bugs at https://github.com/tidyverse/dplyr/issues

#Try out a new function, count(). Group the data by sex and pipe the grouped data into the 
#count() function. How could you get the same result using group_by() and summarize()? 
#Hint: see ?n.


                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     