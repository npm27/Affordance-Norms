####Combine .csv files into master datasheet####
setwd("./RAW Batch 3")

#Get the files names
files = list.files(pattern = "*.csv")

#read everything in and merge into one dataframe.
dat = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))

setwd("..")

##remove instruction trials
unique(dat$Procedure.Trial.Type)

dat2 = subset(dat,
              dat$Procedure.Trial.Type != "Instruct")

##Remove practice trials
dat2 = subset(dat2,
              dat2$Procedure.Item < 3001)

##Write to .csv
write.csv(dat2, file = "merged_5_24_22_USM1.csv", row.names = F)
