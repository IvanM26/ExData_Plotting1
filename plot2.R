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
plot(filtered$Date_Time, filtered$Global_active_power, 
     type = "n",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(filtered$Date_Time, filtered$Global_active_power)


dev.copy(png, "plot2.png", width = 480, height = 480, units = "px")
dev.off()
