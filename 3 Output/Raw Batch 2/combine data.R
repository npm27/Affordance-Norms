####Combine datasets####
###Read in the data
##MCLEXP
##USM 1
dat2 = read.csv("merged_5_24_22_USM1.csv")

##USM 2
dat3 = read.csv("merged_5_24_22_USM2.csv")

#Leave space here for any others (midwestern or Prolific?)


##Add institution codings
dat2$group = rep("USM")
dat3$group = rep("USM")

#merge
dat3 = dat3[ , -18]

final = rbind(dat3, dat2)

##Write to file
#write.csv(final, file = "combined_data_5_24_22.csv", row.names = F)
