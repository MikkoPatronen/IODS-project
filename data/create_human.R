###########################
#
# Introduction to Open Data Science week 4: Clustering and classification 
# AND
# week 5: 
# Mikko Patronen 2.12.2018
# This file is the script file for week 4 and week 5 data wrangling exercise
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
setnames(hd, old = c("HDI.Rank", "Human.Development.Index..HDI.", "Life.Expectancy.at.Birth", "Expected.Years.of.Education", "Mean.Years.of.Education", "Gross.National.Income..GNI..per.Capita", "GNI.per.Capita.Rank.Minus.HDI.Rank"), new = c("HDI.Rank", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", "GNI", "GNI.Minus.Rank"))
names(hd)

setnames(gii, old = c("GII.Rank", "Gender.Inequality.Index..GII.", "Maternal.Mortality.Ratio", "Adolescent.Birth.Rate", "Percent.Representation.in.Parliament", "Population.with.Secondary.Education..Female.", "Population.with.Secondary.Education..Male.", "Labour.Force.Participation.Rate..Female.", "Labour.Force.Participation.Rate..Male."), new = c("GII.Rank", "GII", "Mat.Mor", "Ado.Birth", "Parli.F", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M"))
names(gii)

# Task 5:
gii$Edu2.FM <-  gii$Edu2.F / gii$Edu2.M
gii$Labo.FM <- gii$Labo.F / gii$Labo.M

# Task 6:
human <- merge(hd, gii, "Country")
str(human)

# 195 obs and 19 variables :)

write.csv(human, "human.csv", row.names = F)



###########################################################################################################
#                                                                                                         #
#                             WEEK 5 DATA WRANGLING TASKS BEGIN HERE                                      #
#                                                                                                         #
###########################################################################################################

# Load the human data in R
human <- read.csv("human.csv", header = TRUE, sep=",")

# Explore structure and dimensions of the data
str(human)
dim(human)

# The dataset "Human" contains 195 observations of 19 variables.
# It originates from the United Nations Development Programme and contains 
# important dimensions about development of countries.
#
# Some variables from the data:
#'GNI' (Gross National Income per capita)
# 'Life.Exp' (life expectancy)
# 'Edu.Exp' (expected amount of years in school)
# 'Mat.Mor' (maternal mortality ration)
# 'Ado.Birth' (birth rate)
# 'Parli.F' (number of females in parliament (per cent))
# 'Edu2.F' (numner of females in secondary education (per cent)
# 'Edu2.M' (number of males in secondary education (per cent)
# 'Edu2.FM' ('Edu2.F'/'Edu2.M')
# 'Labo.F' (number of females in the labour force (per cent))
# 'Labo.M' (number of males in the labour force (per cent))
# 'Labo.FM' ('Labo.F'/'Labo.M')

library(stringr)
# 1.	Mutating the data: transform the Gross National Income (GNI) variable to numeric
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

# Keep only selection of columns
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

human <- select(human, one_of(keep))

# Remove all rows with missing values
human <- filter(human, complete.cases(human))

# Explore the variable "country"
human$Country

# Somehow my data is ordered the same way as the data in Datacamp exercise - the countries in my data are listed alphabetically and therefore the last 7 rows are not the same as in Datacamp. 
# So I can not use the code from Datacamp. Instead:

# There are 7 areas that are regions:
# Arab States (row 4)
# East Asia and the Pacific (row 44)
# Europe and Central Asia (row 50)
# Latin America and the Caribbean (row 81)
# South Asia (row 132)
# Sub-Saharan Africa (row 135)
# World (row 159)

# Remove the rows of those areas
human_ <- human[c(-4, -44, -50, -81, -132, -135, -159), ]

# Define the row names of the data by the country names and remove the country name column from the data.
rownames(human_) <- human_$Country
human <- select(human_, -Country)

# Glimpse the results
glimpse(human) 
# There are 155 observations and 8 variables, as expected!

rownames(human)
# Rownames are working also

# Save the data
write.csv(human, file="human.csv", row.names = T)


