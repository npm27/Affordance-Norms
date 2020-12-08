####Set up####
##libraries
library(dplyr)
library(here)

#Spelling
library(hunspell)
library(tidytext)
library()

#Lemmas
library(koRpus)
library(koRpus.lang.en)
library(tokenizers)

#stopwords
library(stopwords)

##read in data
master = read.csv("merged_12_8.csv", stringsAsFactors = F)

##drop unused column
dat = master[ , -c(2:4, 6:7, 9:11, 14:17, 19, 22:24, 26:27, 30:32,34)]

#useful column names
colnames(dat)[12] = "affordance_response"

####Clean the data####
##normalize all responses to lowercase
dat$affordance_response = tolower(dat$affordance_response)

##Spelling
#Extract a list of words
tokens = unnest_tokens(tbl = dat, output = token, input = affordance_response)
wordlist = unique(tokens$token)

#Run the spell check
spelling.errors = hunspell(wordlist)
spelling.errors = unique(unlist(spelling.errors))
spelling.sugg = hunspell_suggest(spelling.errors, dict = dictionary("en_US"))

#Pick the first spelling suggestion
spelling.sugg = unlist(lapply(spelling.sugg, function(x) x[1]))

#manually check errors
spell_check = cbind(spelling.sugg, spelling.errors)

#Write to file and manually confirm
#write.csv(spell_check, file = "spell_check.csv", row.names = F)

#read back in the checked output
spell_check = read.csv("spell_check.csv", stringsAsFactors = F)
spelling.sugg = as.list(spell_check$spelling.sugg)

#Now make a spelling dictionary
spelling.sugg = tolower(spelling.sugg)
spelling.sugg = as.list(spelling.sugg)

spelling.dict = as.data.frame(cbind(spelling.errors, spelling.sugg))
spelling.dict$spelling.pattern <-paste0("\\b", spelling.dict$spelling.errors, "\\b")

#write spelling dictionary to .csv
#write.csv(spelling.dict, file = "spelling.dict.csv", row.names = F)

