#################################################################################
#                       Mikko Patronen 9.12.2018                                #
#                                                                               #
#   Introduction to Open Data Science week 6: Analysis of longitudinal data     #
#                                                                               # 
#       This file is the script file for week 6 data wrangling exercise         #
#                                                                               #
#################################################################################

# This week we are going to be using two datasets which are downloaded from:
# BPRS: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
# RATS: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt

rm(list=ls())
library(dplyr)
library(stringr)
library(ggplot2)
library(GGally)
library(tidyr)

# 1: Import the data and explore variable names, structure and summary of the data
#
# BPRS:
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
names(BPRS)
str(BPRS)
summary(BPRS)

# RATS:
RATS<-read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt",header = T,sep = "\t")
names(RATS)
str(RATS)
summary(RATS)

# The BPRS data consists of 40 subjects that are divided into two treatment groups. All subjects have been rated on BPRS (brief psychiatric rating scale) for 8 weeks in total.

# The RATS data consists of three groups of rats. The groups got different diets and their weight in grams were measured weekly for nine weeks.


# 2: Convert categorical variables to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# 3: Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS.
BPRSL <- BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <- BPRSL %>% mutate(week = as.integer(substr(BPRSL$week,5,10)))

RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD,3,4)))


# 4: Compare the differences of both dataset's wide and long forms
dim(BPRS)
dim(BPRSL)

summary(BPRS)
summary(BPRSL)

dim(RATS)
dim(RATSL)

summary(RATS)
summary(RATSL)

# In the BPRS data, where the wide version has weeks as columns, the long version has weeks as rows.
# In RATS data the wide version has WD variable as columns and in the wide version they are rows.
# In both cases the long version is "long" in the sense that the dataset has more rows and fewer columns than the wide version.
# The BPRS wide version has dimension (40 | 11) and long version has dimension (360 | 5).
# The RATS wide version has dimension (16 | 13) and long version has dimensions (176 | 5).

# Save datasets:
write.table(RATSL, file = "RATSL.txt")
write.table(BPRSL, file = "BPRSL.txt")
