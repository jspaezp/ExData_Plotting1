## flots four particular graphs in on a single png file
## every graph (plot) is defined as a separate funcion and then in the device
## they are called one at a time to generate the png file


opendata <- function() {  
      ## opens the data file in ""household_power_consumption.txt"" from the working 
      ## directory and assigns the appropiate data class to each collumn, 
      ## reads at fist the approximate position of the data of interest, then selects it
      ## and saves in RAM only from 1/2/2007 to 2/2/2007
      ## merges in collumn 1 date and time 
      
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

plot2 <- function() {  ##comments in "plot2.R"
      plot(as.POSIXlt(data$date),data[,3],type = "l",xlab = "", 
      ylab ="Global Active Power")    
}

plot3 <- function () {   ##comments in "plot3.R"
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

data <- suppressWarnings(opendata())  #generates data frame

png("plot4.png")
par(mfcol = c(2,2))         #generates 2x2 "grid" for plots
plot2()                     #plot on top left
plot3()                     #plot on lower left
plot4()                     #plot on upper right
plot5()                     #plot on lower right
dev.off()   