
zipfile <- "data.zip"
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datafile <- "household_power_consumption.txt"


# verifies the data zip file has been downloaded
if(!file.exists(zipfile)){
  
  ##Downloads the data file
  print("downloading Data")
  download.file(url,zipfile, mode = "wb")
  
}

##reads a table from the zip data file
getTable <- function (){
  
  print(paste("Getting table:", datafile))
  
  f <- unz(zipfile, datafile)
  
  fieldClass <- c(rep("character", 2),rep("numeric",7))
  
  data <- read.table(f, sep=";", header=T, colClasses = fieldClass, na.strings = "?")
  ?read.table
  data  
}

# getting data from zip file
table <- getTable()

# Select dataset to work with
dates <- c('1/2/2007','2/2/2007')

dt <- table[table$Date %in% dates,]


dt$DateTime <- strptime(paste(dt$Date, dt$Time),
                        format = "%d/%m/%Y %H:%M:%S")


png (filename ="plot3.png",  width = 480 , height = 480, units = "px")


plot(dt$DateTime, dt$Sub_metering_1, type ="n", main = "", xlab = "", ylab = "Energy sub metering")
points(dt$DateTime, dt$Sub_metering_1, type ="l")
points(dt$DateTime, dt$Sub_metering_2, type ="l", col = "red")
points(dt$DateTime, dt$Sub_metering_3, type ="l", col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("Black", "Red", "Blue"), lty = 1)

dev.off()




