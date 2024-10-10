#Lecture 3

#other data types
## lists
c(4, 6, "dog") #weve been doing this
a<- list (4, 6, "dog") #this spits out smth diff from ^ because treats each item as a vector
class(a)
str(a)


#data.frames
letters
data.frame(letters)

#to try to transpose it
#df<- data.frame(letters)
#as.data.frame(t(df))

length(df)
dim(df) #outputs rows, then columns
nrow(df)
ncol(df)


#factors
#factors are a string character values with some sort of level associated with each character

animals <- factor(c( "pigs", "duck", "duck", "goose", "goose"))
animals
#this outputs:
##[1] duck  duck  goose goose
##Levels: duck goose
#duck is first bc its alphabetised

class(animals)
levels(animals)
nlevels(animals)


animals <- factor(x=animals, levels = c("goose", "pigs","duck"))
animals

year<- factor(c(1978, 1980, 1934, 1979))
year
class(year)
as.numeric(year) #gives us the level of each year
levels(year)

as.numeric(animals)
as.character(animals)


year <- as.numeric(as.character(year))
as.character(year)
year

test<-as.character(as.numeric(animals))
test

test2<-as.character(animals)
test2
test3<-as.numeric(test2)
test3

############

getwd()
#output: [1] "/Users/celestehan/Documents/R-Projects/R_DAVIS_in_class_project_celestetlhan"
file_loc <- "data/portal_data_joined.csv" #press tab to find and you can do:
#surveys <- read.csv(file_loc)

?read.csv
surveys <- read.csv("data/portal_data_joined.csv")
nrow(surveys)
ncol(surveys)
dim(surveys)
str(surveys)
class(surveys)
summary(surveys)
summary(surveys$record_id)
summary.data.frame(surveys)
?summary.data.frame

surveys[1,5] #pulls value from  first row, 5th column

#first five rows
1:5
surveys[1:5,] #left the y-axis blank so gives all the columns

surveys[c(1,5,24,3001),] #gives it for only 1st 5th 24th 3001th row for all columns

surveys[,1]
surveys[,1:5]
dim(surveys[,1:5])

dim(surveys[1])

surveys['record_id']

colname(surveys)

cols_to_grab= c('record_id','year', 'day')
cols_to_grab
surveys[cols_to_grab]

surveys[c('record_id','year','day')]
head(surveys)#supposed to show a bit of the beginning rows
head(surveys, n=1) #only shows first row
dim(surveys[c('record_id','year','day')])
head(surveys, 1)

?dim

tail(surveys) #shows the last 6 rows

#these two are the same
head(surveys)
surveys[1:6,]

head(surveys["genus"]) #you get the metadata
head(surveys[["genus"]]) #looks like a vector, you lose the metadata
str(surveys) #shows us that genus is a character vector

head(surveys['genus',]) #all NAs bc no row called genus
head(surveys[,'genus']) 

surveys$genus
survey$hindfoot_length
class(survey$hindfoot_length)
# $ is only for columns

install.packages('tidyverse')
library(tidyverse)

?read_csv
t_surveys<- read_csv('data/portal_data_joined.csv')
class(t_surveys)
t_surveys

survery[,1]
t_surveys[,1]
