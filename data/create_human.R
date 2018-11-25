###########################
#
# Introduction to Open Data Science week 4: Clustering and classification
# Mikko Patronen 25.11.2018
# This file is the script file for week 4 exercise
#
###########################

# Read the provided two datas into R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
summary(hd)

str(gii)
summary(gii)

names(hd)
library(plyr)
rename(hd, c("HDI.Rank"="HDIrank", "Human.Development.Index..HDI."="HDI", "Life.Expectancy.at.Birth"="LifeExp", "Expected.Years.of.Education"="ExpEdu", "Mean.Years.of.Education"="MeanEdu", "Gross.National.Income..GNI..per.Capita"="GNI_cap", "GNI.per.Capita.Rank.Minus.HDI.Rank"="GNI_minus_HDI"))

names(gii)
rename(gii, c("GII.Rank"="GIIrank", "Gender.Inequality.Index..GII."="GII", "Maternal.Mortality.Ratio"="MMratio", "Adolescent.Birth.Rate"="AdBirthRate", "Percent.Representation.in.Parliament"="ReprInParl", "Population.with.Secondary.Education..Female."="SeconEduF", "Population.with.Secondary.Education..Male."="SeconEduM", "Labour.Force.Participation.Rate..Female."="LabForceRateF", "Labour.Force.Participation.Rate..Male."="LabForceRateM"))
