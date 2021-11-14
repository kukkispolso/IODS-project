#Kukka-Maaria Polso
#14.11.2021
#IODS: Week 2 data wrangling


#Exercise 2
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = T)
str(lrn14) #all variables are integer vectors except for gender, which is a character vector
dim(lrn14) #183 observations for 60 variables


#Exercise 3
library(dplyr)

#combining questions, computing combination variables, and scaling the new variables
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$Deep <- rowMeans(deep_columns)

surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$Surf <- rowMeans(surface_columns)

strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$Stra <- rowMeans(strategic_columns)

#creating an analysis dataset
keep_columns <- c("gender", "Age", "Attitude", "Deep", "Stra", "Surf", "Points")
learning2014 <- select(lrn14, keep_columns)
colnames(learning2014) <- tolower(colnames(learning2014)) #renaming the columns to start with a lowercase letters

#excluding participants with zero points
learning2014 <- filter(learning2014, points > 0)


#Exercise 4
setwd("C:/LocalData/xpoxpox/IODS-project") #setting the working directory
getwd()

#saving the file and reading it again
write.csv(learning2014, file = "C:/LocalData/xpoxpox/IODS-project/data/learning2014.csv", row.names = F)
read.csv("data/learning2014.csv")

#checking what the data looks like
str(learning2014) #why is the type of the combined (and then scaled) variables num, not int? Is that how it should be?
head(learning2014)
