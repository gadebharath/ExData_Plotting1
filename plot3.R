#Get Input Data
imported <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
imported$Timestamp <- strptime(paste(imported$Date,imported$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
start_date <- strptime("2007-02-01 00:00:00", "%Y-%m-%d  %H:%M:%S")
end_date <- strptime("2007-02-02 23:59:59", "%Y-%m-%d  %H:%M:%S")
imported$data_in_range <- (imported$Timestamp>=start_date & imported$Timestamp <=end_date)
input_data <- subset(imported, data_in_range == TRUE)

#Converting numeric data
input_data$Global_active_power <- as.numeric(as.character(input_data$Global_active_power))
input_data$Sub_metering_1 <- as.numeric(as.character(input_data$Sub_metering_1))
input_data$Sub_metering_2 <- as.numeric(as.character(input_data$Sub_metering_2))
input_data$Sub_metering_3 <- as.numeric(as.character(input_data$Sub_metering_3))
input_data$Global_reactive_power <- as.numeric(as.character(input_data$Global_reactive_power))

#plot3
png(filename = "plot3.png", width = 480, height = 480, units = "px")
with(input_data, plot(Timestamp, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = ""))
with(input_data, points(Timestamp, Sub_metering_2, type="l", col="red"))
with(input_data, points(Timestamp, Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col = c("black","red", "blue"))
dev.off()
