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

##Remove any final punctuation and white space
dat$cleaned = gsub("[[:punct:]]", "", dat$Initial)

##Remove stop words
no_stop = dat %>%
  filter(!grepl("[[:punct:]]", cleaned)) %>% #Remove punctuation
  filter(!cleaned %in% stopwords(language = "en", source = "snowball")) %>% #remove stopwords
  filter(!grepl("[[:digit:]]+", cleaned)) %>% #remove numbers
  filter(!is.na(cleaned))

##Now lemmatize

##remove stops one more time
