#script to plot a line plot from a particular data file
#assignment for exdata-005

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

#this part generates the plot itself

png("plot3.png")
data <- suppressWarnings(opendata())
plot(as.POSIXlt(data$date),data$Sub_metering_1, 
     type = "n", xlab = "", ylab ="Energy sub metering")    #generates axes and names and "frame" (no data) 
points(as.POSIXlt(data$date), data$Sub_metering_1, type = "l")   #generates the black line (sub metering 1)
points(as.POSIXlt(data$date), data$Sub_metering_2, type = "l", col = "red")    #generates the red line (sub metering 2)
points(as.POSIXlt(data$date), data$Sub_metering_3, type = "l", col = "blue")     #generates the red line (sub metering 3)
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),   #generates the legend and assigns its size
       lwd=2, col = c("black", "red", "blue"))
dev.off()      


#generates the file directly (not seen in screen)