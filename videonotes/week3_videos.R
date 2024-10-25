#WEEK 3 VIDEOS

#creates a file called lecture in files window
dir.create("./videonotes")

#WEEK 3.1 VECTOR MATH

x<- 1:10
x

x+3 #adds 3 to each vector 
#^its adding two different vectors together and 3 is a single number that is recycled
#you cld also do:
x + c(3)
x*10

#lets say were doing this with two vectors of the same length
y <- 100:109
y

x+y
#this creates a pair from index of 1 of first vector x and index of 1 of first vector y

cbind(x,y, x+y)
#bc theyre all the same length they all light up really well - creates three columns of the three vectors

z <- 1:2

x+ z
#because z is a different length than x, it repeats through each number in z until it has a
#a number available for each index in x
cbind (x, z, x+z)

z<- 1:3
cbind(x, z, x+z)
#Warning messages:
#1: In x + z :
#  longer object length is not a multiple of shorter object length
#2: In cbind(x, z, x + z) :
#  number of rows of result is not a multiple of vector length (arg 2)

#^ we get warning message because 3 is not a perfect multiple of 10
#so what r does is repeat z until it reaches the end of the longer vector

#lets try to see what happens when we try to save the two vectors
a<- x+ z
#Warning message:
#In x + z : longer object length is not a multiple of shorter object length

#you can also index a vector based on logical values
x[c(TRUE,FALSE)] # this selects every other value in x
x[c(TRUE, FALSE, FALSE)]


#WEEK 3.2: MISSING VALUES

#missing data
#r recognizes na  as a special character for identifying msising data

# NA and NaN are same in R

#if you use quotations around NA then r will see it as a text or string and so 
#wont recognise as a missing value

heights <- c(2, 4, 4, NA, 6)

mean(heights) #gives us NA
max(heights) #give us NA
sum(heights) #gives us NA

mean(heights, na.rm = TRUE) #the na.rm tells r to remove the NA values if its set to true
mean (heights, na.rm = T) #the T works too

#another way to get rid of missing data is to extract out the various elements that are missing from a vector
is.na(heights) #gives us the logical values for if there is an na or not in the vector
#prints out:
#[1] FALSE FALSE FALSE  TRUE FALSE
#also a symbol ! which tells r to invert the function so to select the opposite

!is.na(heights)
#prints out
#[1]  TRUE  TRUE  TRUE FALSE  TRUE

heights[!is.na(heights)]
#prints out
#[1] 2 4 4 6

#theres also a function called complete cases which will return an object
#that has only values where there is the full information available
#you might need this when u have a dataset you want to use in a model and
#your model only will include observations that have a value for every variable in the model
#so this function can be used to create a subset with no NAs
heights[complete.cases(heights)]
#prints out
#[1] 2 4 4 6




#WEEK 3.3: OTHER DATA TYPES

###lists
#lists are a data type that is constructed of multiple vectors
#it can have diff data types or diff data lengths
#essentially its multiple vectors in one object

list(4, 6, "dog")
#this spits out:
#[[1]]
#[1] 4

#[[2]]
#[1] 6

#[[3]]
#[1] "dog"

#which is diff from when we did:
c(4, 6, "dog")
#which gives:
#[1] "4"   "6"   "dog"

#so you can see  the list gives us three separate vectors 
#whereas the c function gives us a single vector (in the same row)

a <- list(4, 6, "dog")
class(a) #outputs [1] "list"
str(a) #str is for structure 
#outputs:
#List of 3
#$ : num 4
#$ : num 6
#$ : chr "dog"
#so str tells us the type of data that each vector has aka numberical or character

#lets say we wanted to create a list with diff lengths of vectors
b<- list(4, letters, "dog" ) #letters is a built of diff values in r
str(b)
#outputs:
#List of 3
#$ : num 4
#$ : chr [1:26] "a" "b" "c" "d" ...
#$ : chr "dog"
length(b)
#gives us [1] 3 which means there are 3 sep elements in this list

#but if we wanted to look at specifically the length of  one of the intteriors that 
#make up the list, then  we can use two [] brackets to take an inside look
length(b[[2]])
#so to look at the length of letters we put 2 bc thats the index vlaue for letters in the list
#which outputs:
# [1] 26


###dataframes

#dataframes are one of the most common data types that youll work with 
#essentially like picky lists 
#you can have diff data variables in a dataframe but they all have to be the saem length

letters

#^so we have the vector letters with 26 values
#if we want to turn this into a data frame...we can do

