#Leemos los datos
library(data.table)
select <- c(1,2,7:9)
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

#Plot 3
png("plot3.png")
plot(data$Date_Time, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
with(data, lines(Date_Time, Sub_metering_1))
with(data, lines(Date_Time, Sub_metering_2, col = "red"))
with(data, lines(Date_Time, Sub_metering_3, col = "blue"))
legend("topright", legend = names(data)[-1], col = c("black", "red", "blue"), lty = 1)
dev.off()