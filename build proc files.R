##Write some code to build all of the proc files
#Read in the instructions and practice data
template = read.csv("Procedure/Version1.csv", check.names = F)

template$`Procedure Notes`[is.na(template$`Procedure Notes` == TRUE)] = " "

keep = template[ c(1:10), ]
keep2 = template[ 41, ]

k = 32
j = 61

trial_type = rep("BOI", times = 30)
min_time = rep("-", times = 30)
max_time = rep("-", times = 30)
text = rep(" ", times = 30)
shuffle = rep("y", times = 30)
proc_notes = rep(" ", times = 30)

#generate the trials
for (i in 2:100){

  temp = data.frame(matrix(NA, nrow = 30, ncol = 7))

  colnames(temp)[1:7] = names(template)

  items = k:j

  temp$Item = items

  temp$`Trial Type` = trial_type
  temp$`Max Time` = max_time
  temp$`Min Time` = min_time
  temp$Text = text
  temp$Shuffle = shuffle
  temp$`Procedure Notes` = proc_notes

  temp2 = rbind(keep, temp, keep2)

  write.csv(temp2, file = paste0("Procedure/Version", i,".csv"), row.names = F)

  k = k + 30
  j = j + 30

}
