####Read in Data####
dat1 = read.csv("USM/Affordances 3_17.csv")
dat2 = read.csv("USM/Lemmatized 3_18_22.csv")

##library
library(dplyr)

#colnames(dat1)[4] = "lemma"

colnames(dat1)[1:4] = c("Stimuli.Cue", "affordance_parsed", "word", "lemma")

dat2 = dat2[ , c(1, 4, 7:9)]

##merge
combined = merge(dat2, dat1[, c("Stimuli.Cue","affordance_parsed", "word", "lemma", "POS")],
      by = c("Stimuli.Cue","affordance_parsed", "word", "lemma"))

#combined = cbind(dat2, dat1[ , 1])

#combined = combined[ c(7, 1:5)]

##restructure the data
combined = combined[ , c(5, 1, 2, 3, 4, 9)]

#write.csv(combined, file = "USM 12_31_22 Cleaned.csv", row.names = F)