data.frame(letters)
df<- data.frame(letters)
length(df) #outputs 1 
dim(df) #outputs two number: 26 1 ...first number is the num of rows and second is the columns
nrow(df) #isolates just the num of rows
ncol(df) #isolates the num of columns

#lets say we wanted to create a df with two colummns

df2<- data.frame(letters, letters)
str(df2)
dim(df2)

#lets jump back to the topic of recylcing in regards to dataframes
data.frame(letters, "dog")
data.frame(letters, 1)
data.frame(letters, 1:2)
data.frame(letters, 1:3)
#^this one gives a letter bc 1-3 isnt a factor for letters which is 26 values

###matrices
matrix(nrow=10, ncol=10)
#^no info filled just num of rows and cols so if i wanted to fill in with values...
matrix(1:10, nrow=10, ncol=10)
#it counts 1-10 in each of the columns so it starts at 1 for every column which means
#every row is the same number (goes up down up etc)

#if you wanted it to be the opposite you can use byrow like this:
matrix(1:10, nrow=10, ncol=10, byrow= TRUE)

#so you might want to subset specific infomration out of the atrix..
#so lets save matrix:
m<-matrix(1:10, nrow=10, ncol=10, byrow= TRUE)
#if i wanted to extract the third value in the first row...
m[1,3]
#you can also use c to extract multiple values:...
m[c(1,2), c(5,6)]

###arrays
#three-dimentional with x,y,z value

###factors
#factors are like fancy characters, characters but wiht some sort of level value or order to them
response <- factor(c("no", "yes", "maybe", "no","maybe", "no"))
class(response)
levels(response)
nlevels(response)
typeof(response)
#type of tells us its an integer not a character bc r sees it as a number and a level
response 
#outputs:
#[1] no    yes   maybe no    maybe no   
#Levels: maybe no yes
#organises the level by alphabetical order

#we might want to change the order of the levels

response <- factor(response, levels = c("yes", "maybe", "no"))
response
#this might help for lets say were doign a plot, like ggplot and you want to order them,
#you can use factor to order them

###convert a factor

#to convert to a character
as.character(response)

#this may be an issue when working with numbers
#lets say we have some years

year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))
year_fct
#outputs:
#[1] 1990 1983 1977 1998 1990
#Levels: 1977 1983 1990 1998

#lets say we wanted to convert this to a numberic
as.numeric(year_fct)
#outputs:
#[1] 3 2 1 4 3
#^gives us the levels
#so to work around this use as.character first before you do as.numeric
as.numeric(as.character(year_fct))

###renaming the different levels
levels(response)
#outputs:
#[1] "yes"   "maybe" "no"  
levels(response)[1] <- "YES"
response
#outputs:
#[1] no    YES   maybe no    maybe no   
#Levels: YES maybe no
#this renamed the first level of the response factor to be YES and not yes

#theres a way to change the name of all three:
levels(response) <- c("YES", "MAYBE", "NO")
response



#WEEK 3.4: ACCESSING SPREADSHEETS
surveys <- read.csv("data/portal_data_joined.csv")
str(surveys)
surveys
class(surveys)

nrow(surveys)
ncol(surveys)
str(surveys)

head(surveys)
tail(surveys)
head(surveys, n=3)

summary(surveys)
surveys$sex
summary.data.frame(surveys)

#now lets pivot to actually extracting things from dataframe
surveys[1,3] #row 1 column 3
surveys[1,] #row 1 column all
surveys[,1] #all rows column 1
surveys[1] #assumes its all rows first column
head(surveys[1]) #gives the first few rows of first column

surveys[1:3,]#first 3 rows, all columns
surveys[c(1,4,10), c(2,4,6)] #rows 1,4,10 and columns 2,4,6

surveys[,-1] #all rows and all columns without the first column

7:nrow(surveys)# row 7 to the very last observation of the dataframe
surveys[-c(7:nrow(surveys)),] #this is same as head(surveys) because youre basically saying remove every single row from 7 to the end

#with a dataframe you can also index by the name of a column
surveys["genus"]
head(surveys["genus"])
head(surveys[,"genus"])

class(head(surveys["genus"])) #outputs dataframe
class(head(surveys[,"genus"])) #outputs character
#the above two lines shows the same info but in differenct format because the first way of accessing the column in the one above where you just open braket and provide the string and close braket, is that r subsets the dataframe for just that value-- whereas if you index like the second line, where u say give me all the rows in the genus value, r returns all those values and not the dataframe 
#a final way of doing this is to use double braket
surveys[["genus"]] #which is same as surveys[,"genus"]

surveys$record_id

library(tidyverse)
t_surveys <- read_csv("data/portal_data_joined.csv")
t_surveys






