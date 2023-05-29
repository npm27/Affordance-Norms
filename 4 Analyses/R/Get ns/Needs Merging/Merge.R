####Read in Data####
dat1 = read.csv("USM/No_duplicates_5_24.csv")
dat2 = read.csv("USM/Cleaned_5_14_22_2.csv")

##library
library(dplyr)

colnames(dat1)[4] = "lemma"

##merge
combined = semi_join(dat2, dat1, by = c("lemma", "POS"))

#write.csv(combined, file = "USM Cleaned batch 2.csv", row.names = F)
