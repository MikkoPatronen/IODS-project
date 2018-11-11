#
# IODS - Assignment 2
#
# Mikko Patronen
# November 6th 2018
#
# This is the R-script file for the assignment 2
# The data for this excercise is downloaded from http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

dim(lrn14)

str(lrn14)

# The data consists of 183 rows (observations) and 60 columns (variables).
# The variables are such as "Age", "Attitude", "Points", "Gender" etc.

library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# see the stucture of the new dataset
str(learning2014)

# change the name of "Age" to "age"
colnames(learning2014)[2] <- "age"

# change the name of "Attitude" to "attitude"
colnames(learning2014)[3] <- "attitude"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0)
str(learning2014)

setwd("/Users/mikko/Documents/GitHub/IODS-project/data")

write.csv(learning2014, file = "learning2014.csv", row.names = F)
learning2014 <- read.csv(file = "learning2014.csv", header = T, sep=",")
str(learning2014)
head(learning2014)

###############################################################################################
# The data consist of 166 rows (observations) and 7 columns (variables).
# The variables are "gender","age","attitude", "deep", "stra", "surf" and "points" and they are
# a subset of all the variables of the data: "international survey of Approaches to Learning".

summary(learning2014)

# draw a scatter plot matrix of the variables in learning2014.
# [-1] excludes the first column (gender)
pairs(learning2014[-1], col = learning2014$gender)

# access the GGally and ggplot2 libraries
library(GGally)
library(ggplot2)

# create a more advanced plot matrix with ggpairs()
p <- ggpairs(learning2014, mapping = aes(col=gender, alpha=0.3), lower = list(combo = wrap("facethist", bins = 20)))

# draw the plot
p

##########################################################################

# initialize plot with data and aesthetic mapping
p1 <- ggplot(learning2014, aes(x = attitude, y = points, col = gender))

# define the visualization type (points)
p2 <- p1 + geom_point()

# draw the plot
p2

# add a regression line
p3 <- p2 + geom_smooth(method = "lm")

# add a main title and draw the plot
p4 <- p3 + ggtitle("Student's attitude versus exam points")

##########################################################################

# a scatter plot of points versus attitude
library(ggplot2)
qplot(attitude, points, data = learning2014) + geom_smooth(method = "lm")

# fit a linear model
my_model <- lm(points ~ attitude + stra + surf, data = learning2014)

# print out a summary of the model
summary(my_model)

# fit a linear model
my_model <- lm(points ~ attitude + stra, data = learning2014)

# print out a summary of the model
summary(my_model)

# fit a linear model
my_model <- lm(points ~ attitude, data = learning2014)

# print out a summary of the model
summary(my_model)


##########################################################################

