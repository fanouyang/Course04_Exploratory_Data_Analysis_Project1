data <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                 nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data1 <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))


data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
data1$Time <- strptime(data1$Time, format="%H:%M:%S")
data1[1:1440,"Time"] <- format(data1[1:1440,"Time"],"2007-02-01 %H:%M:%S")
data1[1441:2880,"Time"] <- format(data1[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
data1$GlobalActivePower <- as.numeric(as.character(data1$Global_active_power))


par(mfrow=c(2,2))
with(data1,{
  plot(data1$Time,as.numeric(as.character(data1$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(data1$Time,as.numeric(as.character(data1$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(data1$Time,data1$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(data1,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(data1,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(data1,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(data1$Time,as.numeric(as.character(data1$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
