# Kukka-Maaria Polso
# 29.11.2021
# Week 4 data wrangling for week 5, continuing at week 5 (the human data)
# Data source: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt

# Week 4 exercises

#Week 4, Exercise 2
#read the data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Week 4, Exercise 3
#explore the data
str(hd)
dim(hd)
summary(hd)
str(gii)
dim(gii)
summary(gii)

#Week 4, Exercise 4
#rename the variables according to the meta file information (http://hdr.undp.org/en/content/human-development-index-hdi)
library(dplyr)
gii <- gii %>%
  rename(giirank = GII.Rank,
         country = Country,
         gii = Gender.Inequality.Index..GII.,
         matdeath = Maternal.Mortality.Ratio,
         teenmom = Adolescent.Birth.Rate,
         propparl = Percent.Representation.in.Parliament,
         f2ed = Population.with.Secondary.Education..Female.,
         m2ed = Population.with.Secondary.Education..Male.,
         flab = Labour.Force.Participation.Rate..Female.,
         mlab = Labour.Force.Participation.Rate..Male.)
hd <- hd %>%
  rename(hdirank = HDI.Rank,
         country = Country,
         hdi = Human.Development.Index..HDI.,
         lifeexp = Life.Expectancy.at.Birth,
         edexp = Expected.Years.of.Education,
         edmean = Mean.Years.of.Education,
         gni = Gross.National.Income..GNI..per.Capita,
         gni_hdirank = GNI.per.Capita.Rank.Minus.HDI.Rank)

#Week 4, Exercise 5
#create variables for ratio of females and males in 2nd education and labour force
gii <- gii %>%
  mutate(ratio2ed = f2ed/m2ed,
         ratiolab = flab/mlab)

#Week 4, Exercise 6
#join datasets and save it
human <- inner_join(gii, hd, by = "country")
write.csv(human, file = "C:/LocalData/xpoxpox/IODS-project/data/human.csv", row.names = F)



# Week 5 exercises

human <- read.csv("C:/LocalData/xpoxpox/IODS-project/data/human.csv")
str(human)
dim(human)

# The human data consist of 195 observations of 19 variables. Each observation represents a country or a geographical region.
# Two datasets are combinated in the human data: one that concentrates on factors related to the Gender Inequality Index (GII) and another one relating to the Human Development Index (HDI).
# Variable descriptions: see Exercises 4 and 5 above

#Week 5, Exercise 1
#mutate the gni variable so that commas no longer exist within the values and change the type to numeric
library(stringr)
human$gni <- str_replace(human$gni, pattern=",", replace ="") %>% as.numeric()

#Week 5, Exercise 2
#exclude unneeded variables from a new dataset, human2

keep <- c("country", "ratio2ed", "ratiolab", "lifeexp", "edexp", "gni", "matdeath", "teenmom", "propparl")
human2 <- select(human, one_of(keep))

#Week 5, Exercise 3
#remove rows with missing values

# print out a completeness indicator of the 'human' data
complete.cases(human2)

# filter out all rows with NA values
human3 <- filter(human2, complete.cases(human2))

#Week 5, Exercise 4
#remove the observations which relate to regions instead of countries

#the last 7 observations are not countries but regions
tail(human3, 10)

# define the last indice we want to keep
last <- nrow(human3) - 7

# choose everything until the last 7 observations
human4 <- human3[1:last, ]

#Week 5, Exercise 5
#add countries as rownames and remove the variable country
rownames(human4) <- human4$country #add
human4 <- human4[-1] #remove

#save
write.csv(human4, file = "C:/LocalData/xpoxpox/IODS-project/data/human.csv", row.names = T)
