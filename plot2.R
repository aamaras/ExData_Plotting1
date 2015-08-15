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
str(limhouspow)

png(filename = "plot2.png",
	width = 480,
	height = 480)

with(limhouspow, {
	plot(datetime, Global_active_power,
		ylab = "Global Active Power (kilowatts)",
		xlab = "",
		type = "l")
	})

dev.off()