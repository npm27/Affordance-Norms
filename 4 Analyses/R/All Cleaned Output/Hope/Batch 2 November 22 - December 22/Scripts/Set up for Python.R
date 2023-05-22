##This code is adopted from Buchanan et al. 2019's primer on processing feature production norms
#https://link.springer.com/article/10.1007/s10339-019-00939-6

####Set up####
##libraries
#Not sure if I'll be using all of these
library(dplyr)
library(here)

#Spelling
library(hunspell)
library(tidytext)
library(stringi)
library(stringr)

#Lemmas
library(koRpus)
library(koRpus.lang.en)
library(tokenizers)
library(textstem)
library(udpipe)

#stopwords
library(stopwords)

##read in data
master = read.csv("merged_12_8.csv", stringsAsFactors = F)

##drop unused column
dat = master[ , -c(2:4, 6:7, 9:11, 14:17, 19, 22:24, 26:27, 30:32,34)]

#useful column names
colnames(dat)[12] = "affordance_response"

#Check for NAs
table(is.na(dat$affordance_response))

####Fix Spelling and Remove White Space####
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
spelling.dict$spelling.pattern = paste0("\\b", spelling.dict$spelling.errors, "\\b")

##Remove white space from responses
#Parse affordances
tokens = unnest_tokens(tbl = dat, output = token,
                       input = affordance_response, token = stringr::str_split,
                       pattern = " |\\, |\\.|\\,|\\;")

tokens$token = trimws(tokens$token,
                      which = c("both", "left", "right"),
                      whitespace = "[ \t\r\n]")

#Remove empty affordance responses
tokens = tokens[!tokens$token == "", ]

#replace misspelled words w/ corrected
tokens$corrected = stri_replace_all_regex(str = tokens$token,
                                          pattern = spelling.dict$spelling.pattern,
                                          replacement = spelling.dict$spelling.sugg,
                                          vectorize_all = FALSE)

#Fix column names
colnames(tokens)[12:13] = c("affordance", "affordance_corrected")

##remove punctuation and stopwords
no_stop = tokens %>%
  filter(!grepl("[[:punct:]]", affordance_corrected)) %>% #Remove punctuation
  filter(!affordance_corrected %in% stopwords(language = "en", source = "snowball")) %>% #remove stopwords
  filter(!grepl("[[:digit:]]+", affordance_corrected)) %>% #remove numbers
  filter(!is.na(affordance_corrected))

##Drop columns 7 and 8 and write to .csv
write.csv(no_stop[ , -c(7:8)], file = "cleaned_2_13.csv", row.names = F)

table(no_stop$affordance_corrected)
