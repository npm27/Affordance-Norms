##read in data
master = read.csv("0-Data/combined_data_5_24_22.csv", stringsAsFactors = F)

#85 subjects

##only keep the columns we need
dat = master[ , c(1, 5, 11, 13, 19, 33, 35)]

#useful column names
colnames(dat)[6] = "affordance_response"

#make blank cells NA
dat$affordance_response[dat$affordance_response == ""] = NA
dat$affordance_response[dat$affordance_response == "n/a"] = NA

##normalize all responses to lowercase
dat$affordance_response = tolower(dat$affordance_response)

source("Scripts/remove idk.R")

#Check for NAs
table(is.na(dat$affordance_response))

#remove nas
dat = na.omit(dat)

####Fix Spelling and Remove White Space####
##Spelling
#Extract a list of words
#tokens = unnest_tokens(tbl = dat, output = token, input = affordance_response)

dat$affordance_response = gsub(",", ", ", dat$affordance_response)
dat$affordance_response = gsub("  ", " ", dat$affordance_response)

parsed_afforances = unnest_tokens(tbl = dat, output = parsed,
                                  input = affordance_response, token = "regex",
                                  pattern = ", ")

wordlist = unique(parsed_afforances$parsed)

#Run the spell check
spelling.errors = hunspell(wordlist)
spelling.errors = unique(unlist(spelling.errors))
spelling.sugg = hunspell_suggest(spelling.errors, dict = dictionary("en_US"))

#Pick the first spelling suggestion
spelling.sugg = unlist(lapply(spelling.sugg, function(x) x[1]))

#manually check errors
spell_check = cbind(spelling.sugg, spelling.errors)

#Write to file and manually confirm
#write.csv(spell_check, file = "spell_check_raw.csv", row.names = F)
