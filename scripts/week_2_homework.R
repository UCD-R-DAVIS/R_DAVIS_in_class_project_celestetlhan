set.seed(15) #seems to be some random number generator?
#set.seed helps so that the runif of random numbers is from the same number distribution
#runif(n, min, max)
hw2 <- runif(50, 4, 50) #creates a vector of 50 numbers between 4-50
hw2 <- replace(hw2, c(4,12,22,27), NA) #replace the 4th, 12th, 22nd, 27th number with NAs
hw2

?set.seed

#take your hw2 vector and remove all the NAs then select all the numbers 
#between 14 and 38 inclusive, call this vecttor prob1

prob1<- na.omit(hw2) #remove all the nans in vector which leaves 46 numbers 
prob1

#OR YOU CAN DO
#hw2[!is.na(hw2)]
#! means is not
#if you do !is.na(hw2), it just tells you true false for if the first value 
#NA, true, is the second value NA, false

#OR YOU CAN DO
#hw2[complete.cases(hw2)]
#use carefully bc only takes one with complete cases


###prob1<- prob1[c(14:38)] #only take the numbers between 14-38 inclusive
###prob1
#going back and archiving these because i misunderstood the question
#i have to take the numbers that are between 14-38 not taking the 
#14th number to the 38th number

#reattempt:

prob1<- prob1[prob1>=14 & prob1<=38]

# or we can combine from the earlier and do:
#prob1<- hw2[!is.na(hw2) & hw2 >= 14 & hw2 <= 38 ]


times3<- prob1*3
times3

plus10<- times3+10
plus10

str(plus10) #this is to look at the structure
class(plus10) # this is to look at the class

#what if you wanted to add two vectors
#cbind(hw2, hw2, hw2+hw2) #this one works
#cbind(hw2, plus10, hw2+plus10) #error bc hw2 and plus10 are not vectors with same length

#to get mean
mean(hw2) #gives na bc theres NAs in hw2
mean(hw2, na.rm = TRUE)




## plus10<- plus10[c(1,3,5,7,9,11,13,15,17,19,21,23)]
##archiving this because theres an easier way which is shown below

plus10 <- plus10[c(TRUE,FALSE)]
plus10

#tells us we want the first number, not the second number..but since this command is shorter
#then the vector so it repeats

