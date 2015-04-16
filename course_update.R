library(XML)

# load the courses file
all_course_names <- read.table("courses.txt")

# create a variable called class_use that stores all of the course names
class_use <- NULL
for(i in 1:185){
    class_use[[i]] <- as.character(all_course_names[[i]])}

# create an array of all of the urls that our function will pull data from 
url <- "http://my.gwu.edu/mod/pws/courserenumbering.cfm?subjID="
urls <- paste0(url,class_use)

# getPage function used to grab tables from multiple websites
getPage <- function(page){
    require(XML)
    url1 = urls[page]
    tab = readHTMLTable(url1, stringsAsFactors = FALSE)[[3]]
    return(tab)
}

require(plyr)
# run pages function and then combine all of the rows 
pages = llply(c(1:116,118:length(class_use)), getPage, .progress = 'text') 
course_change_history = do.call('rbind', pages)

### Format the course_change history data 
# remove "Â" characters 
course_change_history <- sapply(course_change_history[,1:5], FUN= function(x) gsub("Â", "", as.character(x)))
course_change_history <- as.data.frame(course_change_history)

# remove whitespace before and after strings
require(stringr)
course_change_history$SUBJECT <- str_trim(course_change_history$SUBJECT) 
course_change_history$DESCRIPTION <- str_trim(course_change_history$DESCRIPTION)
course_change_history[[3]] <- str_trim(course_change_history[[3]])
course_change_history[[4]] <- str_trim(course_change_history[[4]])
course_change_history[[5]] <- str_trim(course_change_history[[5]])

# remove NAs and blank rows
course_change_history <- course_change_history[complete.cases(course_change_history),]
names(course_change_history) <- gsub(" ","_",names(course_change_history))
course_change_history <- subset(course_change_history, !is.na(SUBJECT))
course_change_history <- subset(course_change_history, SUBJECT != "")
row.names(course_change_history) <- 1:nrow(course_change_history)

write.csv(course_change_history, file = "course_change_history.csv")
