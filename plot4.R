opendata <- function() {  
      ## opens the data file in ""household_power_consumption.txt"" from the working 
      ## directory and assigns the appropiate data class to each collumn, 
      ## merges en collumn 1 date and time
      
      dataclasses <- c("character","character","numeric","numeric","numeric",
                       "numeric","numeric","numeric","numeric")
      datanames <- read.table("household_power_consumption.txt", TRUE, ";", 
                              nrows = 1)
      data <- read.table("household_power_consumption.txt", TRUE, ";",
                         nrows = 50000, skip = 60000, col.names = (colnames(datanames))
                         ,colClasses = dataclasses, na.strings = "?")
      data <- data.frame(data[(("1/2/2007" == data[,1])|("2/2/2007" == data[,1])),])
      posixdates <- strptime((paste((data[,2]),(data[,1]))), "%H:%M:%S %d/%m/%Y")
      class(data$Date) <- "POSIXt"
      data$date <- posixdates
      return(data)
}

plot2 <- function() {
      plot(as.POSIXlt(data$date),data[,3],type = "l",xlab = "", 
      ylab ="Global Active Power")    
}

plot3 <- function () {
     plot(as.POSIXlt(data$date),data$Sub_metering_1,
           type = "n", xlab = "", ylab ="Energy sub metering")
      points(as.POSIXlt(data$date), data$Sub_metering_1, type = "l")
      points(as.POSIXlt(data$date), data$Sub_metering_2, type = "l", col = "red")
      points(as.POSIXlt(data$date), data$Sub_metering_3, type = "l", col = "blue")
      legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
      lwd=2, col = c("black", "red", "blue"))
}

plot4 <- function() {
      plot(as.POSIXlt(data$date),data$Voltage,type = "l", xlab = "datetime",
      ylab ="Voltage")
}

plot5 <- function() {
      plot(as.POSIXlt(data$date),data$Global_reactive_power,type = "l",
      ylab ="Global_reactive_power", xlab = "datatime")
}

data <- suppressWarnings(opendata())

png("plot4.png")
par(mfcol = c(2,2))
plot2()
plot3()
plot4()
plot5()
dev.off()   