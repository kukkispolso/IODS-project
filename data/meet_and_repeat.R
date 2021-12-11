# Kukka-Maaria Polso
# 9.1.2021
# Week 6 data wrangling
# BPRS data source: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
# RATS data source: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt

# Exercise 1
#load and save BPRS
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
write.csv(BPRS, file = "C:/LocalData/xpoxpox/IODS-project/data/BPRS.csv", row.names = F)

#load and save RATS
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
write.csv(RATS, file = "C:/LocalData/xpoxpox/IODS-project/data/RATS.csv", row.names = F)

#BPRS & RATS: check the column names, structure of the data set, and summaries of the variables
#when longitudinal data is in the wide form, data for each time point is presented in separate columns; all data one individual has provided throughout the time points is in one row
names(RATS)
str(RATS)
summary(RATS)

names(BPRS)
str(BPRS)
summary(BPRS)


# Exercise 2
#convert the categorical variables of both data sets to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# Exercise 3
#Convert BPRS to long form and add a week variable

library(dplyr)
library(tidyr)

BPRSL <-  BPRS %>%
  gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <- BPRSL %>%
  mutate(week = as.integer(substr(weeks,5,5)))

#Convert RATS to long form and add a Time variable
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group)
RATSL <- RATSL %>%
  mutate(Time = as.integer(substr(WD,3,4)))


# Exercise 4
##when longitudinal data is in the long form, all time points are in one column and the corresponding values in another column; each individual has as many rows as there are time points
names(BPRSL)
str(BPRSL)
summary(BPRSL)

names(RATSL)
str(RATSL)
summary(RATSL)

#save
write.csv(BPRSL, file = "C:/LocalData/xpoxpox/IODS-project/data/BPRSL.csv", row.names = F)
write.csv(RATSL, file = "C:/LocalData/xpoxpox/IODS-project/data/RATSL.csv", row.names = F)
