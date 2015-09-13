#### Loading the data


## I'll be using dplyr for transformations and filtering
library(dplyr)

## Reading from file
mydata <- read.table("./Data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?",
                     colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric" ))

## Filter the date we will work with: "2007-02-01" "2007-02-02". Date in format dd/mm/yyyy
mydata_f <- filter(mydata, Date == "1/2/2007" | Date == "2/2/2007")

## Creating the datetime column
mydata_t <- transform(mydata_f, Datetime = as.POSIXct(paste(Date, Time, sep = " "), format="%d/%m/%Y %H:%M:%S"))

## make it clean
rm(mydata, mydata_f)


#### Making Plots: No 4


png(filename = "plot4.png",
    width = 480, height = 480, units = "px", 
    bg = "transparent")

Sys.setlocale("LC_TIME", "English")

## Settings
par(mfrow=c(2,2), col = "black", cex=0.7)

# Top left graphic
plot(x=mydata_t$Datetime, y=mydata_t$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power", main = "")
# Top right graphic
plot(x=mydata_t$Datetime, y=mydata_t$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage", main = "")

# Botton left graphic
plot(x=mydata_t$Datetime, y=mydata_t$Global_active_power, type = "n", 
     ylim = c(0,40), ylab = "Energy sub metering", xlab = "", yaxt="n")
axis(2, at = seq(0, 30, by = 10))
lines(x=mydata_t$Datetime, y=mydata_t$Sub_metering_1, col = "black")
lines(x=mydata_t$Datetime, y=mydata_t$Sub_metering_2, col = "red")
lines(x=mydata_t$Datetime, y=mydata_t$Sub_metering_3, col = "blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

# Botton right graphic
plot(x=mydata_t$Datetime, y=mydata_t$Global_reactive_power, type = "l", 
     ylim = c(0.0,0.5), ylab = "Global_reactive_power", xlab = "datetime", yaxt="n")
axis(2, at = c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5))


dev.off()

