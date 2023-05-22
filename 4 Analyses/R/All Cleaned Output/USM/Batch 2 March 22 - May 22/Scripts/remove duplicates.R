####Remove duplicated rows####
dat = read.csv("udpipe_5_24.csv")

dat2 = dat %>% distinct(sentence, lemma, .keep_all = T)

##write to .csv for inspection
write.csv(dat2, file = "No_duplicates_5_24.csv", row.names = F)
