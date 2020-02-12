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
with(requiredData, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=1, lwd=1)
##Save as PNG
dev.copy(png, file="plot3.png", height=480, width=800)
dev.off()