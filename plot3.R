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
par(cex = 0.75)

#plot
plot(power$dateTime, power$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering")
points(power$dateTime, power$Sub_metering_2 , type = "l", col = "red")
points(power$dateTime, power$Sub_metering_3 , type = "l", col = "blue")
legend("topright", legend = c("Sub-metering_1", "Sub-metering_2","Sub-metering_3"), lty=1, lwd=2 , col = c("black", "red", "blue"))
axis(1, xaxp=c(0, 30, 4), las=2)

#create png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

