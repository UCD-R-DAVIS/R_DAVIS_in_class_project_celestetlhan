###WEEK 2.1 INTRO INTO R VIDEO

3+4

4 + 8 * 3^2

#this is a comment

2/1000000
4e3

exp(1) #E^1

exp(3)

log(100) #assumes the base of exp(1)
log(100, base=10)
y <- 1
log(y)

log(10, 100) #base is assumed to be the second number..
#unless you specify like in the next line
log(base=10, x=100) #although we are saying that x=100, because..
#its in a function it doesnt rewrite the x originally being set as 1 a few lines back

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

x <- 1
x <- 3

x = 2 #you could do this but could look confusing for difference statement

x == 5 # is x 5?
x!= 5 # is x not 5?
x > 4 #is x greater than 4?
x < 3 # is x less than 3
x >= 2 # is x greater than or equal to 2?
x <= -1 # is x less than or equal to -1?

x <- x + 1
x
y <- x +2

x + y

#OBJECT NAMING
numSamples <- 50 #r is case sensitive
num_samples <- 50

rm(numSamples)

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





###WEEK 2.2 HOW R THINKS ABOUT DATA (VECTORS)

#vectors and data types

weight <- c(50, 73, 47, 2)
weight

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

#there may be cases where you want to do conditionnal subsetting
#logical vector subsetting

weight <- c(14, 76, 81, 25, 46)
weight [c(TRUE, TRUE, FALSE, FALSE, FALSE)]
weight[weight >50] # this shows you what the numbers are though
#if interested to see which case is over 50 but not the actually number..
weight > 50 # output: "[1] FALSE  TRUE  TRUE FALSE FALSE"

#multiple tests
weight [weight > 50 | weight <20] #| means or
# or you could use:
# & as and
# >= as greater than or equal to
weight [ weight >= 46]




