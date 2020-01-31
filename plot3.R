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

# Plot
plot(filtered$Date_Time, filtered$Sub_metering_1, 
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(filtered$Date_Time, filtered$Sub_metering_1, col = "black")
lines(filtered$Date_Time, filtered$Sub_metering_2, col = "red")
lines(filtered$Date_Time, filtered$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)

dev.copy(png, "plot3.png", width = 480, height = 480, units = "px")
dev.off()
