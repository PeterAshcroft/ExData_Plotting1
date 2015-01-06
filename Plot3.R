
## Generates plot3.png file from electicity usage data for Course Project 1.
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

## Convert Sub_metering_1, Sub_metering_2, and Sub_metering_3  to numeric
subsetted_data$Sub_metering_1 <- as.numeric(subsetted_data$Sub_metering_1)
subsetted_data$Sub_metering_2 <- as.numeric(subsetted_data$Sub_metering_2)
subsetted_data$Sub_metering_3 <- as.numeric(subsetted_data$Sub_metering_3)

## Make plot and copy to a .png file
plot(subsetted_data$POSIX_time,subsetted_data$Sub_metering_1,
     main="",xlab="",ylab="Energy sub metering",type="n")
lines(subsetted_data$POSIX_time,subsetted_data$Sub_metering_1, lty=1, col="black")
lines(subsetted_data$POSIX_time,subsetted_data$Sub_metering_2, lty=1, col="red")
lines(subsetted_data$POSIX_time,subsetted_data$Sub_metering_3, lty=1, col="blue")

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col=c("black","red","blue"))

dev.copy(png, "plot3.png")
dev.off()

