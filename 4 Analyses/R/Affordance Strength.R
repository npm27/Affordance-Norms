####Compute Affordance Strength####
##set up
#load libraries
library(reshape)

#read in data
dat = read.csv("All_responses_FINAL.csv")

##Need to sum each unique response to a cue then divide by all cues
##Will only want to look at verb responses
verbs = subset(dat,
               dat$POS == "VERB")

#Extract all unique cues
cuelist = unique(verbs$CUE)

#ensure alphabetical order
cuelist = sort(cuelist)

#now order verbs dataset alphabetically by cue
verbs2 = verbs[order(verbs$CUE), ]

##Test here
test = subset(verbs2,
              verbs2$CUE == "abacus")

test2 = subset(test,
               test$RESPONSE.LEMMA == "count")

AFS = nrow(test2)/nrow(test)

##Maybe write a loop? Outer loop that moves through cues, inner loop then moves through lemma responses
##at the end of each iteration, write cue, lemma.response, and value to DF?
Affordance_Strength = data.frame(matrix(ncol = 4,nrow = 0, dimnames = list(NULL, c("cue", "response", "AFS", "AFSS"))))

for(i in cuelist){
  
  temp = subset(verbs2,
                verbs2$CUE == i)

  r_list = unique(temp$RESPONSE.LEMMA)
  
  for(j in r_list){
    
    temp2 = subset(temp,
                   temp$RESPONSE.LEMMA == j)
    
    cue = temp2$CUE[1]
    response = temp2$RESPONSE.LEMMA[1]
    AFS = nrow(temp2) / nrow(temp)
    AFSS = length(r_list)
    
    temp3 = data.frame(cue, response, AFS, AFSS)
    
    Affordance_Strength = rbind(Affordance_Strength, temp3)
  }
  
}

##now sort
Affordance_Strength2 = data.frame(matrix(ncol = 4,nrow = 0, dimnames = list(NULL, c("cue", "response", "AFS", "AFSS"))))

for(k in cuelist){
  
  temp4 = subset(Affordance_Strength,
                 Affordance_Strength$cue == k)
  
  temp4 = temp4[order(temp4$AFS, decreasing=TRUE), ]
  
  Affordance_Strength2 = rbind(Affordance_Strength2, temp4)
  
}

#write to file
#write.csv(Affordance_Strength2, file = "Affordance Norms.csv", row.names = F)
