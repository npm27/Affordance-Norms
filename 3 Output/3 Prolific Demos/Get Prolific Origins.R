##Read in data
dat = read.csv("Merged_demos_prolific.csv")
dat2 = read.csv("Merged_responses.csv")

colnames(dat)[2]= "Username"

##what are we working with?
table(dat$Country.of.residence)

#we have 756 Prolific participants in the final dataset
dat = subset(dat,
             dat$Country.of.residence != "CONSENT_REVOKED")

#get the IDs for the Prolific participants in the final dataset
name_list = unique(dat2$Username)

#do a merge?
dat3 = merge(dat2, dat, by = "Username")

UK = subset(dat3,
            dat3$Country.of.residence == "United Kingdom")


length(unique(UK$Username))

756 - 575       
