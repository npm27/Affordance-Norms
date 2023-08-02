##Start by gathering all of the data
setwd("C:/Users/nickm/OneDrive/Documents/GitHub/BOI-Norms/4 Analyses/R/Get ns/Good data")

files = list.files(pattern = "*.csv")

#Put them in one dataframe. First apply read.csv, then rbind
dat = do.call(rbind, lapply(files, function(x) read.csv(x, stringsAsFactors = FALSE)))

#get the number of participants
length(unique(dat$Username))

####Fix duplicates (caps difference, plurals, etc.)####
##fix case
dat$Stimuli.Cue = tolower(dat$Stimuli.Cue)

##Check for plurals/different spellings
cuelist = unique(dat$Stimuli.Cue)
View(data.frame(cuelist))

#fix
dat$Stimuli.Cue[dat$Stimuli.Cue == "ammo"] = "ammunition"
dat$Stimuli.Cue[dat$Stimuli.Cue == "antiques"] = "antique"
dat$Stimuli.Cue[dat$Stimuli.Cue == "apartments"] = "apartment"
dat$Stimuli.Cue[dat$Stimuli.Cue == "ashes"] = "ash"
dat$Stimuli.Cue[dat$Stimuli.Cue == "ax"] = "axe"
dat$Stimuli.Cue[dat$Stimuli.Cue == "axes"] = "axe"
dat$Stimuli.Cue[dat$Stimuli.Cue == "bagpipes"] = "bagpipe"
dat$Stimuli.Cue[dat$Stimuli.Cue == "bifocal"] = "bifocals"
dat$Stimuli.Cue[dat$Stimuli.Cue == "blackheads"] = "blackhead"
dat$Stimuli.Cue[dat$Stimuli.Cue == "boots"] = "boot"
dat$Stimuli.Cue[dat$Stimuli.Cue == "brassiere"] = "bra"
dat$Stimuli.Cue[dat$Stimuli.Cue == "breast"] = "breasts"
dat$Stimuli.Cue[dat$Stimuli.Cue == "brushes"] = "brush"
dat$Stimuli.Cue[dat$Stimuli.Cue == "buttock"] = "buttocks"
dat$Stimuli.Cue[dat$Stimuli.Cue == "cacti"] = "cactus"
dat$Stimuli.Cue[dat$Stimuli.Cue == "calves"] = "calf"
dat$Stimuli.Cue[dat$Stimuli.Cue == "canvass"] = "canvas"
dat$Stimuli.Cue[dat$Stimuli.Cue == "capes"] = "cape"
dat$Stimuli.Cue[dat$Stimuli.Cue == "carpeting"] = "carpet"
dat$Stimuli.Cue[dat$Stimuli.Cue == "capes"] = "cape"
dat$Stimuli.Cue[dat$Stimuli.Cue == "chopstick"] = "chopsticks"
dat$Stimuli.Cue[dat$Stimuli.Cue == "clips"] = "clip"
dat$Stimuli.Cue[dat$Stimuli.Cue == "clothing"] = "clothes"
dat$Stimuli.Cue[dat$Stimuli.Cue == "compasses"] = "compass"
dat$Stimuli.Cue[dat$Stimuli.Cue == "crackers"] = "cracker"
dat$Stimuli.Cue[dat$Stimuli.Cue == "cymbols"] = "cymbol"
dat$Stimuli.Cue[dat$Stimuli.Cue == "daddy"] = "dad"
dat$Stimuli.Cue[dat$Stimuli.Cue == "daggers"] = "dagger"
dat$Stimuli.Cue[dat$Stimuli.Cue == "denims"] = "denim"
dat$Stimuli.Cue[dat$Stimuli.Cue == "domino"] = "dominoes"
dat$Stimuli.Cue[dat$Stimuli.Cue == "drawer"] = "drawers"
dat$Stimuli.Cue[dat$Stimuli.Cue == "flannels"] = "flannel"
dat$Stimuli.Cue[dat$Stimuli.Cue == "genital"] = "genitals"
dat$Stimuli.Cue[dat$Stimuli.Cue == "genitalia"] = "genitals"
dat$Stimuli.Cue[dat$Stimuli.Cue == "goggle"] = "goggles"
dat$Stimuli.Cue[dat$Stimuli.Cue == "grocery"] = "groceries"
dat$Stimuli.Cue[dat$Stimuli.Cue == "ingredient"] = "ingredients"
dat$Stimuli.Cue[dat$Stimuli.Cue == "jean"] = "jeans"
dat$Stimuli.Cue[dat$Stimuli.Cue == "kids"] = "kid"
dat$Stimuli.Cue[dat$Stimuli.Cue == "catsup"] = "ketchup"
dat$Stimuli.Cue[dat$Stimuli.Cue == "kissing"] = "kiss"
dat$Stimuli.Cue[dat$Stimuli.Cue == "knuckles"] = "knuckle"
dat$Stimuli.Cue[dat$Stimuli.Cue == "leaves"] = "leaf"
dat$Stimuli.Cue[dat$Stimuli.Cue == "lilly"] = "lily"
dat$Stimuli.Cue[dat$Stimuli.Cue == "limes"] = "lime"
dat$Stimuli.Cue[dat$Stimuli.Cue == "machetes"] = "machete"
dat$Stimuli.Cue[dat$Stimuli.Cue == "mansions"] = "mansion"
dat$Stimuli.Cue[dat$Stimuli.Cue == "masseur"] = "masseuse"
dat$Stimuli.Cue[dat$Stimuli.Cue == "mayo"] = "mayonnaise"
dat$Stimuli.Cue[dat$Stimuli.Cue == "medics"] = "medic"
dat$Stimuli.Cue[dat$Stimuli.Cue == "medication"] = "medicine"
dat$Stimuli.Cue[dat$Stimuli.Cue == "mucous"] = "mucus"
dat$Stimuli.Cue[dat$Stimuli.Cue == "mullets"] = "mullet"
dat$Stimuli.Cue[dat$Stimuli.Cue == "needles"] = "needle"
dat$Stimuli.Cue[dat$Stimuli.Cue == "noodles"] = "noodle"
dat$Stimuli.Cue[dat$Stimuli.Cue == "nutcrackers"] = "nutcracker"
dat$Stimuli.Cue[dat$Stimuli.Cue == "omelette"] = "omelet"
dat$Stimuli.Cue[dat$Stimuli.Cue == "pajama"] = "pajamas"
dat$Stimuli.Cue[dat$Stimuli.Cue == "plastics"] = "plastic"
dat$Stimuli.Cue[dat$Stimuli.Cue == "primates"] = "primate"
dat$Stimuli.Cue[dat$Stimuli.Cue == "props"] = "prop"
dat$Stimuli.Cue[dat$Stimuli.Cue == "rainfall"] = "rain"
dat$Stimuli.Cue[dat$Stimuli.Cue == "receipts"] = "receipt"
dat$Stimuli.Cue[dat$Stimuli.Cue == "sax"] = "saxophone"
dat$Stimuli.Cue[dat$Stimuli.Cue == "scissor"] = "scissors"
dat$Stimuli.Cue[dat$Stimuli.Cue == "seating"] = "seat"
dat$Stimuli.Cue[dat$Stimuli.Cue == "shaving"] = "shavings"
dat$Stimuli.Cue[dat$Stimuli.Cue == "shingles"] = "shingle"
dat$Stimuli.Cue[dat$Stimuli.Cue == "shrubbery"] = "shrub"
dat$Stimuli.Cue[dat$Stimuli.Cue == "sketchpad"] = "sketchbook"
dat$Stimuli.Cue[dat$Stimuli.Cue == "skittle"] = "skittles"
dat$Stimuli.Cue[dat$Stimuli.Cue == "spice"] = "spices"
dat$Stimuli.Cue[dat$Stimuli.Cue == "stair"] = "stairs"
dat$Stimuli.Cue[dat$Stimuli.Cue == "stationery"] = "stationary"
dat$Stimuli.Cue[dat$Stimuli.Cue == "strings"] = "string"
dat$Stimuli.Cue[dat$Stimuli.Cue == "suspender"] = "suspenders"
dat$Stimuli.Cue[dat$Stimuli.Cue == "syringes"] = "syringe"
dat$Stimuli.Cue[dat$Stimuli.Cue == "tong"] = "tongs"
dat$Stimuli.Cue[dat$Stimuli.Cue == "townspeople"] = "townsfolk"
dat$Stimuli.Cue[dat$Stimuli.Cue == "tranquilizers"] = "tranquilizer"
dat$Stimuli.Cue[dat$Stimuli.Cue == "traveller"] = "traveler"
dat$Stimuli.Cue[dat$Stimuli.Cue == "trucks"] = "truck"
dat$Stimuli.Cue[dat$Stimuli.Cue == "underclothing"] = "underclothes"
dat$Stimuli.Cue[dat$Stimuli.Cue == "undergarment"] = "underwear"
dat$Stimuli.Cue[dat$Stimuli.Cue == "underpants"] = "underwear"
dat$Stimuli.Cue[dat$Stimuli.Cue == "vaginal"] = "vagina"
dat$Stimuli.Cue[dat$Stimuli.Cue == "vitamin"] = "vitamins"
dat$Stimuli.Cue[dat$Stimuli.Cue == "weaponry"] = "weapon"
dat$Stimuli.Cue[dat$Stimuli.Cue == "whisker"] = "whiskers"
dat$Stimuli.Cue[dat$Stimuli.Cue == "wounds"] = "wound"
dat$Stimuli.Cue[dat$Stimuli.Cue == "whisky"] = "whiskey"

