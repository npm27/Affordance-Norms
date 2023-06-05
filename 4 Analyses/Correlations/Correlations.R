####Set up####
##read in data
affs = read.csv("Data/Affordance Norms_fsg.csv")
cue_table = read.csv("Data/Cue Table.csv")

##load libraries
library(psych)
library(dplyr)

##scientific notation
options(scipen = 999)

####Correlations####
##make the subsets
fsg = subset(affs,
             is.na(affs$FSG) == F )

cos = subset(affs,
             is.na(affs$COS) == F )

###Correlations w/ double word norms
##FSG
cor.test(fsg$AFS, fsg$FSG) #.19
cor.test(fsg$AFSS, fsg$FSG) #-.08

##COS
cor.test(cos$AFS, cos$COS) #.12
cor.test(cos$AFSS, cos$COS) #-.10

####Set up for Single Word Norms and strongest AFS Pairs####
##get the strongest affordance pairing
temp = data.frame()

cuelist = unique(affs$Cue)

for(i in cuelist){
  
  temp2 = subset(affs,
                 affs$Cue == i)
  
  temp2 = temp2[order(temp2$AFS, decreasing = TRUE),]  
  
  temp2 = temp2[1, ]
  
  temp = rbind(temp2, temp)
  
}

aff2 = temp

####Strongest AFS Pairs####
##build subsets
fsg2 = subset(aff2,
              is.na(aff2$FSG) == F)

cos2 = subset(aff2,
              is.na(aff2$COS) == F)

##merge w/ lexical variables

###Semantic Correlations
##FSG
cor.test(fsg2$AFS, fsg2$FSG) #.18
cor.test(fsg2$AFSS, fsg2$FSG) #-.03

##COS
cor.test(cos2$AFS, cos2$COS) #-.09
cor.test(cos2$AFSS, cos2$COS) #-.08

###Lexical Correlations
##strongest affordance
cue_table$cues = tolower(cue_table$cues)
aff2$Cue = tolower(aff2$Cue)

combined = merge(aff2, cue_table, by.x = "Cue", by.y = "cues")

##set size
cor.test(combined$AFSS, combined$BOI) #.13 #BOI
cor.test(combined$AFSS, combined$Concrete) #.09 #CONCRETE
cor.test(combined$AFSS, combined$SUBTLEX) #.30 #SUBTLEX
cor.test(combined$AFSS, combined$AoA) #-.25 #AoA 

#Strongest AFS
cor.test(combined$AFS, combined$BOI) #.10 #BOI
cor.test(combined$AFS, combined$Concrete) #.07 #CONCRETE
cor.test(combined$AFS, combined$SUBTLEX) #-.11 #SUBTLEX
cor.test(combined$AFS, combined$AoA) #.01 #AOA #Non-sig
