####Combine .csv files into master datasheet####
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/3 Output/3 Prolific Demos/Data")

#Get the files names
files = list.files(pattern = "*.csv")

#read everything in and merge into one dataframe.
dat = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))

#write.csv(dat, file = "Merged_demos_prolific.csv", row.names = F)

setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/3 Output/3 Prolific Demos/Response")

#Get the files names
files = list.files(pattern = "*.csv")

#read everything in and merge into one dataframe.
dat2 = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))

#write.csv(dat2, file = "Merged_responses.csv", row.names = F)