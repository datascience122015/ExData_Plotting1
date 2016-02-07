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
#### Plotting 3 #################################################################################
png(file="plot3.png",width=480,height=480)

plot.new()
par(mfcol=c(1,1),par(mar=c(4,4,2,1)),oma=c(1,0,0,2))

lmin<-min(wdata$Sub_metering_1,wdata$Sub_metering_2,wdata$Sub_metering_3)
lmax<-max(wdata$Sub_metering_1,wdata$Sub_metering_2,wdata$Sub_metering_3)
with (wdata,plot(datetime, Sub_metering_1 ,  
                 type="l", xaxt="n",xlab = "",ylab ="Energy Sub metering", ylim=c(lmin,lmax)))
par(new=T)
with(wdata, plot(datetime,Sub_metering_2, 
                 type="l", xaxt="n",xlab = "",ylab ="Energy Sub metering", ylim=c(lmin,lmax),col="red"))
par(new=T)
with(wdata, plot(datetime,Sub_metering_3,
                 type="l", xaxt="n",xlab = "",ylab ="Energy Sub metering", ylim=c(lmin,lmax),col="blue"))
## x-axis
axis.Date(1,wdata$datetime,format="%a", labels = T,
          at=c(seq(wdata$datetime[1], wdata$datetime[length(wdata$datetime)]+7,1)), tck = +0.01)

## legend
legend("topright",xjust=1 , lty=c(1,1), adj=0.1,x.intersp = 2,
       col=c("black","red","blue"), 
       legend = c(names(wdata)[7],names(wdata)[8],names(wdata)[9] ) )


dev.off()


