
#get rid of the don't knows
dat$affordance_response[dat$affordance_response == "idk"] = NA
dat$affordance_response[dat$affordance_response == " idk"] = NA
dat$affordance_response[dat$affordance_response == "idk what this is"] = NA
dat$affordance_response[dat$affordance_response == "idk what that is"] = NA
dat$affordance_response[dat$affordance_response == "im sorry idk what this is either"] = NA
dat$affordance_response[dat$affordance_response == "idk what it is"] = NA
dat$affordance_response[dat$affordance_response == "idk its a person"] = NA
dat$affordance_response[dat$affordance_response == "don't know what that is"] = NA
dat$affordance_response[dat$affordance_response == "i don't know what that is"] = NA
dat$affordance_response[dat$affordance_response == "don't know what this is"] = NA
dat$affordance_response[dat$affordance_response == "i don't know what this is"] = NA
dat$affordance_response[dat$affordance_response == "i don't know"] = NA
dat$affordance_response[dat$affordance_response == "don't know"] = NA
dat$affordance_response[dat$affordance_response == "i don't know what a sawdust is"] = NA
dat$affordance_response[dat$affordance_response == "i don't know what this is "] = NA
dat$affordance_response[dat$affordance_response == "i don't know what a chronograph is"] = NA
dat$affordance_response[dat$affordance_response == "i don't know what it is"] = NA
dat$affordance_response[dat$affordance_response == "don't know word"] = NA
dat$affordance_response[dat$affordance_response == "i dont knwo"] = NA
dat$affordance_response[dat$affordance_response == "i dont know"] = NA
dat$affordance_response[dat$affordance_response == "i dont know what this means"] = NA
dat$affordance_response[dat$affordance_response == "i dont know what this is"] = NA
dat$affordance_response[dat$affordance_response == "i dont know what that is"] = NA
dat$affordance_response[dat$affordance_response == "dont know"] = NA
dat$affordance_response[dat$affordance_response == "dont know what that is"] = NA
dat$affordance_response[dat$affordance_response == "im not sure"] = NA
dat$affordance_response[dat$affordance_response == "i'm not sure"] = NA
dat$affordance_response[dat$affordance_response == "i'm not sure what this means"] = NA
dat$affordance_response[dat$affordance_response == "i'm not sure what this is"] = NA
dat$affordance_response[dat$affordance_response == "not sure"] = NA
dat$affordance_response[dat$affordance_response == "not sure what this is"] = NA
dat$affordance_response[dat$affordance_response == "i'm not sure "] = NA
dat$affordance_response[dat$affordance_response == "not sure what this is?? "] = NA
dat$affordance_response[dat$affordance_response == "	i am not sure what this is??"] = NA
dat$affordance_response[dat$affordance_response == "	im not sure what this is"] = NA
dat$affordance_response[dat$affordance_response == "	i'm not sure what this is "] = NA
dat$affordance_response[dat$affordance_response == "	not sure "] = NA
dat$affordance_response[dat$affordance_response == "i'm not sure what this is 	"] = NA
dat$affordance_response[dat$affordance_response == "	im not sure what this is"] = NA
dat$affordance_response[dat$affordance_response == "	not sure "] = NA
dat$affordance_response[dat$affordance_response == "not sure "] = NA
dat$affordance_response[dat$affordance_response == "i'm not sure what this is "] = NA
dat$affordance_response[dat$affordance_response == "	i dont know "] = NA
dat$affordance_response[dat$affordance_response == "i dont know "] = NA
dat$affordance_response[dat$affordance_response == "i dont know what this is,"] = NA
dat$affordance_response[dat$affordance_response == "i dont know what this is "] = NA
dat$affordance_response[dat$affordance_response == "idk "] = NA
dat$affordance_response[dat$affordance_response == "don't know what that is "] = NA
dat$affordance_response[dat$affordance_response == "i don't know what that is "] = NA
dat$affordance_response[dat$affordance_response == "don't know what a sawdust is"] = NA
dat$affordance_response[dat$affordance_response == "no idea"] = NA
dat$affordance_response[dat$affordance_response == "i have no idea"] = NA
dat$affordance_response[dat$affordance_response == "i have no idea what this is"] = NA
dat$affordance_response[dat$affordance_response == "no idea what that is"] = NA
dat$affordance_response[dat$affordance_response == "have no idea"] = NA
dat$affordance_response[dat$affordance_response == "no idea "] = NA
dat$affordance_response[dat$affordance_response == "no idea what this means"] = NA
dat$affordance_response[dat$affordance_response == "i have no idea what a terrace is "] = NA
dat$affordance_response[dat$affordance_response == "no clue"] = NA
dat$affordance_response[dat$affordance_response == "no clue "] = NA
dat$affordance_response[dat$affordance_response == "nothing"] = NA
dat$affordance_response[dat$affordance_response == "a game that i know nothing about"] = NA
dat$affordance_response[dat$affordance_response == "im not sure what this one is"] = NA
dat$affordance_response[dat$affordance_response == "im a carpenter"] = NA
dat$affordance_response[dat$affordance_response == "im not sure what this is"] = NA
dat$affordance_response[dat$affordance_response == "i am not sure what this is?? "] = NA
dat$affordance_response[dat$affordance_response == "?"] = NA
dat$affordance_response[dat$affordance_response == "ikd"] = NA
dat$affordance_response[dat$affordance_response == "lol"] = NA
dat$affordance_response[dat$affordance_response == "wtf is this"] = NA
dat$affordance_response[dat$affordance_response == "do't know"] = NA

##Remove participants who didn't understand instructions or fucked around
dat = subset(dat,
             dat$Username != "w984625_KW")
dat = subset(dat,
             dat$Username != "w216726_JLM")
dat = subset(dat,
             dat$Username != "w10046218")
dat = subset(dat,
             dat$Username != "w10065790_AMB")
dat = subset(dat,
             dat$Username != "w10066214_otd")
dat = subset(dat,
             dat$Username != "w10083077_nr")
dat = subset(dat,
             dat$Username != "w10089826DJ")
dat = subset(dat,
             dat$Username != "w10107771LJ")
dat = subset(dat,
             dat$Username != "w10110329CRD")
dat = subset(dat,
             dat$Username != "w825256")