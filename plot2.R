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

#### Making Plots: No 2


png(filename = "plot2.png",
    width = 480, height = 480, units = "px", 
    bg = "transparent", antialias = "cleartype")

Sys.setlocale("LC_TIME", "English")
par(col = "black")
plot(x=mydata_t$Datetime, y=mydata_t$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)", main = "")

dev.off()