##how many lost from combining?
d1 = 111 - 21 #90

##Remove low words
dat$Stimuli.Cue[dat$Stimuli.Cue == "saucer"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "grain"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "paperwork"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "spaghetti"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "shortening"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "masturbate"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "massage"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "tripe"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "abacus"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "stenographer"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "casebook"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "rawhide"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "fag"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "turnstile"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "cellist"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "herring"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "rupee"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "gramophone"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "mastiff"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "gardenia"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "solicitor"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "pew"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "wigwam"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "blowpipe"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "tit"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "cavalryman"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "excrement"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "hashish"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "orangutan"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "firebox"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "liverwurst"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "petticoat"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "whore"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "rickshaw"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "fender"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "morphine"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "roadster"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "topaz"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "crankshaft"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "saloonkeeper"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "breadboard"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "sixpence"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "groin"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "hosiery"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "workbox"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "footman"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "lesion"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "matchwood"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "veranda"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "anvil"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "cervix"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "drunkard"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "springboard"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "garter"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "stepsister"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "underbrush"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "amphetamine"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "cryptographer"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "bisque"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "nightstick"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "passerby"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "navel"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "clergyman"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "stepparent"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "suppository"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "stationmaster"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "aircraftsman"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "cob"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "tyke"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "sphincter"] = NA

