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