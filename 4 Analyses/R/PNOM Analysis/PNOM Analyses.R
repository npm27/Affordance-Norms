####Set up####
##libraries
library(reshape)
library(psych)
library(dplyr)

##read in data
boi = read.csv("Data/Pexman BOI Norms.csv")
aff = read.csv("Data/Affordance Norms.csv")
con = read.csv("Data/Brysbaert Con Norms.csv")

##get the aff set sizes and unique items
aff2 <- aff[ , -c(2:3)] %>%
  arrange(cue, -AFSS) %>%
  filter(duplicated(cue) == FALSE)

##merge affordance data w/ boi and test for correlation
colnames(boi)[1] = "cue"

combined = merge(aff2, boi[ , -2], by = "cue")

corr.test(combined$AFSS, combined$Mean)

plot(combined$AFSS, combined$Mean)

##merge affordance data w/ con and test for correlation
colnames(con)[1] = "cue"

combined2 = merge(aff2, con, by = "cue")

corr.test(combined2$AFSS, combined2$Conc.M) #concreteness

plot(combined2$AFSS, combined2$Conc.M)


