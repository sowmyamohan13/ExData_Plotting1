##Downloaded files

filename= "exdata_data_household_power_consumption.zip"

if(!file.exists("exdata_data_household_power_consumption")){
  unzip(filename)
}

##Read data
data<-read.table("./exdata_data_household_power_consumption/household_power_consumption.txt" ,
                 header = T,
                 sep=";" , 
                 na.strings = "?")
requiredData<- subset(data , Date %in% c("1/2/2007","2/2/2007"))
requiredData$Date <-as.Date(requiredData$Date ,format= "%d/%m/%Y")

##Plot
with(requiredData, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
##Save as PNG
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()