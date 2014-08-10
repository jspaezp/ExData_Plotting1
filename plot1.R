#script to plot a particular histogram from a particular data file
#assignment for exdata-005

opendata <- function() {  
      ## opens the data file in ""household_power_consumption.txt"" from the working 
      ## directory and assigns the appropiate data class to each collumn, 
      
      dataclasses <- c("character","character","numeric","numeric","numeric",
                       "numeric","numeric","numeric","numeric")
      datanames <- read.table("household_power_consumption.txt", TRUE, ";", 
                              nrows = 1)
      data <- read.table("household_power_consumption.txt", TRUE, ";",
                        nrows = 50000, skip = 60000, col.names = (colnames(datanames))
                        ,colClasses = dataclasses, na.strings = "?")
      
      wknd1 <- data.frame(data[(("1/2/2007" == data[,1])|("2/2/2007" == data[,1])),])
      return(wknd1)
}
      png("plot1.png")
      data <- suppressWarnings(opendata())
      hist(data[,3], col = "red", main = "Global Active Power",
           xlab = "Global Active Power (kilowatts)")
      dev.off()      

