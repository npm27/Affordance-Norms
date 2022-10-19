#read back in the checked output
spell_check = read.csv("spell_check.csv", stringsAsFactors = F)
spelling.sugg = as.list(spell_check$spelling.sugg)

#get the correct number of observations and make a spelling dictionary
spelling.errors = as.data.frame(spelling.errors)

spelling.dict = (merge(spelling.errors, spell_check, by = 'spelling.errors'))

spelling.dict$spelling.sugg = tolower(spelling.dict$spelling.sugg)

spelling.dict$spelling.pattern = paste0("\\b", spelling.dict$spelling.errors, "\\b")

##Remove white spaces and replace misspellings
parsed_afforances = parsed_afforances[!parsed_afforances$parsed =="", ]

parsed_afforances$corrected = stri_replace_all_regex(str = parsed_afforances$parsed,
                                                     pattern = spelling.dict$spelling.pattern,
                                                     replacement = spelling.dict$spelling.sugg,
                                                     vectorize_all = FALSE)

##Remove a few weird things
parsed_afforances$corrected[parsed_afforances$corrected == "na"] = NA 
parsed_afforances$corrected[parsed_afforances$corrected == " "] = NA 
parsed_afforances$corrected[parsed_afforances$corrected == ""] = NA

#Fix column names
colnames(parsed_afforances)[7:8] = c("affordance_parsed", "affordance_corrected")

##Write spelled checked data to .csv
#write.csv(parsed_afforances, file = "spell_checked.csv", row.names = F)
