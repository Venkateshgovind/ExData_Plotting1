
## you will need to run the following command to install this package install.packages("data.table")
library(data.table) 

data <- fread("household_power_consumption.txt"
              , select = c("Date", "Global_active_power")
              , colClasses = 'character'
              , na.strings=c("", "NA", "Not Available", "?")
              , sep=";", header=T)

data$Date <- as.Date(data$Date, "%d/%m/%Y")

fromDate <- as.Date("2007-02-01","%Y-%m-%d")
toDate <- as.Date("2007-02-02","%Y-%m-%d")

data <- subset(data, data$Date >= fromDate & data$Date <= toDate, c("Date","Global_active_power"))
data$Global_active_power <- as.numeric(data$Global_active_power)

hist(data$Global_active_power, col="red"
     , xlab="Global Active Power (kilowatts)"
     , main="Global Active Power")

dev.copy(png, file = "plot1.png", width=480, height=480) ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!


