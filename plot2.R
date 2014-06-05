
## you will need to run the following command to install this package install.packages("data.table")
library(data.table) 

data <- fread("household_power_consumption.txt"
              , select = c("Date","Time", "Global_active_power")
              , colClasses = 'character'
              , na.strings=c("", "NA", "Not Available", "?")
              , sep=";", header=T)

data <- na.omit(data)


data$DateTime <- as.POSIXct(paste(data$Date, " ", data$Time), format="%d/%m/%Y %H:%M:%S", tz="")

fromDate <- as.POSIXct("2007-02-01 00:00:00","%Y-%m-%d %H:%M:%S", tz="")
toDate <- as.POSIXct("2007-02-02 23:59:59","%Y-%m-%d %H:%M:%S", tz="")

data <- subset(data, data$DateTime >= fromDate & data$DateTime <= toDate, c("DateTime","Global_active_power"))


data$Global_active_power <- as.numeric(data$Global_active_power)



with(data, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

dev.copy(png, file = "plot2.png", width=480, height=480) ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!

