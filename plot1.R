library(data.table)
library(lubridate)

# Read the data
data <- fread("household_power_consumption.txt")

# Data structure
str(data)

# Fix variable types
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)
data[,c(3:8)] <- lapply(data[,c(3:8)], as.numeric)

# Filter dates
filtered <- data[data$Date == ymd("2007-02-01")|
                   data$Date == ymd("2007-02-02"), ]

# Plot histogram
hist(filtered$Global_active_power,
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, "plot1.png", width = 480, height = 480, units = "px")
dev.off()
