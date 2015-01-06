
## Generates plot4.png file from electicity usage data for Course Project 1.
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

## Convert Sub_metering_1, Sub_metering_2, and Sub_metering_3  to numeric
subsetted_data$Sub_metering_1 <- as.numeric(subsetted_data$Sub_metering_1)
subsetted_data$Sub_metering_2 <- as.numeric(subsetted_data$Sub_metering_2)
subsetted_data$Sub_metering_3 <- as.numeric(subsetted_data$Sub_metering_3)

## Convert Voltage to numeric
subsetted_data$Voltage <- as.numeric(subsetted_data$Voltage)

## Convert Global_reactive_power to numeric
subsetted_data$Global_reactive_power <- as.numeric(subsetted_data$Global_reactive_power)

png("plot4.png")
par(mfcol = c(2,2), cex=0.7)

## Make first plot
plot(subsetted_data$POSIX_time,subsetted_data$Global_active_power,
     main="",xlab="",ylab="Global Active Power",type="n")
lines(subsetted_data$POSIX_time,subsetted_data$Global_active_power, lty=1)

## Make second plot
plot(subsetted_data$POSIX_time,subsetted_data$Sub_metering_1,
     main="",xlab="",ylab="Energy sub metering",type="n")
lines(subsetted_data$POSIX_time,subsetted_data$Sub_metering_1, lty=1, col="black")
lines(subsetted_data$POSIX_time,subsetted_data$Sub_metering_2, lty=1, col="red")
lines(subsetted_data$POSIX_time,subsetted_data$Sub_metering_3, lty=1, col="blue")

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col=c("black","red","blue"), bty="n")

## Make third plot
plot(subsetted_data$POSIX_time,subsetted_data$Voltage,
     main="",xlab="datetime",ylab="Voltage",type="n")
lines(subsetted_data$POSIX_time,subsetted_data$Voltage, lty=1)

## Make fourth plot
plot(subsetted_data$POSIX_time,subsetted_data$Global_reactive_power,
     main="",xlab="datetime",ylab="Global_reactive_power",
     ylim=c(0,0.5), type="n")
lines(subsetted_data$POSIX_time,subsetted_data$Global_reactive_power, lty=1)

## dev.copy(png, "plot4.png")
dev.off()

