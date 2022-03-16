####Combine datasets####
###Read in the data
##MCLEXP
dat1 = read.csv("merged_3_16_22_MCLEXP.csv")

##USM 1
dat2 = read.csv("merged_3_16_22_USM1.csv")

##USM 2
dat3 = read.csv("merged_3_16_22_USM2.csv")

#Leave space here for any others (midwestern or Prolific?)


##Add institution codings
dat1$group = rep("USM")
dat2$group = rep("USM")
dat3$group = rep("USM")

#merge
dat4 = rbind(dat1, dat2)
dat3 = dat3[ , -18]

final = rbind(dat3, dat4)

##Write to file
#write.csv(final, file = "combined_data_3_16_22.csv", row.names = F)
