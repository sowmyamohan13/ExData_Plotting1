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

##Save as PNG
png("plot2.png",width = 480, height = 480)
##Plot
plot(requiredData$Global_active_power~requiredData$DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
dev.off()