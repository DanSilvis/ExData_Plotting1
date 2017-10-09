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

#Create Plot 4
par(mfrow=c(2,2))

with(data, {
  plot(Global_active_power~datetime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~datetime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~datetime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

#Save to PNG
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
