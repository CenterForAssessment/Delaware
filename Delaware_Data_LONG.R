##############################################################
###
### Data preparation for DE SGP analysis
###
##############################################################

### Load packages
require(data.table)


### Load data
Delaware_Data_WIDE <- fread("Data/Base_Files/Delaware_Data_LONG.csv")

### Tidy up data
old.names <- c("SchoolYear", "StudentID", "DistrictCode", "DistrictName", "SchoolCode", "SchoolName", "RaceEDEN", "Grade", "SWD", "ELL", "LowIncome", "ELAScaleScore", "ELAPL", "MathScaleScore", "MathPL", "ELAGrowthEligible", "MathGrowthEligible")
new.names <- c("YEAR", "ID", "DISTRICT_NUMBER", "DISTRICT_NAME", "SCHOOL_NUMBER", "SCHOOL_NAME", "ETHNICITY", "GRADE", "DISABILITY_STATUS", "ELL_STATUS", "SES_STATUS", "ELA_SCALE_SCORE", "ELA_ACHIEVEMENT_LEVEL", "MATHEMATICS_SCALE_SCORE", "MATHEMATICS_ACHIEVEMENT_LEVEL", "ELA_GROWTH_ELIGIBLE", "MATH_GROWTH_ELIGIBLE")
setnames(Delaware_Data_WIDE, old.names, new.names)

Delaware_Data_LONG <- data.table(
    VALID_CASE=rep("VALID_CASE", 2*dim(Delaware_Data_WIDE)[1]),
    CONTENT_AREA=rep(c("ELA", "MATHEMATICS"), each=dim(Delaware_Data_WIDE)[1]),
    YEAR=rep(Delaware_Data_WIDE$YEAR, 2),
    ID=rep(Delaware_Data_WIDE$ID, 2),
    GRADE=rep(Delaware_Data_WIDE$GRADE, 2),
    SCALE_SCORE=c(Delaware_Data_WIDE$ELA_SCALE_SCORE, Delaware_Data_WIDE$MATHEMATICS_SCALE_SCORE),
    ACHIEVEMENT_LEVEL=c(Delaware_Data_WIDE$ELA_ACHIEVEMENT_LEVEL, Delaware_Data_WIDE$MATHEMATICS_ACHIEVEMENT_LEVEL),
    GROWTH_ELIGIBLE=c(Delaware_Data_WIDE$ELA_GROWTH_ELIGIBLE, Delaware_Data_WIDE$MATHEMATICS_GROWTH_ELIGIBLE),
    DISTRICT_NUMBER=rep(Delaware_Data_WIDE$DISTRICT_NUMBER, 2),
    DISTRICT_NAME=rep(Delaware_Data_WIDE$DISTRICT_NAME, 2),
    SCHOOL_NUMBER=rep(Delaware_Data_WIDE$SCHOOL_NUMBER, 2),
    SCHOOL_NAME=rep(Delaware_Data_WIDE$SCHOOL_NAME, 2),
    ETHNICITY=rep(Delaware_Data_WIDE$ETHNICITY, 2),
    DISABILITY_STATUS=rep(Delaware_Data_WIDE$DISABILITY_STATUS, 2),
    ELL_STATUS=rep(Delaware_Data_WIDE$SES_STATUS, 2))

### Tidy up LONG file
Delaware_Data_LONG[,YEAR:=as.character(YEAR)]
Delaware_Data_LONG[,ID:=as.character(ID)]
Delaware_Data_LONG[,GRADE:=as.character(GRADE)]
Delaware_Data_LONG[,ACHIEVEMENT_LEVEL:=paste("Level", ACHIEVEMENT_LEVEL)]
Delaware_Data_LONG[,SCHOOL_ENROLLMENT_STATUS:="Enrolled School: Yes"]
Delaware_Data_LONG[,DISTRICT_ENROLLMENT_STATUS:="Enrolled District: Yes"]
Delaware_Data_LONG[,STATE_ENROLLMENT_STATUS:="Enrolled State: Yes"]

### Save result
save(Delaware_Data_LONG, file="Data/Delaware_Data_LONG.Rdata")