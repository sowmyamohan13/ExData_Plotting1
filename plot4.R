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
dateTime<-paste(requiredData$Date,requiredData$Time)
requiredData$DateTime <-as.POSIXct(dateTime)

##Plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(requiredData, {
  plot(requiredData$Global_active_power~requiredData$DateTime ,type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(requiredData$Voltage~requiredData$DateTime, type="l",
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright"
         , col=c("black","red","blue")
         , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
         ,lty=1, lwd=1)
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global_reactive_power (kilowatts)",xlab="datetime")
})

##Save as PNG
dev.copy(png, file="plot4.png", height=480, width=800)
dev.off()