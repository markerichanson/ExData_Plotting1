library(data.table)
NA_STRS="?"
suppressWarnings(DT<-fread(".\\household_power_consumption.txt",na.strings=NA_STRS))

par(mfrow = c(2, 2))
#par(mar=c(5.1,4.1,2.1,2.1))

###
###
### plot for upper left hand corner
working<-data.table(DT$Date,DT$Time,DT$Global_active_power)
setkey(working,V1)
working<-working[c("1/2/2007","2/2/2007"),]
working<-working[!is.na(working$V3)]
working$V3<-as.numeric(working$V3)
working[,dateTime:={working[,as.POSIXct(strptime(paste(V1,V2),format="%d/%m/%Y %H:%M:%S"))]}]

xlab_<-""
ylab_<-"Global Active Power"
par(ps=12)
type_="l"


plot(working[,dateTime],working[,V3],xlab=xlab_,ylab=ylab_,type=type_)

###
###
### plot for upper right hand corner
working<-data.table(DT$Date,DT$Time,DT$Voltage)
setkey(working,V1)
working<-working[c("1/2/2007","2/2/2007"),]
working<-working[!is.na(working$V3)]
working$V3<-as.numeric(working$V3)
working[,dateTime:={working[,as.POSIXct(strptime(paste(V1,V2),format="%d/%m/%Y %H:%M:%S"))]}]

xlab_<-"date/time"
ylab_<-"Voltage"
par(ps=12)
type_="l"


plot(working[,dateTime],working[,V3],xlab=xlab_,ylab=ylab_,type=type_)


###
###
### plot for lower left hand corner
working<-data.table(DT$Date,DT$Time,DT$Sub_metering_1,DT$Sub_metering_2,DT$Sub_metering_3)
setkey(working,V1)
working<-working[c("1/2/2007","2/2/2007"),]
working<-working[!is.na(working$V3)]
working$V3<-as.numeric(working$V3)
working[,dateTime:={working[,as.POSIXct(strptime(paste(V1,V2),format="%d/%m/%Y %H:%M:%S"))]}]

xlab_<-""
ylab_<-"Energy sub metering"
par(ps=12)
type_="l"

this<-plot(working[,dateTime],working[,V3],xlab=xlab_,ylab=ylab_,type=type_)
lines(working[,dateTime],working[,V4],col="red")
lines(working[,dateTime],working[,V5],col="blue")
## to whomever reviews my code... if I use "topright" for the position when rendered in R Studio, 
## the legend is in the right place but when rendered to png, the right-most text is cut off.
## I've used "top" to guarantee legibility.
legend("top",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       box.lty=0, lty=1,col=c("black","red","blue"),y.intersp=.75,cex=.7,xjust=0)
box()


###
###
### plot for lower right hand corner
working<-data.table(DT$Date,DT$Time,DT$Global_reactive_power)
setkey(working,V1)
working<-working[c("1/2/2007","2/2/2007"),]
working<-working[!is.na(working$V3)]
working$V3<-as.numeric(working$V3)
working[,dateTime:={working[,as.POSIXct(strptime(paste(V1,V2),format="%d/%m/%Y %H:%M:%S"))]}]

xlab_<-"date/time"
ylab_<-"Global_reactive_power"
par(ps=12)
type_="l"


plot(working[,dateTime],working[,V3],xlab=xlab_,ylab=ylab_,type=type_)


dev.copy(png,file="plot4.png")
dev.off()
