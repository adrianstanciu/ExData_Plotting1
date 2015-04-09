path <- "C:/household_power_consumption.txt"

# Preliminary data exploration
#
#df <- read.csv(file = path, sep = ";", na.strings="NA", nrows = 100)
#head(df)
#summary(df)
#
# determine lines to read from the CSV
#lines <- readLines(path)
#start <- grep("1/2/2007", lines)[1] # 66638

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

# Plot 1 Global Active Power
png('plot1.png', width=480, height=480)

hist(df$Global_active_power,
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     col="red")

dev.off()