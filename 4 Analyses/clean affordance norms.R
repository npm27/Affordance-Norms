####Set up####
##libraries
library(dplyr)
library(here)

#Spelling
library(hunspell)
library(tidytext)
library(stringi)

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

##Write spelled checked data to .csv
write.csv(tokens, file = "spell_checked.csv", row.names = F)

####Lemmatization####
dat = read.csv("spell_checked.csv", stringsAsFactors = F)

#extract updated tokens
tokens = unnest_tokens(tbl = dat, output = word, input = affordance_corrected)
cuelist = unique(tokens$Stimuli.Cue)

##okay, I think this does what I want.
dat$affordance_lemma = lemmatize_strings(dat$affordance_corrected)

##Treetagger would probably be better, but I can't get it to work, will try and get back to this though.
##Treetagger also pulls part of speech, which would be nice to have.

##what about using udpipe?

#Example
#x = c(doc_a = "In our last meeting, someone said that we are meeting again tomorrow",
#       doc_b = "It's better to be good at being the best")
#anno = udpipe(x, "english")
#anno[, c("doc_id", "sentence_id", "token", "lemma", "upos")]

##Oooh, I like this as an alternative to treetagger.
#does it work on vectors?
#lemmatized = udpipe(dat$affordance_corrected, "english")

#It does, but there are a few issues. Mainly it ended up with extra tokens somehow
#Get only the overlapping tokens.

#Is there a way to do this after things have already been tokenized?
#en = udpipe_download_model(language = "english") #Download English model to working directory (should only need to do this once)
udmodel_english <- udpipe_load_model(file = "english-ewt-ud-2.5-191206.udpipe") #load the model

#temp = udpipe_annotate(udmodel_english, x = dat$affordance_corrected)
#temp = as.data.frame(temp)
temp = udpipe_annotate(udmodel_english, x = dat$affordance_corrected, tokenizer = "vertical")
temp = as.data.frame(temp)

dat$affordance_lemma = temp$lemma
dat$POS = temp$upos

#write to .csv -- good idea to open file in excel and double check that lemmas look good
#write.csv(dat, file = "dat_lemmatized.csv", row.names = F)

####Stop words####
##Read back in the corrected lemmatized data
dat = read.csv("dat_lemmatized.csv", stringsAsFactors = F)

#Remove puncuation and stopwords from lemmas
dat$affordance_lemma = gsub("\\-", " ", dat$affordance_lemma)
dat$affordance_lemma = gsub("^$|\002", NA, trimws(dat$affordance_lemma))

dat.nostop = dat %>% filter(!grepl("[[:punct:]]", affordance_lemma)) %>%
  filter(!affordance_lemma %in% stopwords(language = "en", source = "snowball")) %>% 
  filter(!is.na(affordance_lemma))

##Write no stop data to .csv
#write.csv(dat.nostop, file = "cleaned_output.csv", row.names = F)
