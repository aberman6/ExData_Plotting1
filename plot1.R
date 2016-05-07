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
data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")
#formatting
power <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"), ]
power$Global_active_power <- as.numeric(power$Global_active_power)
par(cex = 0.75)

#plot
hist(power$Global_active_power, col = "red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")

#create png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
