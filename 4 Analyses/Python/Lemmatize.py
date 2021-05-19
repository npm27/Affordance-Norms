# import things
from nltk.stem import WordNetLemmatizer
from nltk import pos_tag, word_tokenize
import pandas as pd 

## Load in data
# Note that the R script cleans and organizes the data (removes stop words, puncuation, etc.)
# Goal of the py script is to do lemmatization and POS tagging
dat = pd.read_csv("cleaned_5_17_21.csv", sep = ",", encoding = 'cp1252') #No idea why I had to add this to the end...

## General sequence:
# going to POS tag FIRST before lemmatizing. That way we can get a more accurate representation of how participants were responding
x  = pos_tag(dat.affordance_corrected)
x2 = pd.DataFrame(x)

# fix column names
x2.columns = ['affordance', 'POS']
dat['POS'] = x2['POS']

## Lemmatize!
lemmatizer = WordNetLemmatizer()

#lemmatizer.lemmatize(x)

temp = []

for word, tag in pos_tag(dat['affordance_corrected']):
    wntag = tag[0].lower()
    wntag = wntag if wntag in ['a', 'r', 'n', 'v'] else None
    
    if not wntag:
        lemma = word
        
        temp.append(lemma)
        
    else:
        lemma = lemmatizer.lemmatize(word, wntag)
        print(lemma)
        
        temp.append(lemma)
        
##Now append lemmas to df
temp = pd.DataFrame(temp)
temp.columns = ["Lemma"]

dat['Lemma'] = temp['Lemma']

##Write to .csv
#dat.to_csv('Lemmatized 5_17_21.csv', index = False)
