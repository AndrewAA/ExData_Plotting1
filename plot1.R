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

dd[,"Date"] <- as.Date(dd[,"Date"], "%d/%m/%Y") 

# open png device, create 'plot1.png' file in work dir
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# create histogram
hist(dd$Global_active_power, col = "red", main = "Global Active Power"
     , xlab = "Global Active Power (kilowatts)"
     , ylim = c(0, 1200))  

# close png device
dev.off()

