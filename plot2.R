## reads in household power consumption data from txt file in the wd
## subsets dates of interest
## plots Global Active Power by date/time, saves to plot2.png file

elec <- read.table("household_power_consumption.txt", sep = ";",
                   na.strings = "?", header = TRUE, stringsAsFactors = FALSE)
elec$Global_active_power <- as.numeric(elec$Global_active_power)
elec$Date2 <- as.Date(elec$Date, "%d/%m/%Y")
elec <- elec[elec$Date2 >= '2007-02-01' & elec$Date2 <= '2007-02-02',]
elec$dateandtime <- strptime(paste(elec$Date, elec$Time), "%d/%m/%Y %H:%M")
elec$datetime <- max(elec$dateandtime) - min(elec$dateandtime)
plot(elec$Global_active_power ~ elec$datetime, type = "l", xaxt = 'n',
     xlab = "", ylab = "Global Active Power", cex.axis = 0.7,
     cex.lab = 0.7)
labels = c("Wed", "Thu", "Fri")
axis(side = 1, at = c(0, median(elec$datetime), max(elec$datetime)),
        labels = labels, cex.axis = 0.7)
dev.copy(png, file = "plot2.png", width = 480, height = 480) # png file
dev.off() ## must close device