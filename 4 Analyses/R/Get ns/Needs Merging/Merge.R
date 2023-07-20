####Read in Data####
dat1 = read.csv("USM/USM Cleaned 5_14_22.csv")
dat2 = read.csv("USM/USM Cleaned 5_14_22_2.csv")

##library
library(dplyr)

#colnames(dat1)[4] = "lemma"

colnames(dat1)[1:4] = c("Stimuli.Cue", "affordance_parsed", "word", "lemma")

dat2 = dat2[ , c(1, 3, 6:9)]

##merge
combined = merge(dat2, dat1[, c("Stimuli.Cue","affordance_parsed", "word", "lemma", "POS")],
      by = c("Stimuli.Cue","affordance_parsed"))

#combined = cbind(dat2, dat1[ , 1])

#combined = combined[ c(7, 1:5)]

##restructure the data
combined = combined[ , c(3, 1, 2, 7:9)]

#write.csv(combined, file = "USM Batch 2 Cleaned.csv", row.names = F)
