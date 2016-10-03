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


# open png device, create 'plot3.png' file in work dir
png(filename = "plot3.png", width = 480, height = 480, units = "px")

# create plot but get short names of weakday on local lang (Russian)
with(dd, plot(dd$Date, dd$Sub_metering_1, type = "n", xlab = "", 
              ylab = "Energy sub metening", col = "black")
)
with(dd, lines(dd$Date, dd$Sub_metering_1, col = "black"))
with(dd, lines(dd$Date, dd$Sub_metering_2, col = "red"))
with(dd, lines(dd$Date, dd$Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))



# close png device
dev.off()
