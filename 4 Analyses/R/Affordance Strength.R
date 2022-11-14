####Compute Affordance Strength####
##set up
#load libraries
library(reshape)

#read in data
dat = read.csv("All_responses.csv")

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