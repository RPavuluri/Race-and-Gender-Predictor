#Return gender probabilities for each last name, according to U.S. Social Security Administration Data
#Employs "gender" package from https://cran.r-project.org/web/packages/gender/gender.pdf

#select CSV that includes all defendant names from study
defendants = file.choose()
names = read.csv(defendants,colClasses="character",header=TRUE)

#create vector of all defendant first names
firstnames = as.character(names$firstname)

#get rid of all spaces and middle initial after first name  
firstnames = sub(" .*", "", names$firstname)

#find gender probabilities, according to U.S. Social Security Administration baby name data from 1932 to 2012
gender = gender(firstnames, method = "ssa")

#create dataframe of all names   
gender_prob = data.frame(matrix(unlist(gender), nrow=826, byrow=T),stringsAsFactors=FALSE)

#write CSV that includes gender probability vectors for defendants
write.csv(gender_prob, file = "gender_prob.csv")



