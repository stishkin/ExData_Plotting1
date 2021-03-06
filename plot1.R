#reads data from household_power_consumption.txt file between dates 2007-02-01 and 2007-02-02
#converts date and time fields to date and time objects
#returns the dataframe with the column names col_names defined in the function
read_data <- function(){
  col_names <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intenstiy", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  
  data <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", skip = 66638, nrows=2880, na.strings=c("?"), col.names = col_names)
  
  dt <- paste(data$Date, data$Time,  sep = " ")
  t <- lapply(dt, function(d) strptime(d, "%d/%m/%Y %T"))
  data$Time <- t
  dates <- lapply(data$Date, function(x){as.Date(x, format = "%d/%m/%Y")})
  data$Date <- dates
  return(data)
}

plot.new()
d <- read_data()
png(filename="plot1.png", width=480, height=480)
hist(d$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power", ylim = range(0 : 1200))
dev.off()
