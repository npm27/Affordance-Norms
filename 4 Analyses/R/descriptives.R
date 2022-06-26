####Set up####
##Combine data into master file
#Start w/ cleaned data
setwd("./Cleaned Data Sets")

files = list.files(pattern = "*.csv")

#read everything in and merge into one dataframe.
dat = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))

setwd("..")

#Now do the pre-cleaning (this is to pull subIDs)
setwd("./Raw Data Sets")

files = list.files(pattern = "*.csv")

#read everything in and merge into one dataframe.
dat2 = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))

setwd("..")

####Descriptives####
##Number of subjects
length(unique(dat2$ID)) #796

##How many times has each word been normed in the final data set?

#total number or responses (All tenses)
temp2 = data.frame()

for(i in unique(dat$CUE)){
  
  temp = subset(dat,
                dat$CUE == i)
  
  nrow(temp)
  
  temp$RESPONSE_NUM = rep(nrow(temp))
  
  
  temp2 = rbind(temp2, temp)
  
}

mean(temp2$RESPONSE_NUM) ##Across all POS, each affordance has an average of 15 responses


##total number of VERB responses
#make a verb subset
VERB = subset(dat,
              dat$POS == "VERB")

temp4 = data.frame()

for(i in unique(VERB$CUE)){
  
  temp = subset(VERB,
                VERB$CUE == i)
  
  nrow(temp)
  
  temp$RESPONSE_NUM = rep(nrow(temp))
  
  
  temp4 = rbind(temp4, temp)
  
}

mean(temp4$RESPONSE_NUM) ##On average, 7 verb responses

###total number of NOUN responses
NOUN = subset(dat,
              dat$POS == "NOUN")

temp6 = data.frame()

for(i in unique(NOUN$CUE)){
  
  temp = subset(NOUN,
                NOUN$CUE == i)
  
  nrow(temp)
  
  temp$RESPONSE_NUM = rep(nrow(temp))
  
  
  temp6 = rbind(temp6, temp)
  
}

mean(temp6$RESPONSE_NUM) #average of 8 NOUN responses

####Plan####
##Master sheet -- (Nouns and Verbs)
##Verb Tab, Noun Tab

##write to file
#write.csv(dat, file = "All_responses.csv", row.names = F)
