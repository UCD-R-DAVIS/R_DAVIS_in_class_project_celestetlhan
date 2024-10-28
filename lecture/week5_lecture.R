#week5_lecture

##homework
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

#part 2
#weight between 30 and 60
#cmd shift m for pipe shortcut
mini <- surveys %>% filter(weight>=30 & weight <=60) %>% head(n=5)

#part 3a
#new tibble showing max weight for each species + sex combination

biggest_critters <- surveys %>% filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  summarise(max_weight = max(weight))

biggest_critters


#part 3b
#arrange
biggest_critters %>% arrange(max_weight) %>%  head()
biggest_critters  
 
biggest_critters %>% arrange(-max_weight) %>%  head()
biggest_critters   
  
#part 4

surveys %>% filter(is.na(weight)) %>% 
  group_by(species) %>% tally() %>% arrange(-n) #we wana choos ea group to group by just to see where the nas r hiding
#we cld groupby taxa instead 
#we can change the filter if its not nas we wana look at but a diff type of data info

#part 5
#remove weight na

##surveys %>%  filter(!is.na(weight)) %

#new column = avg weight of species+sex combo

##surveys %>%  filter(!is.na(weight)) %>%
##group_by(species_id, sex) %>% 
##  mutate(avg_weight = mean(weight))

#get rid of all columns except species, sex, weight and the new avg weight
surveys_avg_weight<- surveys %>%  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>% 
  mutate(avg_weight = mean(weight)) %>% 
  select(species_id, sex, weight, avg_weight)

#how would we make a mini summary table for above?

mini<-surveys_avg_weight<- surveys %>%  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>% 
  summarise(avg_weight = mean(weight)), max_weight=
  max(weight)

mini

#above^ the "max_weight=
 # max(weight)" was added as a side note that it now does smth


#part 6
#take surveys_avg_weight
#add new column
#called above_average that contains logcial values
#stating whether or not rows weight > avg_weight
#for its species +sex combo

surveys_avg_weight %>% mutate (above_average = weight> avg_weight)


#----------------------------------------------------------

# Conditional statements ---- 
## ifelse: run a test, if true do this, if false do this other thing
## case_when: basically multiple ifelse statements
# can be helpful to write "psuedo-code" first which basically is writing out what steps you want to take & then do the actual coding
# great way to classify and reclassify data

## Load library and data ----
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

## ifelse() ----
# from base R
# ifelse(test, what to do if yes/true, what to do if no/false)
## if yes or no are too short, their elements are recycled
## missing values in test give missing values in the result
## ifelse() strips attributes: this is important when working with Dates and factors
surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length<mean
                               (surveys$hindfoot_length, na.rm = TRUE), yes= "small", no=
                                 "big") #the na.rm = TRUE part lets us remove it so that we remove it when doing the mean because u cant get a mean when u have NAs, it would just give us NA...and its JUST in the calculation of the mean it doesnt mean that we removed the NAs in the dataset
head(surveys$hindfoot_cat) #gives some NAs
# $ is a functional tool in r to call up a column name very easily..way to access the column
#can use to access existing columns or create new ones
head(surveys$hindfoot_length)
summary(surveys$hindfoot_length)
surveys$record_id
unique(surveys$hindfoot_cat)





## case_when() ----
#its like if else but to the n'th degree, like u can do as many statements
# GREAT helpfile with examples!
# from tidyverse so have to use within mutate()
# useful if you have multiple tests
## each case evaluated sequentially & first match determines corresponding value in the output vector
## if no cases match then values go into the "else" category

# case_when() equivalent of what we wrote in the ifelse function
surveys %>%
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big", #hindfoot length over mean(29.29) I want to be reclassified as "big"
    TRUE ~ "small" #this is like the "else" part of the statement, if anything that doesnt match the line above will be labelled as "else"
  )) %>%
  select(hindfoot_length, hindfoot_cat) %>%
  head()

# but there is one BIG difference - what is it?? (hint: NAs)
###you need to specify what u need to do with the NAs


d<- surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length >31.5 ~ "big",
    hindfoot_length>29 ~ "medium",
    is.na(hindfoot_length) ~ NA_character_,
    TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat)

view(d)

#multiple cases

# if no "else" category specified, then the output will be NA


# lots of other ways to specify cases in case_when and ifelse
surveys %>%
  mutate(favorites = case_when(
    year < 1990 & hindfoot_length > 29.29 ~ "number1", 
    species_id %in% c("NL", "DM", "PF", "PE") ~ "number2",
    month == 4 ~ "number3",
    TRUE ~ "other"
  )) %>%
  group_by(favorites) %>%
  tally()

#--------------------------------------------------------------
#notes on join
#inner join is on only of rows of id in both data
#left join is only add the ones from data 2 into data 1 that are present in data 1
#full join is like merging everythingno matter what
library(tidyverse)

tail<- read_csv('data/tail_length.csv')
surveys<- read.csv("data/portal_data_joined.csv")

head(tail)
dim(tail)
#outputs 2 columns

head(surveys)
dim(surveys)
#outputs 13 columns

#inner join
surveys_inner<- inner_join(x= surveys, y= tail)
dim(surveys_inner)
head(surveys_inner)
#all rows are same bc the tail is from the surveys one
#theres 14 columns now because record_id is the same

surveys_full<- full_join(surveys,tail) #this assumes first is x and second is y bc we didnt specify
dim(surveys_full)

#left_join(x= surveys, y= tail %>%  rename(record_id2 = record_id),
 #         by= c('record_id'= 'record_id'))
#^this is to joinn them if the column names are labelled diff but u wana combine as per those two columns

#----------------------------------------------------------------------

#pivots are to change shapes
#pivot wider is more rows to columns
#pivot longer is more columns to rows

surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarise(mean_weight = mean(weight))

surveys_mz


surveys_mz %>% 
  pivot_wider(id_cols = "genus", 
              names_from = "plot_id", 
              values_from = "mean_weight" )
  

  