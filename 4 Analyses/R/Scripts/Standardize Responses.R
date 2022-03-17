####get formatting consistent####
##read in data
dat = read.csv("spell_checked.csv", stringsAsFactors = F)

##remove a few more idks that got missed
dat$Initial[dat$Initial == "i do not know what this is "] = NA
dat$Initial[dat$Initial == "to be honest i do not know what this is"] = NA
dat$Initial[dat$Initial == "i do not know how to do it"] = NA
dat$Initial[dat$Initial == "do not know"] = NA
dat$Initial[dat$Initial == "do not know "] = NA
dat$Initial[dat$Initial == "do not know what this is "] = NA
dat$Initial[dat$Initial == "do not know what this is"] = NA
dat$Initial[dat$Initial == "i do not know what this is"] = NA
dat$Initial[dat$Initial == "i do not know what a physiologist is. "] = NA
dat$Initial[dat$Initial == "this is a person. i hope you would do nothing else but receive the newspaper from this newsboy"] = NA

dat = na.omit(dat)

##Remove any punctuation and white space
dat$cleaned = gsub("[[:punct:]]", "", dat$Initial)

##Remove stop words
no_stop = dat %>%
  filter(!grepl("[[:punct:]]", cleaned)) %>% #Remove any final punctuation
  filter(!cleaned %in% stopwords(language = "en", source = "snowball")) %>% #remove stopwords
  filter(!grepl("[[:digit:]]+", cleaned)) %>% #remove numbers
  filter(!is.na(cleaned))

##Now lemmatize
#extract updated tokens
tokens = unnest_tokens(tbl = no_stop, output = final_affordance, input = cleaned)

#now remove stop words one more time
no_stop_final = tokens %>%
  filter(!final_affordance %in% stopwords(language = "en", source = "snowball")) %>% #remove stopwords
  filter(!is.na(final_affordance ))

#remove a couple of weird responses
no_stop_final$final_affordance[no_stop_final$final_affordance == "aa"] = NA

#remove a few other common words
no_stop_final$final_affordance[no_stop_final$final_affordance == "able"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "can"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "thankyou"] = "thank"
no_stop_final$final_affordance[no_stop_final$final_affordance == "youre"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "youre"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "wouldnt"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "shouldnt"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "couldnt"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "don't"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "he's"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "it's"] = NA

no_stop_final = na.omit(no_stop_final)

#get the cue items
cuelist = unique(no_stop_final$Stimuli.Cue)

##okay, I think this does what I want.
no_stop_final$affordance_lemma = lemmatize_strings(no_stop_final$final_affordance)

#fix weird lemmas
no_stop_final$affordance_lemma[no_stop_final$affordance_lemma == "spin-dry"] = "dry"

##Write to file
#write.csv(no_stop_final, file = "lemmatized.csv", row.names = F) #Spot check and clean in Excel
