#Load in data
f <- "./data/household_power_consumption.txt"
df <- read.table(f, header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings="?")

#Convert to Date class for subsetting
df$Date <- as.Date(df$Date, format="%d/%m/%Y")

#Subset df to desired date range
data <- subset(df, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#Create datetime attribute
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
data$datetime <- as.POSIXct(data$datetime)

#Create Plot 3
with(data, {
  plot(Sub_metering_1~datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Save to PNG
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
