# Kukka-Maaria Polso
# 29.11.2021
# Week 4 data wrangling for week 5

#Exercise 2
#read the data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Exercise 3
#explore the data
str(hd)
dim(hd)
summary(hd)
str(gii)
dim(gii)
summary(gii)

#Exercise 4
#rename the variables according to the meta file information (http://hdr.undp.org/en/content/human-development-index-hdi)
library(dplyr)
gii <- gii %>%
  rename(giirank = GII.Rank,
         country = Country,
         ineq = Gender.Inequality.Index..GII.,
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

#Exercise 5
#create variables for ratio of females and males in 2nd education and labour force
gii <- gii %>%
  mutate(ratio2ed = f2ed/m2ed,
         ratiolab = flab/mlab)

#Exercise 6
#join datasets and save it
human <- inner_join(gii, hd, by = "country")
write.csv(human, file = "C:/LocalData/xpoxpox/IODS-project/data/human.csv", row.names = F)
