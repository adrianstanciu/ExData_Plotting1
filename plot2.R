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

# Plot 2 Global Active Power by day
png('plot2.png', width=480, height=480)

Sys.setlocale("LC_TIME", "English")
plot(x = df$DateTime, y = df$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()