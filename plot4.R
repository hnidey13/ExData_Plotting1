#Leemos los datos
library(data.table)
select <- (1:9)[-6]
colnames <- names(fread("household_power_consumption.txt", nrows = 0, header = T, select = select))
data <- fread("household_power_consumption.txt", nrows = 2880, header = F,
              na.strings = "?", skip = "1/2/2007", select = select, col.names = colnames, data.table = F)
head(data)
tail(data)

#Unimos Date y Time
library(tidyr)
data <- unite(data, Date_Time, Date, Time, sep = " ")
data$Date_Time <- strptime(data$Date_Time, "%d/%m/%Y %H:%M:%S")
head(data)

#Plot 4
png("plot4.png")
par(mfrow = c(2,2))
with(data,{
  plot(Date_Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active power")
  plot(Date_Time, Voltage, type = "l")
  plot(Date_Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
  lines(Date_Time, Sub_metering_1)
  lines(Date_Time, Sub_metering_2, col = "red")
  lines(Date_Time, Sub_metering_3, col = "blue")
  legend("topright", legend = names(data)[-(1:4)], col = c("black", "red", "blue"), lty = 1)
  plot(Date_Time, Global_reactive_power, type = "l")
})
dev.off()