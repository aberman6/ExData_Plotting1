#get zip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "./electricPower.zip"
if(!file.exists(file)){
  print("getting data")
  download.file(fileUrl, destfile = file, method = "curl")
}

#unzip file
if(!file.exists("household_power_consumption.txt")){
  print("unzip file")
  unzip("./electricPower.zip", list = FALSE, overwrite = TRUE)
}

#read in txt file
data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors= FALSE, dec = ".")
power <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"), ]

#formatting
power$dateTime <- strptime(paste(power$Date, power$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
power$Global_active_power <- as.numeric(power$Global_active_power) 
par(mar = c(4,4,2,2))
par(mfrow = c(2,2))

#plot 1
plot(power$dateTime, power$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")

#plot 2
plot(power$dateTime, power$Voltage, type = "l", xlab = "datetime", ylab="Voltage")

#plot 3
plot(power$dateTime, power$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering")
points(power$dateTime, power$Sub_metering_2 , type = "l", col = "red")
points(power$dateTime, power$Sub_metering_3 , type = "l", col = "blue")
legend("topright", bty = "n", legend = c("Sub-metering_1", "Sub-metering_2","Sub-metering_3"), lty=1, lwd=2 , col = c("black", "red", "blue"), cex = .7)

#plot 4
plot(power$dateTime, power$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")


#create png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
