####Read in Data####
dat1 = read.csv("USM/USM Cleaned 12_31_22.csv")
dat2 = read.csv("USM/USM Cleaned 12_31_22_2.csv")

##library
library(dplyr)

colnames(dat1)[4] = "lemma"

##merge
combined = semi_join(dat2, dat1, by = c("lemma", "POS"))

#write.csv(combined, file = "USM Cleaned 12_31_22.csv", row.names = F)
