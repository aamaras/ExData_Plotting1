library(httr)

setwd("/Users/aamaras/Dropbox/Learn/Data Science/4 Exploratory Data Analysis/Project 1/ExData_Plotting1")

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localFile <- "exdata-data-household_power_consumption.zip"

if (!file.exists(localFile)) {
	download.file(fileUrl, destfile = localFile, method="curl")
}

unzip(localFile, overwrite = FALSE)

houspow <- read.table("household_power_consumption.txt", 
	header = TRUE,
	sep = ";",
	na.strings = "?")
	
houspow$Date2 <- as.Date(houspow$Date, "%d/%m/%Y")

limhouspow = subset(houspow, Date2 == "2007-02-01" | Date2 == "2007-02-02")

limhouspow$datetime <- as.POSIXct(paste(limhouspow$Date, limhouspow$Time), format="%d/%m/%Y %H:%M:%S")

png(filename = "plot4.png",
	width = 480,
	height = 480)

par(mfrow = c(2, 2))

with(limhouspow, {
	plot(datetime, Global_active_power,
		ylab = "Global Active Power (kilowatts)",
		xlab = "",
		type = "l")
		
	plot(datetime, Voltage,
		ylab = "Voltage",
		xlab = "datetime",
		type = "l")
		
	plot(datetime, Sub_metering_1,
		ylab = "Energy sub metering",
		xlab = "",
		type = "l")
	lines(datetime, Sub_metering_2, 
		type = "l", 
		col = "red")
	lines(datetime, Sub_metering_3, 
		type = "l", 
		col = "blue")
		
	plot(datetime, Global_reactive_power,
		ylab = "Global_reactive_power",
		xlab = "datetime",
		type = "l")
	})

dev.off()