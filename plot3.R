## plot3.R
library(dplyr)
dfile <- "./download/household_power_consumption.txt"
## The dataset from the website has been extracted into the download folder under the current working directory
## Load data file only if the data object exists
if(!exists("expData")) {
        expData <- read.table(dfile, sep = ";", header = TRUE, stringsAsFactors = FALSE)}       
tbdata <- tbl_df(expData)
## exclude data rows that with column value of '?'
gdata <- filter(tbdata, complete.cases(tbdata))
#
## extract data only from the dates 2007-02-01 and 2007-02-02
data <- filter(gdata, gdata$Date == "1/2/2007" | gdata$Date == "2/2/2007")
#
## combine the Data and Time fields into One Datetime field
dtm <- mutate(data, Dttm = strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
#
## plot3.png
png(filename = "plot3.png", width = 480, height = 480)
plot(dtm$Dttm, as.numeric(dtm$Sub_metering_1), type = "l", xlab = "", ylab="Energy sub metering")
points(dtm$Dttm, as.numeric(dtm$Sub_metering_2), type = "l",col = "red")
points(dtm$Dttm, as.numeric(dtm$Sub_metering_3), type = "l",col = "blue")
legend("topright", pch = 45, lwd = 2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()



