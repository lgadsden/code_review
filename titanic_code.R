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
#Examine Data 
dim(titanic.train) #check dimensions
head(titanic.train) #look at first 5 rows
titanic.train[1:5,] # subset
tail(titanic.train) #subset
titanic.train[1:5,c(4,5,10)] 
titanic.train$PassengerId
titanic.train[,1]
titanic.train[[1]]
str(titanic.train) # looks at structure of data 
summary(titanic.train)


