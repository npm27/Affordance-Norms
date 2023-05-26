####Set up####
##libraries
library(reshape)
library(psych)
library(dplyr)

##turn off scientific notation
options(scipen = 999)

##read in data
boi = read.csv("Data/Pexman BOI Norms.csv")
aff = read.csv("Data/Affordance Norms.csv")
fsg = read.csv("Data/Nelson Norms.csv")

####Get the strongest affordance pairing for each cue####
##use a loop?
temp = data.frame()

cuelist = unique(aff$cue)

for(i in cuelist){
  
  temp2 = subset(aff,
                 aff$cue == i)
  
  temp2 = temp2[1, ]
 
  temp = rbind(temp2, temp)
   
}

aff2 = temp

##some descriptives
mean(aff2$AFS)
mean(aff2$AFSS)

cor.test(aff2$AFS, aff2$AFSS) ##Not too surprising that the bigger the set size, the lower the AFS

####Okay, correlation between highest AFS and BOI?####
##merge the datasets
colnames(boi)[1] = "cue"

combined = merge(aff2, boi[ , -2], by = "cue")

##now run the correlation
cor.test(combined$AFS, combined$Mean) #again, a weak correlation

####What about association strength?####
##Looking at the subset
colnames(combined)[1:2] = c("CUE", "TARGET")

combined$CUE = toupper(combined$CUE)
combined$TARGET = toupper(combined$TARGET)

combined2 = merge(combined, fsg, by = c("CUE", "TARGET"))

cor.test(combined2$AFS, combined2$FSG) #.19

##Looking at the full AFS dataset
aff$cue = toupper(aff$cue)
aff$response = toupper(aff$response)

colnames(aff)[1:2] = c("CUE", "TARGET")

combined3 = merge(aff, fsg, by = c("CUE", "TARGET"))

cor.test(combined3$AFS, combined3$FSG)

mean(combined3$AFSS)
mean(combined3$QSS)

