#! /usr/bin/env Rscript

# read the key-value pairs
calls <- read.csv("output.txt", header=FALSE, sep="\t")
names(calls) <- c("date", "call.length")
head(calls)

attach(calls)
# attach the calls data frame so we use the names directly
date <- as.factor(date)

# make a histogram of the call lengths
# look in M1_DataTools for the plot
hist(call.length)

# compute the mean of `call.length` by date
call.length.means <- tapply(call.length, date, mean)
# naming the months would be more difficult in genreal since we would not 
# know the number of months
names(call.length.means) <- c("date 1", "date 2")

call.length.means

