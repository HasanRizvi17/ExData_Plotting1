# we could have directly seperated the values into columns when reading the data
#  <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings=c("?"), colClasses=c("character", "character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
# na.strings=c("?") is to indicate that the missing values are indicated by "?" in this data set

#------

hpc <- read.table("household_power_consumption.txt", header = TRUE)

names(hpc) <- "x"

# splitting the one column into nine seperate columns for each variable
library(tidyr)
hpc <- separate(hpc, x, c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                           "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                           "Sub_metering_3"), ";")

sub_hpc <- hpc[(hpc$Date=="1/2/2007" | hpc$Date=="2/2/2007"), ]

# converting dates and times to the right format
sub_hpc$Date <- as.Date(sub_hpc$Date, "%d/%m/%Y")
sub_hpc$Time <- as.POSIXct(paste(sub_hpc$Date, sub_hpc$Time, sep=" ")) 

sub_hpc$Global_active_power <- as.numeric(sub_hpc$Global_active_power)
sub_hpc$Global_reactive_power <- as.numeric(sub_hpc$Global_reactive_power)
sub_hpc$Voltage <- as.numeric(sub_hpc$Voltage)
sub_hpc$Global_intensity <- as.numeric(sub_hpc$Global_intensity)
sub_hpc$Sub_metering_1 <- as.numeric(sub_hpc$Sub_metering_1)
sub_hpc$Sub_metering_2 <- as.numeric(sub_hpc$Sub_metering_2)
sub_hpc$Sub_metering_3 <- as.numeric(sub_hpc$Sub_metering_3)

str(sub_hpc)

# PLOT 1
#--------
par(mfrow=c(1,1), mar=c(5,5,4,2))
hist(sub_hpc$Global_active_power, col="red", breaks=20, 
     xlab = "Global Active Power (kilowatts)", main="Global Active Power")
dev.copy(png, file = "plot1.png")
dev.off()

# PLOT 2
#--------
plot(sub_hpc$Time, sub_hpc$Global_active_power, xlab="", 
     ylab="Global Active Power (kilowatts)", type="l")
dev.copy(png, file = "plot2.png")
dev.off()

# PLOT 3
#--------
with(sub_hpc, plot(Time, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l"))
with(sub_hpc, points(Time, Sub_metering_2, col="red", type="l"))
with(sub_hpc, points(Time, Sub_metering_3, col="blue", type="l"))
legend("topright", lwd=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png")
dev.off()

# PLOT 4
#--------
par(mfcol=c(2,2))
# 1
plot(sub_hpc$Time, sub_hpc$Global_active_power, xlab="", 
     ylab="Global Active Power (kilowatts)", type="l")
# 2
with(sub_hpc, plot(Time, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l"))
with(sub_hpc, points(Time, Sub_metering_2, col="red", type="l"))
with(sub_hpc, points(Time, Sub_metering_3, col="blue", type="l"))
legend("topright", lwd=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
# 3
with(sub_hpc, plot(Time, Voltage, xlab="datetime", ylab="Voltage", type="l"))
# 4
with(sub_hpc, plot(Time, Global_reactive_power, xlab="datetime", 
                   ylab="Global_reactive_power", type="l"))
dev.copy(png, file = "plot4.png")
dev.off()













