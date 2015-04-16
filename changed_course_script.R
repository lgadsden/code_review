library(stringr)
library(DataCombine)

# load CSV course history and course number change list
DS_Student_Course_Reg <- read.csv("DS_Student_Course_Reg.csv") 
course_change_hist <- read.csv("course_change_history.csv")

# make all columns lower case - easier down the road 
names(DS_Student_Course_Reg) <- tolower(names(DS_Student_Course_Reg))

### substitue all changed course numbers with new course numbers
DS_Student_Course_Reg$course_number <- as.character(DS_Student_Course_Reg$course_number)

# find location of all course numbers that contain one number or 2 numbers 
short_c1 <- which(str_length(DS_Student_Course_Reg$course_number) == 1)
short_c2 <- which(str_length(DS_Student_Course_Reg$course_number) == 2)
# add zeros to the course numbers that contain one or 2 numbers so that they can all have 3 numbers
DS_Student_Course_Reg$course_number[short_c1] <- paste0("00",DS_Student_Course_Reg$course_number[short_c1])
DS_Student_Course_Reg$course_number[short_c2] <- paste0("0",DS_Student_Course_Reg$course_number[short_c2])

#create column that combines course subject and number
DS_Student_Course_Reg$subject_num <- with(DS_Student_Course_Reg,paste(course_subject_code, course_number))

#subset all courses before Fall 2011
to_change <- subset(DS_Student_Course_Reg, register_term_desc %in% c("2010 Fall", "2010 Spring"))                
keep_same <- subset(DS_Student_Course_Reg, register_term_desc %in% c("2011 Fall", "2011 Spring", "2012 Fall", "2012 Spring", "2013 Fall", "2013 Spring","2014 Spring"))

# remove whitespace from two columns 
course_change_hist$old_course_num <- str_trim(course_change_hist$old_course_num)
course_change_hist$new_course_num <- str_trim(as.character(course_change_hist$new_course_num))

# Find and replace old subject numbers with the new subject numbers from the course chaneg doc 
light <- FindReplace(data = to_change, Var = "subject_num", replaceData = course_change_hist, from = "old_course_num",to = "new_course_num", exact = TRUE)

# combine two subset documents into one again
student_course_reg_mod <- rbind(light,keep_same)

# save student_course_reg_mod as a csv
write.csv(student_course_reg_mod, file = "student_course_reg_mod.csv", row.names = F)