### Load Data 
trainingData <- "https://raw.githubusercontent.com/lgadsden/code_review_titanic/master/train.csv"
testData <- "https://raw.githubusercontent.com/lgadsden/code_review_titanic/master/test.csv"
missing.types <- c("NA", "")
train.column.types <- c('integer',   # PassengerId
                        'factor',    # Survived 
                        'factor',    # Pclass
                        'character', # Name
                        'factor',    # Sex
                        'numeric',   # Age
                        'integer',   # SibSp
                        'integer',   # Parch
                        'character', # Ticket
                        'numeric',   # Fare
                        'character', # Cabin
                        'factor'     # Embarked
)
test.column.types <- train.column.types[-2]     # # no Survived column in test.csv
titanic.train <- read.csv(trainingData,colClasses = train.column.types,
                          na.strings = missing.types)
titanic.test <- read.csv(testData,colClasses = test.column.types,
                         na.strings = missing.types)
# make all columns lower case
names(titanic.train) <- tolower(names(titanic.train))
names(titanic.test) <- tolower(names(titanic.test))
names(titanic.train)
dim(titanic.train) #check dimensions
head(titanic.train) #look at first 5 rows
titanic.train[1:5,] # subset
tail(titanic.train) #subset

titanic.train[1:5,c(4,5,10)] 
titanic.train[,1]
titanic.train[[1]] # subsets column of dataframe --- section of a list for list 
titanic.train$passengerid # hit tab autocompletes

str(titanic.train) # looks at structure of data 
summary(titanic.train)

table(titanic.train$survived)
table(titanic.train$survived,titanic.train$pclass)
table(titanic.train$survived,titanic.train$sex)
plot(table(titanic.train$survived,titanic.train$sex), col = titanic.train$survived)
plot(table(titanic.train$pclass, titanic.train$survived), col = titanic.train$survived)
