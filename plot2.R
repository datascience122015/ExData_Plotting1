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
#### Plotting 2 #################################################################################
png(file="plot2.png",width=480,height=480)

plot.new()
par(mfcol=c(1,1), mar=c(5.6,4.1,4.1,2.1))
plot(Global_active_power ~ datetime, data=wdata, type="l", xaxt="n",xlab = "",ylab ="Global Active Power (killowatts)")
## changing x-axis ticks
axis.Date(1,wdata$datetime,format="%a", labels = T,
          at=c(seq(wdata$datetime[1], wdata$datetime[length(wdata$datetime)]+7,1)), tck = +0.01)

dev.off()


