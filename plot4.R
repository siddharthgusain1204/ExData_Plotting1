#Load the data
data<-read.table("household_power_consumption.txt",sep = ";",header = TRUE,stringsAsFactors = FALSE)

#Filter with dates
data<-subset(data,Date %in% c("1/2/2007","2/2/2007"))

#Replace all ?s with NAs
data<-replace_with_na(data,replace = list("?"))

#Add new column with date and time and change class
data<-mutate(data,Date=paste(data$Date,data$Time))
data<-select(data,-Time)
data$Date<-dmy_hms(data$Date)

#plot4
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))
data$Voltage<-as.numeric(as.character(data$Voltage))
data$Sub_metering_1<-as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2<-as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3<-as.numeric(as.character(data$Sub_metering_3))
data$Global_reactive_power<-as.numeric(as.character(data$Global_reactive_power))
png("plot4.png",height = 480,width = 480)
par(mfrow=c(2,2))
plot(data$Date,data$Global_active_power,type = "l",xlab = "",ylab = "Global Active Power (kilowatts)",main = "")
plot(data$Date,data$Voltage,type = "l",xlab = "datetime",ylab = "Voltage",main = "")
plot(data$Date,data$Sub_metering_1,type = "l",ylab = "Energy sub metering",xlab = "")
lines(data$Date,data$Sub_metering_2,type = "l",col="red")
lines(data$Date,data$Sub_metering_3,type = "l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1,lwd = 2.5,col = c("black","red","blue"))
plot(data$Date,data$Global_reactive_power,type = "l",xlab = "datetime",ylab = "Global_reactive_power",main = "")
dev.off()
