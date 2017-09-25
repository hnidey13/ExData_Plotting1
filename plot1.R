#Leemos los datos
library(data.table)
select <- 3
colnames <- names(fread("household_power_consumption.txt", nrows = 0, header = T, select = select))
data <- fread("household_power_consumption.txt", nrows = 2880, header = F,
              na.strings = "?", skip = "1/2/2007", select = select, col.names = colnames, data.table = F)
head(data)
tail(data)

#Plot 1
png("plot1.png")
hist(data$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowats)", col = "red")
dev.off()