####Read in Data####
dat1 = read.csv("USM/USM Cleaned 12_31_22.csv")
dat2 = read.csv("USM/USM Cleaned 12_31_22_2.csv")

##library
library(dplyr)

#colnames(dat1)[4] = "lemma"

colnames(dat1)[1:4] = c("Stimuli.Cue", "affordance_parsed", "word", "lemma")

dat2 = dat2[ , c(1, 3, 5:8)]

##merge
combined = merge(dat1[, c("Stimuli.Cue","affordance_parsed", "word", "lemma", "POS")], dat2,
      by = c("Stimuli.Cue", "affordance_parsed", "word", "lemma"))

#combined = cbind(dat2, dat1[ , 1])

#combined = combined[ c(7, 1:5)]

##restructure the data
combined = combined[ , c(6, 1:4, 7)]

#write.csv(combined, file = "USM Batch 3 Cleaned.csv", row.names = F)
