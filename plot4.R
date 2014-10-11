## plot4.R
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
## plot4.png
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(1, 0, 1, 0)) 
with(dtm, {
        plot(Dttm, as.numeric(Global_active_power), main = "", type = "l", xlab="", ylab = "Global Active Power")
        plot(Dttm, as.numeric(Voltage), main = "", type = "l", xlab="datetime", ylab = "Voltage")
        plot(Dttm, as.numeric(Sub_metering_1), type = "l", xlab = "", ylab="Energy sub metering")
        points(Dttm, as.numeric(Sub_metering_2), type = "l",col = "red")
        points(Dttm, as.numeric(Sub_metering_3), type = "l",col = "blue")
        legend("topright", bty="n", lwd = 2, pch = 45, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Dttm, as.numeric(Global_reactive_power), main = "", type = "l", xlab="datetime", ylab = "Global Reactive Power")
})
dev.off()



