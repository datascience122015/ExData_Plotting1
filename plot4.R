### download .zip file and unzip it
library(sqldf)
# part by part reading - Dates - 1/2/2007 & 2/2/2007
r1<-read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date = '1/2/2007' ",sep = ";")
r2<-read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date = '2/2/2007' ",sep = ";")

wdata<-rbind(r1,r2) ## row binding

### getting datetime
library(chron)
wdata$datetime <- chron(dates=as.character(wdata$Date),
                        times=wdata$Time,format=c('d/m/y', 'h:m:s')) 
#### Plotting 4 #################################################################################
png(file="plot4.png",width=480,height=480)

plot.new()
par(mfcol=c(2,2), mar=c(4,4,2,1))
with(wdata, {
  {
    plot(Global_active_power ~ datetime, data=wdata, type="l", xaxt="n",xlab = "",ylab ="Global Active Power (killowatts)")
    axis.Date(1,datetime,format="%a", labels = T,
              at=c(seq(datetime[1], datetime[length(datetime)]+7,1)), tck = +0.01)
  }
  {
  par(mar=c(4,4,2,1))
  lmin<-min(Sub_metering_1,Sub_metering_2,Sub_metering_3)
  lmax<-max(Sub_metering_1,Sub_metering_2,Sub_metering_3)
  plot(Sub_metering_1 ~ datetime, data=wdata, type="l", xaxt="n",xlab = "",ylab ="Energy Sub metering", ylim=c(lmin,lmax))
  par(new=T)
  plot(Sub_metering_2 ~ datetime, data=wdata, type="l", xaxt="n",xlab = "",ylab ="Energy Sub metering", ylim=c(lmin,lmax),col="red")
  par(new=T)
  plot(Sub_metering_3 ~ datetime, data=wdata, type="l", xaxt="n",xlab = "",ylab ="Energy Sub metering", ylim=c(lmin,lmax),col="blue")
  ## x-axis
  axis.Date(1,datetime,format="%a", labels = T,
            at=c(seq(datetime[1], datetime[length(datetime)]+7,1)), tck = +0.01)
  
  ## legend
  legend("topright",xjust=1 , lty=c(1,1), adj=0.1,x.intersp = 2,bty = "n",
         col=c("black","red","blue"), 
         legend = c(names(wdata)[7],names(wdata)[8],names(wdata)[9] ) )
  }
  {
  plot(Voltage ~ datetime, data=wdata, type="l", xaxt="n",xlab = "")
  axis.Date(1,datetime,format="%a", labels = T,
            at=c(seq(datetime[1], datetime[length(datetime)]+7,1)), tck = +0.01)
  }
  {
  plot(Global_reactive_power ~ datetime, data=wdata, type="l", xaxt="n",xlab = "")
  axis.Date(1,datetime,format="%a", labels = T,
            at=c(seq(datetime[1], datetime[length(datetime)]+7,1)), tck = +0.01)
  }
  
})

dev.off()
