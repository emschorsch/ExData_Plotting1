names <- read.csv2("../household_power_consumption.txt", header=FALSE, nrows=1)
names <- as.character(unname(unlist(names)))

dat<-read.table("../household_power_consumption.txt", na.strings='?', sep=";",
               header=TRUE, skip=66635, nrows=69517-66335, col.names=names)

dat$DateTime <- strptime(paste(dat$Date,dat$Time), "%d/%m/%Y %H:%M:%S")

dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")

dat2<-subset(dat, (Date >= as.Date('2007/02/01')) & (Date <= as.Date('2007/02/02')))

dat2$Date<-dat2$DateTime
dat2<-subset(dat2, Global_active_power != '?')

#plot 1
png("plot1.png",  width = 480, height = 480, units = "px")
hist(as.numeric(dat2$Global_active_power), col="red", main= "Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()





