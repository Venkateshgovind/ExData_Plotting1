
## you will need to run the following command to install this package install.packages("data.table")
library(data.table) 

data <- fread("household_power_consumption.txt"
              , select = c("Date","Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
              , colClasses = 'character'
              , na.strings=c("", "NA", "Not Available", "?")
              , sep=";", header=T)

data <- na.omit(data)


data$DateTime <- as.POSIXct(paste(data$Date, " ", data$Time), format="%d/%m/%Y %H:%M:%S", tz="")

fromDate <- as.POSIXct("2007-02-01 00:00:00","%Y-%m-%d %H:%M:%S", tz="")
toDate <- as.POSIXct("2007-02-02 23:59:59","%Y-%m-%d %H:%M:%S", tz="")

data <- subset(data, data$DateTime >= fromDate & data$DateTime <= toDate)


data1 <- subset(data, ,c("DateTime", "Sub_metering_1"))
data2 <- subset(data, ,c("DateTime", "Sub_metering_2"))
data3 <- subset(data, ,c("DateTime", "Sub_metering_3"))



data1$Sub_metering_1 <- as.numeric(data1$Sub_metering_1)
data2$Sub_metering_2 <- as.numeric(data2$Sub_metering_2)
data3$Sub_metering_3 <- as.numeric(data3$Sub_metering_3)



xlim <- range(c(data1$DateTime,data2$DateTime,data3$DateTime))
ylim <- range(c(data1$Sub_metering_1,data2$Sub_metering_2,data3$Sub_metering_3))


with(data1, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", xlim=xlim,ylim=ylim))
with(data2, lines(DateTime, Sub_metering_2, col = "red"))
with(data3, lines(DateTime, Sub_metering_3, col = "blue"))



legend("topright", lty="solid"
       , col = c("black","red", "blue")
       , legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))


dev.copy(png, file = "plot3.png", width=800, height=640) ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
