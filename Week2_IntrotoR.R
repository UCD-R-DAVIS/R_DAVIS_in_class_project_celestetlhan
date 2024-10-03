###WEEK 2.1 INTRO INTO R VIDEO

3+4

#order of operations
4 + 8 * 3^2

#this is a comment

#scientific notation
2/1000000
4e3

#mathematical functions
exp(1) #E^1

exp(3)

sqrt(4)

log(100) #assumes the base of exp(1)
log(100, base=10)
log(x=100, base=10)
y <- 1
log(y)

log(10, 100) #base is assumed to be the second number..
#unless you specify like in the next line
log(base=10, x=100) #although we are saying that x=100, because..
#its in a function it doesnt rewrite the x originally being set as 1 a few lines back


#r help files uses the ? before a function
?log


x
y
rm(x) #removes the variable
rm(y) 

#ERRORS
log("word") #words are written in quotes in R
#^ gives an error "Error in log("word") : non-numeric argument to mathematical function"

#WARNINGS
log(-40)
#Warning message: In log(-40) : NaNs produced


#assigning variables
x <- 1
x <- 3
x = 2 #you could do this but could look confusing for difference statement

#six comparison functions
x == 5 # is x 5?
x!= 5 # is x not 5?
x > 4 #is x greater than 4?
x < 3 # is x less than 3
x >= 2 # is x greater than or equal to 2?
x <= -1 # is x less than or equal to -1?

#nested functions
sqrt(exp(4))

x <- x + 1
x
y <- x +2

x + y

#OBJECT NAMING CONVENTION
numSamples <- 50 #r is case sensitive
num_samples <- 50

rm(numSamples)

rm(list=ls()) #removes a bunch of stuff in environment? idk confused

#TAB COMPLETION
#if i just write the number n and hit tab then all the diff
#options of variables that start with n will come up

num_samples

# CHALLENGE
#Which elephant weighs more? Convert one’s weight to the units 
#of the other, and store the result in an appropriately-named new 
#object. Write a bit of code to test whether elephant1 weights
#more than elephant2 (1 kg ≈ 2.2 lb).

elephant1_kg <- 3492
elephant2_lb <- 7757

elephant1_lb <- elephant1_kg*2.2
elephant1_lb
#elephant 7 is bigger


###WEEK 2.2 PROJECT MANAGEMENT
#working directory is an essential part of understanding the project
#youve created -by telling r where it is on ur comp


#the know what your working directory is, use function getwd

getwd()
#returns a file path
#returned "/Users/celestehan/Documents/R-Projects/R_DAVIS_in_class_project_celestetlhan"
# ^this is an absolute file path, there r also relative file paths
?setwd() #for when you wnt to set a file path
#setwd(/Users/celestehan/Documents/R-Projects/R_DAVIS_in_class_project_celestetlhan/INSERT FILE NAME HERE")
d<- read.csv("./data/tail_length.csv")

#relative file paths
#offer a shortcut for calling up file paths on computer
#so theres a data folder in the files window in the bottom right corner of rstudio
#if lets say you want to retrieve something out of this data folder..

# you can use "~/data/" to access any files within the data folder

#good practices for data management
#1. consider your raw data as a readonly file
##in r u can do diff things to data without changing the source data itself

#2. outputs: all of outputs created can be treated as disposable
##means they can be replicated in the future

#3. organizing the folder window in bottom right
##usually prof uses a  data folder and also called scripts folder in the files
##and also a folder for data outputs
##and also a folder for figure outputs/plots

#creates a file called lecture in files window
dir.create("./lecture")



###WEEK 2.2 HOW R THINKS ABOUT DATA (VECTORS)

#vectors and data types

weight <- c(50, 73, 47, 2)
weight
##vector is a series of values
?c

# vector with test
animals <- c("mouse", "horse", "rat")
animals

#additional functions
class(weight) #results say "numeric"
class(animals) #results say "character"
length(weight) #results say 4
length (animals) #results say 3

#str function for structure
str(weight) # results say "num [1:4] 50 73 47 2" 

#change vector
weight <- c(weight, 90) #adds to the end of the vector
weight

weight <- c(3, weight) #adds to the start of the vector
weight


#challenge
#https://ucd-r-davis.github.io/R-DAVIS/lesson_03_how_r_thinks_about_data.html
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)
combined_logical
#as you can see a vector has to have all number or all characters
#therefore vectors have to be the SAME class of values
#chooses lowest common denominator
#coerces values to be all the same, e.g. when TRUE is included


###WEEK 2.4 HOW R THINKS ABOUT DATA (SUBSETTING)
#will learn how to extract specific values out of vectors we created
animals <- c("mouse", "rat", "dog", "cat")
#when R sees a series of values, it starts counting from 1 (python coutns from 0)

#if you want to extract just the second value
animals[2] #use square brackets
#outputs "rat"

animals[c(2,3)] #extracts value 2 and 3
#outputs "rat" "dog"

#you can also create a new series of values based off how u specify these indices

animals[c(2,3,2,3,2,3)]

#conditonal subsetting
#there may be cases where you want to do conditionnal subsetting
#logical vector subsetting

weight <- c(14, 76, 81, 25, 46)
weight [c(TRUE, TRUE, FALSE, FALSE, FALSE)]
weight[weight >50] # this shows you what the numbers are though
#if interested to see which case is over 50 but not the actually number..
weight > 50 # output: "[1] FALSE  TRUE  TRUE FALSE FALSE"

#indexing: takes items from a vector and creates a new combination of values


#symbols
#%in% means within
animals #outputs [1] "mouse" "rat"   "dog"   "cat"  
animals %in% c("rat", "cat", "dog", "duck", "goat")
#outputs [1] FALSE  TRUE  TRUE  TRUE

animals == c("rat", "cat", "dog", "duck", "goat")
#outputs Warning message:
#In animals == c("rat", "cat", "dog", "duck", "goat") :
  #longer object length is not a multiple of shorter object length
#this causes recycling means, means the shorter one is being recycled to match the long one
#the equals equals also matches the first one to the first one
#but the %in% isnt PAIRING its like is this word in the group of words listed?
#but == is MATCHED pairwise

#multiple tests
weight [weight > 50 | weight <20] #| means or
# or you could use:
# & as and
# >= as greater than or equal to
weight [ weight >= 46]




