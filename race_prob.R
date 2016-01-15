#Return vector of race probabilities for each last name, according to 2000 census data

#select CSV that includes all defendant names from study
defendants = file.choose()
names = read.csv(defendants,colClasses="character",header=TRUE)

#create vector of all defendant last names
lastnames = as.character(names$lastname)

#get rid of all spaces after defendant last names
lastnames = sub(" .*", "", names$lastname)

#select CSV that includes last names (at least 100 occurrences) and race vectors from 2000 census
census_data = file.choose()
census = read.csv(census_data,colClasses="character",header=TRUE)

#select blank CSV with appropriate column heading for writing purposes
race_headings = file.choose()
race_prob = read.csv(race_headings,colClasses="character",header=TRUE)

#iterate through each defendant last name
for(i in 1:length(lastnames)){
  
  #convert string to uppercase for comparison to census data 
  lastnames[i] = toupper(lastnames[i])  
  m = 1
  
  #look through last names from census for defendant's last name 
  while((lastnames[i] != census$name[m]) && (m <= (length(census$name) - 1))){
      m = m + 1
  } 
  
  #write race vector probabilities to output CSV if defendant's last name is found census data
  if(lastnames[i] == census$name[m]){
    race_prob[nrow(race_prob) + 1, ] <- c(census[m,])
  }
  
  #write NA if defendant's last name is not found
  else{
    race_prob[nrow(race_prob) + 1, ] <- c(NA)
  }
}

#write CSV that includes race probability vectors for defendants
write.csv(race_prob, file = "race_prob.csv")