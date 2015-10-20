## reads in household power consumption data from txt file in the wd
## subsets dates of interest
## plots histogram of Global Active Power, saves as plot1.png
elec <- read.table("household_power_consumption.txt", sep = ";",
        na.strings = "?", header = TRUE, stringsAsFactors = FALSE)
elec$Global_active_power <- as.numeric(elec$Global_active_power)
elec$Date2 <- as.Date(elec$Date, "%d/%m/%Y")
elec <- elec[elec$Date2 >= '2007-02-01' & elec$Date2 <= '2007-02-02',] 

png("Plot1.png", width = 480, height = 480)
hist(elec$Global_active_power, breaks = 12, xlim = c(0,7),
     col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", xaxt = 'n')
axis(side = 1, at = seq(0, 6, 2))
dev.off() ## must close device
