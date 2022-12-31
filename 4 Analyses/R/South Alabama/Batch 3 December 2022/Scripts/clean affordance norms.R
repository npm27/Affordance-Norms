##This code is adapted from Buchanan et al. 2019's primer on processing feature production norms
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
master = read.csv("0-Data/Merged_USA_12_30.csv", stringsAsFactors = F)

##only keep the columns we need
dat = master[ , c(1, 5, 11, 13, 19, 33)]

#useful column names
colnames(dat)[6] = "affordance_response"

#make blank cells NA
dat$affordance_response[dat$affordance_response == ""] = NA
dat$affordance_response[dat$affordance_response == "n/a"] = NA

##normalize all responses to lowercase
dat$affordance_response = tolower(dat$affordance_response)

source("Scripts/remove idk.R")

#remove other weirdness
dat$affordance_response[dat$affordance_response == "nothing "] = NA
dat$affordance_response[dat$affordance_response == "not sure what that is"] = NA
dat$affordance_response[dat$affordance_response == "no idea what this is"] = NA
dat$affordance_response[dat$affordance_response == "none"] = NA
dat$affordance_response[dat$affordance_response == "i dont know what that is "] = NA

#Check for NAs
table(is.na(dat$affordance_response))

#remove nas
dat = na.omit(dat)

####Fix Spelling and Remove White Space####
##Spelling
#Extract a list of words
#tokens = unnest_tokens(tbl = dat, output = token, input = affordance_response)
parsed_afforances = unnest_tokens(tbl = dat, output = parsed,
                       input = affordance_response, token = "regex",
                       pattern = ", ")

parsed_afforances = unnest_tokens(tbl = parsed_afforances, output = parsed,
                                  input = parsed, token = "regex",
                                  pattern = ",")


wordlist = unique(parsed_afforances$parsed)

#Run the spell check
spelling.errors = hunspell(wordlist)
spelling.errors = unique(unlist(spelling.errors))
spelling.sugg = hunspell_suggest(spelling.errors, dict = dictionary("en_US"))

#Pick the first spelling suggestion
spelling.sugg = unlist(lapply(spelling.sugg, function(x) x[1]))

#manually check errors
spell_check = cbind(spelling.sugg, spelling.errors)

#Write to file and manually confirm
write.csv(spell_check, file = "spell_check_raw.csv", row.names = F)

#read back in the checked output
spell_check = read.csv("spell_check.csv", stringsAsFactors = F)
spelling.sugg = as.list(spell_check$spelling.sugg)

#get the correct number of observations and make a spelling dictionary
spelling.errors = as.data.frame(spelling.errors)

spelling.dict = (merge(spelling.errors, spell_check, by = 'spelling.errors'))

spelling.dict$spelling.sugg = tolower(spelling.dict$spelling.sugg)

spelling.dict$spelling.pattern = paste0("\\b", spelling.dict$spelling.errors, "\\b")

##Remove white spaces and replace misspellings
parsed_afforances = parsed_afforances[!parsed_afforances$parsed =="", ]

parsed_afforances = unnest_tokens(tbl = parsed_afforances, output = parsed,
                                  input = parsed, token = "regex",
                                  pattern = ",")

parsed_afforances$corrected = stri_replace_all_regex(str = parsed_afforances$parsed,
                                           pattern = spelling.dict$spelling.pattern,
                                           replacement = spelling.dict$spelling.sugg,
                                           vectorize_all = FALSE)

##Remove a few weird things
#parsed_afforances$corrected[parsed_afforances$corrected == "na"] = NA 
#parsed_afforances$corrected[parsed_afforances$corrected == " "] = NA 
#parsed_afforances$corrected[parsed_afforances$corrected == ""] = NA
#parsed_afforances$corrected[parsed_afforances$corrected == "  learning how to do a task"] = "someone learning how to do a task"

#Fix column names
colnames(parsed_afforances)[6:7] = c("affordance_parsed", "affordance_corrected")

