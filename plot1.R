### download .zip file and unzip it
library(sqldf)
# part by part reading - Dates - 1/2/2007 & 2/2/2007
r1<-read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date = '1/2/2007' ",sep = ";")
r2<-read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date = '2/2/2007' ",sep = ";")

wdata<-rbind(r1,r2) ## row binding

#### Plotting 1 & saving #################################################################################

png(file="plot1.png",width=480,height=480)

plot.new()
par(mfcol=c(1,1), mar=c(5.6,4.1,4.1,2.1))
hist(wdata$Global_active_power, col="red",xlab ="Global Active Power (killowatts)", main = "Global Active Power" )

dev.off()




