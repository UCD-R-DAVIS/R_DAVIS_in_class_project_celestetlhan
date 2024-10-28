#week5_videos

#WEEK 5.1 DATA MANIPULATION PART2A (CONDITIONAL STATEMENTS)

#its a way to run a test and if smth is true then do one thing, if false then do another thing

library(tidyverse)
surveys<-read_csv("data/portal_data_joined.csv")
str(surveys)

summary(surveys$hindfoot_length)
#outputted:
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
  #2.00   21.00   32.00   29.29   36.00   70.00    3348 

#psuedocode:
# ifelse(test of condition, what to do if the test is yes/true, what to do if its false/not true)

#boolean test
surveys$hindfoot_length <29.29 # this number is the mean we got from teh sumary in line 11

#you can add a column like this:
surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length<29.29, yes = "small", no= "big") #hindfoot_cat for categorical
head(surveys$hindfoot_cat)
head(surveys$hindfoot_length) #can crosscheck if line right above is true

surveys$hindfoot_length2 <- ifelse(surveys$hindfoot_length<mean(surveys$hindfoot_length, na.rm = TRUE), yes = "small", no= "big")
head(surveys$hindfoot_length2)

#ifelse if pretty helpful when you have just two conditions but when you start having multiple conditions...for this theres another function..casewhen

###case_when()
surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big",
    TRUE ~ "small" #this part might be weird syntax
  ))
#the weird syntax part is because the last part is a catch all statement so they all go through and see if its bigger than 29.29 then they get labelled big and so for the remanining ones you go thru them again and the true part is saying if u go thru then yes for all of these label them small for the rest
#its case_whens way of having the "else" part of the statement

surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big",
    TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head()
#outputs:
# A tibble: 6 × 2
#hindfoot_length hindfoot_cat
#<dbl> <chr>       
#1              32 big         
#2              31 big         
#3              NA small       
#4              NA small       
#5              NA small       
#6              NA small 
#^you can see that the first two were classified correctly, bc theyre 32 and 31 and theyre both bigger than 29.29, they got classified as big...but then the NAs got classified as small....
#this is bc the way we wrote the code we only specified for above 29.29 to be classified as big and EVERYTHING else to be classified as small

surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big",
    is.na(hindfoot_length) ~ NA_character_, #also other types: NA_integer_ for NA for integer but na is a character here
    TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head()

#outputs:
# A tibble: 6 × 2
#hindfoot_length hindfoot_cat
#<dbl> <chr>       
#1              32 big         
#2              31 big         
#3              NA NA          
#4              NA NA          
#5              NA NA          
#6              NA NA 
#^so now we see the NAs being correctly classified as NA

#what if more categories???
surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 31.5 ~ "big",
    hindfoot_length > 29 ~ "medium",
    is.na(hindfoot_length) ~ NA_character_,
    TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  group_by(hindfoot_cat) %>% 
  tally()
  head()

#---------------------------------------------------------------

#WEEK 5.2 DATA MANIPULATION PART 2B (JOINS,PIVOTS)

tail <- read.csv("data/tail_length.csv")
head(tail)
dim(tail)

#join_function(data frame a, data frame b, how to join)

surveys <- read_csv("data/portal_data_joined.csv")

#inner_join(data frame a, data frame b, common id)
#inner_join only keeps record that are in both data frames
dim(inner_join(x=surveys, y=tail, by = "record_id"))
dim(surveys)
dim(tail)

#left_join
#left_join takes dataframe x and dataframe y and it keeps everything in x and only matches in y
#left_join(x,y) == right_join(y,x)

#right_join
#right_join takes dataframe x and dataframe y and it keeps everything in y and only matches in x
#right_join(x,y) == left_join(y,x)

surveys_left_joined<- left_join(x=surveys, y= tail, by = "record_id")
surveys_right_joined<- right_join(y=surveys, x= tail, by = "record_id")

dim(surveys_left_joined)
dim(surveys_right_joined)


#full_join(x,y)
#full_join keeps EVERYTHING
surveys_full_joined <- full_join(x=surveys, y=tail)
dim(surveys_full_joined)

#pivot_wider makes data with more columns
pivot_wider()

#pivot_longer makes date with more rows
pivot_longer()

surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarise(mean_weight = mean(weight))

surveys_mz
unique(surveys_mz$genus)

wide_survey<- surveys_mz %>% 
  pivot_wider(names_from = "plot_id", values_from = "mean_weight")
head(wide_survey)

surveys_long<- wide_survey %>% pivot_longer(-genus, names_to="plot_id", values_to = "mean_weight")
head(surveys_long)







