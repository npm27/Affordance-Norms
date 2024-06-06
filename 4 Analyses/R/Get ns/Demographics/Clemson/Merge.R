####Combine Demos####
#butler
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/4 Analyses/R/Get ns/Demographics/Butler")

butler = read.csv("Butler Demos.csv")

butler$site = rep("Butler")

#CCSU
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/4 Analyses/R/Get ns/Demographics/CCSU")

CCSU = read.csv("CCSU Demos.csv")

CCSU$site = rep("CCSU")

#Clemson
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/4 Analyses/R/Get ns/Demographics/Clemson")

clemson = read.csv("Clemson Demos.csv")

clemson$site = rep("clemson")

##Hope
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/4 Analyses/R/Get ns/Demographics/Hope")

hope = read.csv("Hope Demos.csv")

hope$site = rep("Hope")

##ILTSU
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/4 Analyses/R/Get ns/Demographics/ILTSU")

ILSTU = read.csv("ILSTU Demos.csv")

ILSTU$site = rep("ILSTU")

##MSU Texas
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/4 Analyses/R/Get ns/Demographics/MSU Texas")

MSU = read.csv("MSU Demos 1.csv")

MSU$site = rep("MSU Texas")

##Prolific
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/4 Analyses/R/Get ns/Demographics/Prolific")

Prolific = rbind(read.csv("Prolific Demos 1.csv"), read.csv("Prolific Demos 2.csv"),
                 read.csv("Prolific Demos 3.csv"), read.csv("Prolific Demos 4.csv"))

Prolific$site = rep("Prolific")

##get the prolific maca psych files
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/4 Analyses/R/Get ns/Demographics/Prolific/MACA Psych")
files = list.files(pattern = "*.csv")

#Put them in one dataframe. First apply read.csv, then rbind
Prolific2 = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))

#fix column names
colnames(Prolific2)[1] = "Username"
colnames(Prolific2)[2] = "Education"
colnames(Prolific2)[4] = "Gender"
colnames(Prolific2)[5] = "Race"
colnames(Prolific2)[6] = "Country"

Prolific2$site = rep("Prolific")

##South Alabama
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/4 Analyses/R/Get ns/Demographics/South Alabama")

USA = read.csv("South Alabama Demos.csv")

USA$site = rep("USA")

##UCONN
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/4 Analyses/R/Get ns/Demographics/UCONN")

UCONN = read.csv("UCONN Demos.csv")

UCONN$site = rep("UCONN")

##USM
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/4 Analyses/R/Get ns/Demographics/USM")
files = list.files(pattern = "*.csv")
USM = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))

USM$site = rep("USM")

##drop unused columns and re-order
combined = rbind(butler, CCSU, clemson, hope, ILSTU, MSU, Prolific, UCONN, USA, USM)
combined2 = combined[ , c(1, 5, 4, 3, 6, 9, 11)]

combined3 = rbind(combined2, Prolific2)

##Now pull IDS of participants who completed the study
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/4 Analyses/R/Get ns/Demographics")

IDs = read.csv("norms_IDs.csv")

combined4 = merge(IDs, combined3, by.x = "Username")

length(unique(combined4$Username)) #2677

combined5 = combined4[!duplicated(combined4$Username),]

write.csv(combined5, file = "demo_table.csv", row.names = F)
