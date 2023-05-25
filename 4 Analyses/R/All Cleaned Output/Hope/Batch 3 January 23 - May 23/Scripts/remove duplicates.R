####Remove duplicated rows####
dat = read.csv("udpipe_3_18.csv")

dat2 = dat %>% distinct(sentence, lemma, .keep_all = T)

##write to .csv for inspection
#write.csv(dat2, file = "no_duplicates_3_19.csv", row.names = F)