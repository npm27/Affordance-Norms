##read in dataset
dat = read.csv("demo_table.csv")

##load libraries
library(memisc)

#fix numerics
dat$Age = as.numeric(dat$Age)

tapply(dat$Age, dat$site, mean, na.rm = T)
tapply(dat$Age, dat$site, sd, na.rm = T)
tapply(dat$Gender, dat$site, percent, na.rm = T)

#Prolific
prolific = subset(dat,
                  dat$site == "Prolific")

prolific$Country = tolower(prolific$Country)

prolific.us = subset(prolific,
                     prolific$Country == "us" | prolific$Country == "united states" |
                       prolific$Country == "united states " | prolific$Country == "usa" |
                       prolific$Country == "united states of america" | prolific$Country == "united states america" |
                       prolific$Country == "canada")

prolific.uk = subset(prolific,
                     prolific$Country != "us" | prolific$Country != "united states" |
                       prolific$Country != "united states " | prolific$Country != "usa" |
                       prolific$Country != "united states of america" | prolific$Country != "united states america" |
                       prolific$Country != "canada")

mean(prolific.us$Age, na.rm = T); sd(prolific.us$Age, na.rm = T)
percent(prolific.us$Gender, na.rm = T)

mean(prolific.uk$Age, na.rm = T); sd(prolific.uk$Age, na.rm = T)
percent(prolific.uk$Gender, na.rm = T)
