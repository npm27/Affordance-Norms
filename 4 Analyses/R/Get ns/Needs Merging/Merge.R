####Read in Data####
dat1 = read.csv("UCONN/UCONN  Cleaned 12_29_22.csv")
dat2 = read.csv("UCONN/UCONN  Cleaned 12_29_22_2.csv")

##library
library(dplyr)

#colnames(dat1)[2] = "affordance_parsed"

##merge
combined = semi_join(dat2, dat1, by = c("affordance_parsed", "POS"))

#write.csv(combined, file = "UCONN Cleaned 12_29_22.csv", row.names = F)
