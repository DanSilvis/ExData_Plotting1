#Load in data
f <- "./data/household_power_consumption.txt"
df <- read.table(f, header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings="?")

#Convert to Date class for subsetting
df$Date <- as.Date(df$Date, format="%d/%m/%Y")

#Subset df to desired date range
data <- subset(df, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#Create datetime attribute
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

#Create Plot 1
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

#Save to PNG
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
