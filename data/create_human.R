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
library(data.table)
setnames(hd, old = c("HDI.Rank", "Human.Development.Index..HDI.", "Life.Expectancy.at.Birth", "Expected.Years.of.Education", "Mean.Years.of.Education", "Gross.National.Income..GNI..per.Capita", "GNI.per.Capita.Rank.Minus.HDI.Rank"), new = c("HDIrank", "HDI", "LifeExp", "ExpEdu", "MeanEdu", "GNI_cap", "GNI_minus_HDI"))
names(hd)

setnames(gii, old = c("GII.Rank", "Gender.Inequality.Index..GII.", "Maternal.Mortality.Ratio", "Adolescent.Birth.Rate", "Percent.Representation.in.Parliament", "Population.with.Secondary.Education..Female.", "Population.with.Secondary.Education..Male.", "Labour.Force.Participation.Rate..Female.", "Labour.Force.Participation.Rate..Male."), new = c("GIIrank", "GII", "MMratio", "AdBirthRate", "ReprInParl", "edu2F", "edu2M", "labF", "labM"))
names(gii)

# Task 5:
gii$edu2FM_ratio <-  gii$edu2F / gii$edu2M
gii$labFM_ratio <- gii$labF / gii$labM

# Task 6:
human <- merge(hd, gii, "Country")
str(human)

# 195 obs and 19 variables :)

write.csv(human, "human.csv", row.names = F)
