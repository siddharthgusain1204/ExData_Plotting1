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

#plot2
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))
png("plot2.png",height = 480,width = 480)
plot(data$Date,data$Global_active_power,type = "l",xlab = "",ylab = "Global Active Power (kilowatts)",main = "")
dev.off()

