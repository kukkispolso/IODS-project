# Kukka-Maaria Polso
# 21.11.2021
# Week 3 data wrangling (logistic regression)
# Data from https://archive.ics.uci.edu/ml/datasets/Student+Performance

#Exercise 3
#reading and saving the data
setwd("C:/LocalData/xpoxpox/IODS-project/data")
mat <- read.csv("student-mat.csv", sep = ";", header = T)
por <- read.csv("student-por.csv", sep = ";", header = T)

#exploring the structure and dimensions
str(mat)
dim(mat)
str(por)
dim(por)


#Exercise 4
# Define own id for both datasets
library(dplyr)
por_id <- por %>% mutate(id=1000+row_number()) 
mat_id <- mat %>% mutate(id=2000+row_number())

# Which columns vary in datasets
free_cols <- c("id","failures","paid","absences","G1","G2","G3")

# The rest of the columns are common identifiers used for joining the datasets
join_cols <- setdiff(colnames(por_id),free_cols)

pormat_free <- por_id %>% bind_rows(mat_id) %>% select(one_of(free_cols))

#combining the two datasets
pormat <- inner_join(por_id, mat_id, by = join_cols, suffix = c(".por", ".mat"))

str(pormat)
dim(pormat) #There are 370 obs


#Exercise 5
#defining values of the combined variables
for(column_name in free_cols) {
  # select two columns from 'pormat' with the same original name
  two_columns <- select(pormat, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    pormat[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    pormat[column_name] <- first_column
  }
}


#Exercise 6
#adding variables for average alcohol consumption and high use
pormat <- pormat %>%
  mutate(alc_use = (Dalc + Walc) / 2,
         high_use = alc_use > 2)


#Exercise 7
#taking a look and then saving the data
glimpse(pormat)
write.csv(pormat, file = "C:/LocalData/xpoxpox/IODS-project/data/pormat.csv", row.names = F)
