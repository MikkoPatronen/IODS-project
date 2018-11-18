# Introduction to Open Data Science -- week 3: Logistic regression
# Mikko Patronen 18.11.2018

# The data consists of two data sets retrieved from the UCI Machine Learning Repository
# from Student performance dataset at https://archive.ics.uci.edu/ml/datasets/Student+Performance).
# Source: professor Paulo Cortez, University of Minho, Guimares, Portugal, http://www3.dsi.uminho.pt/pcortez 

# Read both datasets into R

math <- read.csv("student-mat.csv", header = TRUE, sep=";")
str(math)
dim(math)

# Math dataset has 395 observations of 33 variables

por <- read.csv("student-por.csv", header = TRUE, sep=";")

str(por)
dim(por)

# Por dataset has 649 observations of 33 variables

# access dplyr
library(dplyr) 

# vector of variables
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the datasets by selected variables 
math_por <- inner_join(math, por, by = join_by)
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

colnames(math_por)

# let's take a glimpse
glimpse(math_por)

# Math_por dataset has 382 observations of 53 variables

# Create a new data frame with joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...

for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# Let's glimpse the combined data
glimpse(alc)

# alc consists of 382 observations and 33 variables


# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc['alc_use']

# access ggplot2
library(ggplot2)

# plot of alcohol use
g1<-ggplot(data = alc, aes(x = alc_use))
g1

# plot as a bar plot
g1 <- g1 + geom_bar(aes(fill=sex))
g1


# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)
alc['high_use']

# create a plot of 'high_use'
g2 <- ggplot(data = alc, aes(x = high_use))
g2

# Drawing a bar plot of high_use by sex
g2 <- g2 + geom_bar(aes(fill=sex))+facet_wrap(~sex)
g2

## glimpse of allc
glimpse(alc)

# 382 observations and 35 variables

## Saving the file
write.csv(alc, file="alc.csv", row.names = F)




