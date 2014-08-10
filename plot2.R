#script to plot a line plot from a particular data file
#assignment for exdata-005

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
png("plot2.png")
data <- suppressWarnings(opendata())
plot(as.POSIXlt(data$date),data[,3],type = "l",xlab = "", 
     ylab ="Global Active Power (kilowatts)")
dev.off()      
