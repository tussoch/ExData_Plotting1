## reads in household power consumption data from txt file in the wd
## subsets dates of interest
## Four plots (2 x 2) saved to plot4.png file

elec <- read.table("household_power_consumption.txt", sep = ";",
                   na.strings = "?", header = TRUE, stringsAsFactors = FALSE)
elec$Global_active_power <- as.numeric(elec$Global_active_power)
elec$Date2 <- as.Date(elec$Date, "%d/%m/%Y")
elec <- elec[elec$Date2 >= '2007-02-01' & elec$Date2 <= '2007-02-02',]
elec$dateandtime <- strptime(paste(elec$Date, elec$Time), "%d/%m/%Y %H:%M")
elec$datetime <- max(elec$dateandtime) - min(elec$dateandtime)

par(mfrow = c(2,2))

# 1st plot
plot(elec$Global_active_power ~ elec$datetime, type = "l", xaxt = 'n',
     xlab = "", ylab = "Global Active Power", cex.axis = 0.7,
     cex.lab = 0.7)
labels = c("Wed", "Thu", "Fri")
axis(side = 1, at = c(0, median(elec$datetime), max(elec$datetime)),
     labels = labels, cex.axis = 0.7)

# 2nd plot
plot(elec$Voltage ~ elec$datetime, type = "l", xaxt = 'n',
     xlab = "datetime", ylab = "Voltage", cex.axis = 0.7,
     cex.lab = 0.7)
#labels = c("Wed", "Thu", "Fri")
axis(side = 1, at = c(0, median(elec$datetime), max(elec$datetime)),
     labels = labels, cex.axis = 0.7)

# 3rd plot
plot(elec$Sub_metering_1 ~ elec$datetime, type = "l", xaxt = 'n',
     xlab = "", ylab = "Energy sub metering", cex.axis = 0.7,
     cex.lab = 0.7)
labels = c("Wed", "Thu", "Fri")
axis(side = 1, at = c(0, median(elec$datetime), max(elec$datetime)),
     labels = labels, cex.axis = 0.7)
lines(elec$Sub_metering_2 ~ elec$datetime, col = "red")
lines(elec$Sub_metering_3 ~ elec$datetime, col = "blue")
legend(95000, 39, c(names(elec[7:9])),
        lty = c(1, 1, 1), lwd = c(1, 1, 1),
        col = c("black", "red", "blue"),
        cex = 0.6, bty = 'n')

# 4th plot
plot(elec$Global_reactive_power ~ elec$datetime, type = "l",
     xaxt = 'n', ylab = "Global_reactive_power",
     xlab = "datetime", cex.axis = 0.7,
     cex.lab = 0.7)
#labels = c("Wed", "Thu", "Fri")
axis(side = 1, at = c(0, median(elec$datetime), max(elec$datetime)),
     labels = labels, cex.axis = 0.6)


dev.copy(png, file = "plot4.png", width = 480, height = 480) # png file
par(mfrow = c(1,1))
dev.off() ## must close device
