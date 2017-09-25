#Leemos los datos
library(data.table)
select <- 1:3
colnames <- names(fread("household_power_consumption.txt", nrows = 0, header = T, select = select))
data <- fread("household_power_consumption.txt", nrows = 2880, header = F,
              na.strings = "?", skip = "1/2/2007", select = select, col.names = colnames, data.table = F)
head(data)
tail(data)

#Unimos Date y Time
library(tidyr)
data <- unite(data, Date_Time, Date, Time, sep = " ")
data$Date_Time <- strptime(data$Date_Time, "%d/%m/%Y %H:%M:%S")

#Plot 2
png("plot2.png")
plot(data$Date_Time, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active power (kilowatts)")
dev.off()