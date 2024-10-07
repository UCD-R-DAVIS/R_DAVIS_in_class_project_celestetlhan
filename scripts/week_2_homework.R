set.seed(15) #seems to be some random number generator?
hw2 <- runif(50, 4, 50) #creates a vector of 50 numbers between 4-50
hw2 <- replace(hw2, c(4,12,22,27), NA) #replace the 4th, 12th, 22nd, 27th number with NAs
hw2

?set.seed

prob1<- na.omit(hw2) #remove all the nans in vector which leaves 46 numbers 
prob1

prob1<- prob1[c(14:38)] #only take the numbers between 14-38 inclusive
prob1

times3<- prob1*3
times3

plus10<- times3+10
plus10

plus10[c(1,3,5,7,9,11,13,15,17,19,21,23)]
