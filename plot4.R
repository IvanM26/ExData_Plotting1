library(data.table)
library(lubridate)

# Read the data
data <- fread("household_power_consumption.txt")

# Data structure
str(data)

#Create Date_Time
data$Date_Time <- dmy_hms(paste(data$Date, data$Time))

# Fix variable types
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)
data[,c(3:8)] <- lapply(data[,c(3:8)], as.numeric)

# Filter dates
filtered <- data[data$Date == ymd("2007-02-01")|
                   data$Date == ymd("2007-02-02"), ]

# Plots
par(mfrow = c(2,2), mar = c(4, 4, 3, 2))

  # Plot 1
plot(filtered$Date_Time, filtered$Global_active_power, 
     type = "n",
     xlab = "",
     ylab = "Global Active Power")
lines(filtered$Date_Time, filtered$Global_active_power)

  # Plot 2
plot(filtered$Date_Time, filtered$Voltage, 
     type = "n",
     xlab = "datetime",
     ylab = "Voltage")
lines(filtered$Date_Time, filtered$Voltage)

  # Plot 3
plot(filtered$Date_Time, filtered$Sub_metering_1, 
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(filtered$Date_Time, filtered$Sub_metering_1, col = "black")
lines(filtered$Date_Time, filtered$Sub_metering_2, col = "red")
lines(filtered$Date_Time, filtered$Sub_metering_3, col = "blue")
legend("topright", 
       col = c("black", "red", "blue"), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, 
       bty = "n",
       cex = 0.75)

  # Plot 4
plot(filtered$Date_Time, filtered$Global_reactive_power, 
     type = "n",
     ylab = "Global_reactive_power",
     xlab = "datetime")
lines(filtered$Date_Time, filtered$Global_reactive_power)


dev.copy(png, "plot4.png", width = 480, height = 480, units = "px")
dev.off()

