####Need the total number of times the response occurred, divided by the total number of participants who provided a response to the cue
ns = read.csv("affordance ns.csv")
responses = read.csv("All_responses_FINAL.csv")

library(memisc)
options(scipen = 999)

##filter out dropped items
ns$Cue = tolower(ns$Cue)
final_cues = ns$Cue
responses$CUE = tolower(responses$CUE)

temp_response1 = data.frame()

for(i in final_cues){
  
  temp_response2 = subset(responses,
                          responses$CUE == i)
  
  temp_response1 = rbind(temp_response1, temp_response2)
  
}

percent(temp_response1$POS)

##get percent removed in round 1
percent(temp_response1$POS)[1] + percent(temp_response1$POS)[2] + percent(temp_response1$POS)[3] +
  percent(temp_response1$POS)[4] + percent(temp_response1$POS)[6] + percent(temp_response1$POS)[7] +
  percent(temp_response1$POS)[8] + percent(temp_response1$POS)[10] + percent(temp_response1$POS)[11] +
  percent(temp_response1$POS)[12] + percent(temp_response1$POS)[13] + percent(temp_response1$POS)[14] +
  percent(temp_response1$POS)[15]

verbs = subset(temp_response1, temp_response1$POS == "VERB")
nouns = subset(temp_response1, temp_response1$POS == "NOUN")
aux = subset(temp_response1, temp_response1$POS == "AUX")

verbs$CUE = tolower(verbs$CUE)
ns$Cue = tolower(ns$Cue)

####Compute####
#Extract all unique cues
cuelist = unique(verbs$CUE)

#ensure alphabetical order
cuelist = sort(cuelist)

#now order verbs dataset alphabetically by cue
verbs2 = verbs[order(verbs$CUE), ]
ns = ns[order(ns$Cue), ]
colnames(ns)[1] = "CUE"

####Compute the measures
Affordance_Strength = data.frame(matrix(ncol = 5,nrow = 0, dimnames = list(NULL, c("cue", "response", "AFS", "AFP", "AFSS"))))

for(i in cuelist){
  
  temp = subset(verbs2,
                verbs2$CUE == i)
  
  r_list = unique(temp$RESPONSE.LEMMA)
  
  temp_n = subset(ns,
                  ns$CUE == i)
  
  for(j in r_list){
    
    temp2 = subset(temp,
                   temp$RESPONSE.LEMMA == j)
    
    cue = temp2$CUE[1]
    response = temp2$RESPONSE.LEMMA[1]
    AFS = nrow(temp2) / nrow(temp)
    AFP = nrow(temp2) / temp_n$n.unique
    AFSS = length(r_list)
    
    temp3 = data.frame(cue, response, AFS, AFP, AFSS)
    
    Affordance_Strength = rbind(Affordance_Strength, temp3)
  }
  
}


##now sort
Affordance_Strength2 = data.frame(matrix(ncol = 5,nrow = 0, dimnames = list(NULL, c("cue", "response", "AFS", "AFP", "AFSS"))))

for(k in cuelist){
  
  temp4 = subset(Affordance_Strength,
                 Affordance_Strength$cue == k)
  
  temp4 = temp4[order(temp4$AFS, decreasing = TRUE), ]
  
  Affordance_Strength2 = rbind(Affordance_Strength2, temp4)
  
}

Affordance_Strength2$AFP[Affordance_Strength2$AFP > 1] = 1

#write.csv(Affordance_Strength2, file = "Affordance Norms Final.csv", row.names = F)

##get AFSS values for University and Prolific Students
prolific = subset(verbs2, verbs2$Source == "Prolific")
undergrad = subset(verbs2, verbs2$Source != "Prolific")

##compute prolific
prolific2 = data.frame(matrix(ncol = 3,nrow = 0, dimnames = list(NULL, c("cue", "response", "AFSS"))))

for(i in cuelist){
  
  temp = subset(prolific,
                prolific$CUE == i)
  
  r_list = unique(temp$RESPONSE.LEMMA)
  
  for(j in r_list){
    
    temp2 = subset(temp,
                   temp$RESPONSE.LEMMA == j)
    
    cue = temp2$CUE[1]
    response = temp2$RESPONSE.LEMMA[1]
    AFSS = length(r_list)
    
    temp3 = data.frame(cue, response, AFSS)
    
    Prolific2 = rbind(Prolific2, temp3)
  }
  
}


##now sort
Prolific3 = data.frame(matrix(ncol = 3,nrow = 0, dimnames = list(NULL, c("cue", "response", "AFSS"))))

for(k in cuelist){
  
  temp4 = subset(Prolific2,
                 Prolific2$cue == k)
  
  temp4 = temp4[order(temp4$AFS, decreasing = TRUE), ]
  
  Prolific3 = rbind(Prolific3, temp4)
  
}

#write.csv(Prolific3, file = "prolific_affs.csv", row.names = F)

####And now the undergrads
##compute prolific
Ugrad2 = data.frame(matrix(ncol = 3,nrow = 0, dimnames = list(NULL, c("cue", "response", "AFSS"))))

for(i in cuelist){
  
  temp = subset(undergrad,
                undergrad$CUE == i)
  
  r_list = unique(temp$RESPONSE.LEMMA)
  
  for(j in r_list){
    
    temp2 = subset(temp,
                   temp$RESPONSE.LEMMA == j)
    
    cue = temp2$CUE[1]
    response = temp2$RESPONSE.LEMMA[1]
    AFSS = length(r_list)
    
    temp3 = data.frame(cue, response, AFSS)
    
    Ugrad2 = rbind(Ugrad2, temp3)
  }
  
}


##now sort
Ugrad3 = data.frame(matrix(ncol = 3,nrow = 0, dimnames = list(NULL, c("cue", "response", "AFSS"))))

for(k in cuelist){
  
  temp4 = subset(Ugrad2,
                Ugrad2$cue == k)
  
  temp4 = temp4[order(temp4$AFS, decreasing = TRUE), ]
  
  Ugrad3 = rbind(Ugrad3, temp4)
  
}

#write.csv(Ugrad3, file = "ugrad_afss.csv", row.names = F)