##Write spelled checked data to .csv
write.csv(parsed_afforances, file = "spell_checked.csv", row.names = F)

####Lemmatization####
dat = read.csv("spell_checked.csv", stringsAsFactors = F)

#extract updated tokens
tokens = unnest_tokens(tbl = dat, output = word, input = affordance_corrected)
cuelist = unique(tokens$Stimuli.Cue)

##okay, I think this does what I want.
dat$affordance_lemma = lemmatize_strings(dat$affordance_corrected)

##Erin's walkthrough used TreeTagger for this
##Okay, TreeTagger HATES windows and I can't get it to work, what else can I do?
##Treetagger also pulls part of speech, which would be nice to have.

##what about udpipe?
#Example
#x = c(doc_a = "In our last meeting, someone said that we are meeting again tomorrow",
 #      doc_b = "It's better to be good at being the best")
#anno = udpipe(x, "english")
#anno[, c("doc_id", "sentence_id", "token", "lemma", "upos")]

##Oooh, I like this as an alternative to treetagger.
#does it work on DF columns?
#lemmatized = udpipe(dat$affordance_corrected, "english")

#It does, but there are a few issues. Mainly it ended up with a few extra tokens somehow.
#Get only the overlapping tokens.
#Okay, I think i figured this out. If any words still have spaces in them, udpipe breaks it in two.
#I thought I had removed spaces up above but something must have gotten off.
#Okay, looks like some spaces get reintroduced line 82 when fixing spelling (e.g., "peprally" got turned back into "pep rally") 

#remove spaces from the middle of words
dat$affordance_corrected = stringr::str_remove_all(dat$affordance_corrected, " ")

#Stop words also mess it up. Remove stop words here:
#Now I need to remove punctuation/weirdness

##Remove stop words
no_stop = tokens %>%
  filter(!grepl("[[:punct:]]", word)) %>% #Remove punctuation
  filter(!word %in% stopwords(language = "en", source = "snowball")) %>% #remove stopwords
  filter(!grepl("[[:digit:]]+", word)) %>% #remove numbers
  filter(!is.na(word))

temp = data.frame(table(no_stop$word))

#remove extra spaces
#no_stop$affordance_corrected = gsub(" ", "", no_stop$affordance_corrected)

#Remove 's
#no_stop$affordance_corrected = gsub("'s", "", no_stop$affordance_corrected)

#Remove 't
#no_stop$affordance_corrected = gsub("'t", "t", no_stop$affordance_corrected)

#Remove any stopwords that might have been generated in lines 139/142
#no_stop = no_stop %>%
 # filter(!affordance_corrected %in% stopwords(language = "en", source = "snowball"))

##Write to .csv for lemmatization w/ Python
#write.csv(no_stop, file = "cleaned_9_19_21.csv", row.names = F)

####Lemmatize w/ R####
##Having some issues w/ this, using Python instead. Code is included though in case I ever get this working.
#Lemmatize! (This gives a second set of lemmas using a different algorithm. Also provides part of speech info)
lemmatized = udpipe(no_stop$word, "english")

#If lemmatized and no_stop don't match up perfectly, can use the code below to see where the differences are
#lemmatized$token[!lemmatized$token %in% no_stop$affordance_corrected] #Then just tweak the character removal process above as needed

##Combine datasets and add in second set of Lemmas, part of speech info
combined = cbind(no_stop, lemmatized[ , c(10:11, 13)])

#Give useful column names
colnames(combined)[9] = c("POS")

#Drop unused columns
combined = combined[ , -c(2, 10)]

#don't know why it keeps changing dry to spin-dry though. Going to manually fix that.
combined$lemma[combined$lemma == "spin-dry"] = "dry"
combined$lemma[combined$lemma == "smoothy"] = "smoothie"

#might be a good idea to open this up in excel and spot check

##Write to .csv
#write.csv(combined, file = "USA Cleaned 12_30_22.csv", row.names = F)
