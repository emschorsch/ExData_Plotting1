names <- read.csv2("../household_power_consumption.txt", header=FALSE, nrows=1)
names <- as.character(unname(unlist(names)))

dat<-read.table("../household_power_consumption.txt", na.strings='?', sep=";",
                header=TRUE, skip=66635, nrows=69517-66335, col.names=names)

dat$DateTime <- strptime(paste(dat$Date,dat$Time), "%d/%m/%Y %H:%M:%S")

dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")

dat2<-subset(dat, (Date >= as.Date('2007/02/01')) & (Date <= as.Date('2007/02/02')))

dat2$Date<-dat2$DateTime
dat2<-subset(dat2, Global_active_power != '?')

#plot 3
png("plot3.png",  width = 480, height = 480, units = "px")
with(dat2, { plot(Date, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
             lines(Date, Sub_metering_2, type="l", col="blue")
             lines(Date, Sub_metering_3, type="l", col="red")
})
legend("topright", pch = 1, col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()