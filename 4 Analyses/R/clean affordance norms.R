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
master = read.csv("0-Data/merged_9_19.csv", stringsAsFactors = F)

##drop unused column
dat = master[ , -c(2:4, 6:7, 9:11, 14:17, 19, 22:24, 26:27, 30:32,34)]

#useful column names
colnames(dat)[12] = "affordance_response"

#Check for NAs
table(is.na(dat$affordance_response))

#remove nas
dat = na.omit(dat)

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
write.csv(spell_check, file = "spell_check.csv", row.names = F)

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

##Write spelled checked data to .csv
write.csv(tokens, file = "spell_checked.csv", row.names = F)

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
no_stop = dat %>%
  filter(!grepl("[[:punct:]]", affordance_corrected)) %>% #Remove punctuation
  filter(!affordance_corrected %in% stopwords(language = "en", source = "snowball")) %>% #remove stopwords
  filter(!grepl("[[:digit:]]+", affordance_corrected)) %>% #remove numbers
  filter(!is.na(affordance_corrected))

temp = data.frame(table(no_stop$affordance_corrected)) #If you View temp, you can see that there's parenthesis, puncation, weird spaces, etc.

#remove extra spaces
no_stop$affordance_corrected = gsub(" ", "", no_stop$affordance_corrected)

#Remove 's
no_stop$affordance_corrected = gsub("'s", "", no_stop$affordance_corrected)

#Remove 't
no_stop$affordance_corrected = gsub("'t", "t", no_stop$affordance_corrected)

#Remove any stopwords that might have been generated in lines 139/142
no_stop = no_stop %>%
  filter(!affordance_corrected %in% stopwords(language = "en", source = "snowball"))

##Write to .csv for lemmatization w/ Python
#write.csv(no_stop, file = "cleaned_9_19_21.csv", row.names = F)

####Lemmatize w/ R####
##Having some issues w/ this, using Python instead. Code is included though in case I ever get this working.
#Lemmatize! (This gives a second set of lemmas using a different algorithm. Also provides part of speech info)
#lemmatized = udpipe(no_stop$affordance_corrected, "english")

#If lemmatized and no_stop don't match up perfectly, can use the code below to see where the differences are
lemmatized$token[!lemmatized$token %in% no_stop$affordance_corrected] #Then just tweak the character removal process above as needed

##Combine datasets and add in second set of Lemmas, part of speech info
combined = cbind(no_stop, lemmatized[ , c(10:11, 13)])

#Give useful column names
colnames(combined)[14:16] = c("Lemma_1", "Lemma_2", "POS")

#Drop unused columns
combined = combined[ , -c(3, 7:8)]

#Do Lemmas match?
combined$Lemma_match = combined$Lemma_1 == combined$Lemma_2

table(combined$Lemma_match) #Mostly matches but got about 1600 mismatches. Let's see what's up with that!

temp = subset(combined,
              combined$Lemma_match == FALSE)

##Going to use Lemma 1. Both have a couple of weird things, but Lemma 1 is substantially less weird
#don't know why it keeps changing dry to spin-dry though. Going to manually fix that.
combined$Lemma_1[combined$Lemma_1 == "spin-dry"] = "dry"

#might be a good idea to open this up in excel and spot check

#drop lemma 2 and match columns
combined = combined[ , -c(12, 15)]

##Write to .csv
write.csv(combined, file = "Cleaned_5_14_21.csv", row.names = F)
