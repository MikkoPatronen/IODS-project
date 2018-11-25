###########################
#
# Introduction to Open Data Science week 4: Clustering and classification
# Mikko Patronen 25.11.2018
# This file is the script file for week 4 exercise
#
###########################

# Read the provided two datas into R

# Tasks 1 and 2:
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Task 3:
str(hd)
summary(hd)

str(gii)
summary(gii)

# Task 4:
library(plyr)
names(hd)
rename(hd, c("HDI.Rank"="HDIrank", "Human.Development.Index..HDI."="HDI", "Life.Expectancy.at.Birth"="LifeExp", "Expected.Years.of.Education"="ExpEdu", "Mean.Years.of.Education"="MeanEdu", "Gross.National.Income..GNI..per.Capita"="GNI_cap", "GNI.per.Capita.Rank.Minus.HDI.Rank"="GNI_minus_HDI"))

names(gii)
rename(gii, c("GII.Rank"="GIIrank", "Gender.Inequality.Index..GII."="GII", "Maternal.Mortality.Ratio"="MMratio", "Adolescent.Birth.Rate"="AdBirthRate", "Percent.Representation.in.Parliament"="ReprInParl", "Population.with.Secondary.Education..Female."="edu2F", "Population.with.Secondary.Education..Male."="edu2M", "Labour.Force.Participation.Rate..Female."="labF", "Labour.Force.Participation.Rate..Male."="labM"))

# Task 5:
mutate(gii, edu2FM_ratio = edu2F / edu2M)
mutate(gii, labFM_ratio = labF / labM)

# Task 6:
human <- merge(hd, gii, "Country")
str(human)