d2 = 186 - 117 #69

##Additional drops?
dat$Stimuli.Cue[dat$Stimuli.Cue == "massager"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "percolator"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "bran"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "kin"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "midshipman"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "greenback"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "almanac"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "fieldstone"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "persimmon"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "emerald"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "youngster"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "petroleum"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "sod"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "capacitor"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "asphalt"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "matter"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "lick"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "piss"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "cosmetician"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "privates"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "tee"] = NA
dat$Stimuli.Cue[dat$Stimuli.Cue == "newsreader"] = NA

d3 = 212 - 191

##total drops
total = d1 + d2 + d3

total - 5 #account for practice items

##fix my spelling mistakes
dat$Stimuli.Cue[dat$Stimuli.Cue == "turbin"] = "turban"
dat$Stimuli.Cue[dat$Stimuli.Cue == "newlywed"] = "newlyweds"

#get rid of NAs
dat = na.omit(dat)

####Write a loop?####
##subset by cue, get each n?
##remake cue-list
cuelist = unique(dat$Stimuli.Cue)

dat = dat[order(dat$Stimuli.Cue), ]

temp = data.frame()

for(i in cuelist){
  
  temp2 = subset(dat,
                 dat$Stimuli.Cue == i)
  
 x = length(unique(temp2$Username))
 
 temp3 = data.frame(i, x)
 colnames(temp3)[1:2] = c("Cue", "n")
 
 temp = rbind(temp3, temp)
  
}

####What about verb only?####
verb = subset(dat,
              dat$POS == "VERB")

verb = verb[order(verb$Stimuli.Cue), ]

temp4 = data.frame()

for(i in cuelist){
  
  temp5 = subset(verb,
                 verb$Stimuli.Cue == i)
  
  x = length(unique(temp5$Username))
  
  temp6 = data.frame(i, x)
  colnames(temp6)[1:2] = c("Cue", "n")
  
  temp4 = rbind(temp6, temp4)
  
}

colnames(temp4)[2] = "n__affordance"

combined = data.frame(cbind(temp, temp4))

combined2 = combined[ , -3]

colnames(combined2)[2] = "n_participant"

####Now get the total number of responses from each participant
temp7 = data.frame()

for(i in cuelist){
  
  temp8 = subset(verb,
                 verb$Stimuli.Cue == i)
  
  count = 0
  
  for (a in unique(temp8$Username)){
    
    sub1 = subset(temp8,
                  temp8$Username == a)
    
    xx = length(unique(sub1$affordance_parsed))
    
    count = xx + count
  }
  
  temp9 = data.frame(i, count)
  colnames(temp9)[1:2] = c("Cue", "n_all")
  
  temp7 = rbind(temp9, temp7)
  
}

combined3 = cbind(combined2, temp7)

combined3 = data.frame(combined3)
combined4 = combined3[ , -4]

colnames(combined4)[2:4] = c("n unique", "n unique affordance", "total affordance")

#write.csv(combined4, file = "affordance ns.csv", row.names = F)

####How many participants per source?
grouplist = unique(dat$Group)

group1 = data.frame()

for(z in grouplist){
  
  group2 = subset(dat,
                 dat$Group == z)
  
  x = length(unique(group2$Username))
  
  group3 = data.frame(z, x)
  colnames(group3)[1:2] = c("Group", "n")
  
  group1 = rbind(group3, group1)
  
}

sum(group1$n)
