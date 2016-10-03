# in work dir must be the file household_power_consumption.txt !!!!!!!!!!!!

# load only 2 row for get colunm name of data
dd <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                 dec = ".", row.names = NULL, na.strings = "?", nrow = 2
)
# get colonm names
cn <- colnames(dd)

# load only 2880 rows for date 1/2/2007 and 2/2/2007
dd <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                 dec = ".", row.names = NULL, na.strings ="?", col.names = cn,
                 skip = 66637, nrow = (69518-66637-1)
)
# in colunm Date create Date + Time as POSIXct
dd[, "Date"] <- as.Date(dd[, "Date"], "%d/%m/%Y")
dd[, "Date"] <- paste(dd[, "Date"], dd[, "Time"], sep=" ")
dd[, "Date"] <- as.POSIXct(dd[, "Date"])


# open png device, create 'plot4.png' file in work dir
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# create plot but get short names of weakday on local lang (Russian)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 1, 1, 0))
with(dd, {
    plot(dd$Date, dd$Global_active_power
         , type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    plot(dd$Date, dd$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", col = "black")
    plot(dd$Date, dd$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metening", col = "black")
    lines(dd$Date, dd$Sub_metering_1, col = "black")
    lines(dd$Date, dd$Sub_metering_2, col = "red")
    lines(dd$Date, dd$Sub_metering_3, col = "blue")
    legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(dd$Date, dd$Global_reactive_power, type = "l", xlab = "datetime",
         ylab = "Global_reactive_power", col = "black")
    
} )

# close png device
dev.off()