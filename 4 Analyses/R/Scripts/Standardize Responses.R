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

##compound words
no_stop$cleaned[no_stop$cleaned == "ice cream"] = "icecream"
no_stop$cleaned[no_stop$cleaned == "make up"] = "makeup"
no_stop$cleaned[no_stop$cleaned == "thrown away"] = "throwaway"
no_stop$cleaned[no_stop$cleaned == "throw away"] = "throwaway"
no_stop$cleaned[no_stop$cleaned == "throwing away"] = "throwaway"
no_stop$cleaned[no_stop$cleaned == "hi school"] = "highschool"
no_stop$cleaned[no_stop$cleaned == "high school"] = "highschool"
no_stop$cleaned[no_stop$cleaned == "high five"] = "highfive"
no_stop$cleaned[no_stop$cleaned == "hi five"] = "highfive"

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

no_stop_final$parsed[no_stop_final$parsed == "n/a"] = NA
no_stop_final$parsed[no_stop_final$parsed == "hail/call"] = NA
no_stop_final$parsed[no_stop_final$parsed == "fish/insect food"] = NA
no_stop_final$parsed[no_stop_final$parsed == "cover/smother"] = NA

no_stop_final$final_affordance[no_stop_final$final_affordance == "buyingselling"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "boatship"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "drawingwriting"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "foodsdesserts"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "onoff"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "andor"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "presentgift"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "ac"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "skincaremakeup"] = NA
no_stop_final$final_affordance[no_stop_final$final_affordance == "picturespicture"] = NA

no_stop_final = na.omit(no_stop_final)

#get the cue items
cuelist = unique(no_stop_final$Stimuli.Cue)

#let's try udpipe one more time
ud_out = udpipe(no_stop_final$parsed, "english")

#figure out how to add cue
no_stop_final$key = rep(1:nrow(no_stop_final))

no_stop_key = no_stop_final[ , c(4, 10)]

ud_out$key = substring(ud_out$doc_id, 4)

merged = merge(ud_out, no_stop_key, "key")

##figure out what to drop
table(merged$upos)

merged = subset(merged,
                merged$upos != "PUNCT")
merged = subset(merged,
                merged$upos != "PART")
merged = subset(merged,
                merged$upos != "NUM")
merged = subset(merged,
                merged$upos != "PRON")
merged = subset(merged,
                merged$upos != "SCONJ")
merged = subset(merged,
                merged$upos != "ADV")
merged = subset(merged,
                merged$upos != "ADP")

##remove cans, woulds, shoulds, coulds, etc.
merged = subset(merged,
                merged$lemma !="can")
merged = subset(merged,
                merged$lemma !="would")
merged = subset(merged,
                merged$lemma !="could")
merged = subset(merged,
                merged$lemma !="have")
merged = subset(merged,
                merged$lemma !="should")
merged = subset(merged,
                merged$lemma !="a")
merged = subset(merged,
                merged$lemma !="of")
merged = subset(merged,
                merged$lemma !="the")
merged = subset(merged,
                merged$lemma !="can")
merged = subset(merged,
                merged$lemma !="who")
merged = subset(merged,
                merged$lemma !="what")
merged = subset(merged,
                merged$lemma !="where")
merged = subset(merged,
                merged$lemma !="'s")
merged = subset(merged,
                merged$lemma !="be")
merged = subset(merged,
                merged$lemma !="do")
merged = subset(merged,
                merged$lemma !="get")
merged = subset(merged,
                merged$lemma !="may")
merged = subset(merged,
                merged$lemma !="maybe")
merged = subset(merged,
                merged$lemma !="will")

#remove other weirdness
merged = subset(merged,
                merged$lemma !="roor")
merged = subset(merged,
                merged$lemma !="dino")
merged = subset(merged,
                merged$lemma !="ok")
merged = subset(merged,
                merged$lemma !="no")                
merged = subset(merged,
                merged$lemma !="okay")
merged = subset(merged,
                merged$lemma !="yes")
merged = subset(merged,
                merged$lemma !="any")
merged = subset(merged,
                merged$lemma !="every")
merged = subset(merged,
                merged$lemma !="all")
merged = subset(merged,
                merged$lemma !="this")
merged = subset(merged,
                merged$lemma !="some")
merged = subset(merged,
                merged$lemma !="that")
merged = subset(merged,
                merged$lemma !="those")
merged = subset(merged,
                merged$lemma !="quite")
merged = subset(merged,
                merged$lemma !="each")
merged = subset(merged,
                merged$lemma !="oto")
merged = subset(merged,
                merged$lemma !="other")
merged = subset(merged,
                merged$lemma !="another")
merged = subset(merged,
                merged$lemma !="both")

#keep it going
table(merged$upos)

merged = subset(merged,
                merged$lemma !="sandwhic")
merged = subset(merged,
                merged$lemma !="anti")
merged = subset(merged,
                merged$lemma !="stuff")
merged = subset(merged,
                merged$lemma !="s")
merged = subset(merged,
                merged$lemma !="semi")
merged = subset(merged,
                merged$lemma !="non")
merged = subset(merged,
                merged$lemma !="and")
merged = subset(merged,
                merged$lemma !="or")
merged = subset(merged,
                merged$lemma !="but")
merged = subset(merged,
                merged$lemma !="thing")
merged = subset(merged,
                merged$lemma !="lol")

#fix some misspellings
merged$lemma[merged$lemma == "headbut"] = "headbutt"

##take a look in excel
write.csv(merged, file = "udpipe_3_18.csv", row.names = F)
