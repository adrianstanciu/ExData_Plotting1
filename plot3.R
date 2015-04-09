path <- "C:/household_power_consumption.txt"

# read header
header <- read.table(path, nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)

# read CSV
# use previously calculated indexes to read only the needed subset from the file (much faster on my computer)
start <- 66638 - 1 # substract 1 for header
size <- 60 * 24 * 2 # 60 records per hour times 24 hours times 2 days
df <- read.csv(file = path, sep = ";", na.strings = "?",
               nrows = size, header = F, skip = start,
               # use this occasion to define column types
               colClasses = c("character","character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
colnames(df) <- unlist(header)

# convert date and time into a new column
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

# Plot 3 Sub-metterings per day
png('plot3.png', width=480, height=480)

Sys.setlocale("LC_TIME", "English")
plot(x = df$DateTime, y = df$Sub_metering_1, type = "l", col="black",
     xlab = "", ylab = "Energy sub metering")
points(x = df$DateTime, y = df$Sub_metering_2, type = "l", col="red")
points(x = df$DateTime, y = df$Sub_metering_3, type = "l", col="blue")
legend("topright",
       lty = c(1, 1, 1), pch = c(NA, NA, NA),
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()