
## Generates plot2.png file from electicity usage data for Course Project 1.
## Written by Peter Ashcroft

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip")

data<-read.csv("household_power_consumption.txt", sep=";", as.is=TRUE)

## Create new POSIX elemenet based on date and time
time_strings <- paste(data$Date,data$Time)
POSIX_time <- strptime(time_strings,format="%d/%m/%Y %H:%M:%S")
data <- cbind(POSIX_time,data)

## Convert dates to Date class
data$Date <- as.Date(data$Date,"%d/%m/%Y")

## Extract the subset of data for the period of interest
start_date <- as.Date("2007-02-01")
end_date <- as.Date("2007-02-02")

subsetted_data <- data[(data$Date >= start_date) & (data$Date <= end_date),]

## Convert Global_active_power to numeric
subsetted_data$Global_active_power <- as.numeric(subsetted_data$Global_active_power)

## Make plot and copy to a .png file
plot(subsetted_data$POSIX_time,subsetted_data$Global_active_power,
     main="",xlab="",ylab="Global Active Power (kilowatts)",type="n")
lines(subsetted_data$POSIX_time,subsetted_data$Global_active_power, lty=1)

dev.copy(png, "plot2.png")
dev.off()

